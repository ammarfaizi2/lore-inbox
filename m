Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVGPEvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVGPEvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 00:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVGPEuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 00:50:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:38360 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262221AbVGPEuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 00:50:06 -0400
Date: Fri, 15 Jul 2005 21:49:57 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.12.3
Message-ID: <20050716044957.GA10110@kroah.com>
References: <20050716044815.GA10063@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716044815.GA10063@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION = .2
+EXTRAVERSION = .3
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -89,6 +89,9 @@ unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
+/* used for timezone offset */
+static long timezone_offset;
+
 DEFINE_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
@@ -170,7 +173,7 @@ void timer_interrupt(struct pt_regs * re
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + timezone_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -286,7 +289,7 @@ void __init time_init(void)
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                timezone_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -331,10 +334,10 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 
 	/* If platform provided a timezone (pmac), we correct the time */
-        if (time_offset) {
-		sys_tz.tz_minuteswest = -time_offset / 60;
+        if (timezone_offset) {
+		sys_tz.tz_minuteswest = -timezone_offset / 60;
 		sys_tz.tz_dsttime = 0;
-		xtime.tv_sec -= time_offset;
+		xtime.tv_sec -= timezone_offset;
         }
         set_normalized_timespec(&wall_to_monotonic,
                                 -xtime.tv_sec, -xtime.tv_nsec);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -130,7 +130,7 @@ int start_fork_tramp(void *thread_arg, u
 	return(arg.pid);
 }
 
-static int ptrace_child(void)
+static int ptrace_child(void *arg)
 {
 	int ret;
 	int pid = os_getpid(), ppid = getppid();
@@ -159,16 +159,20 @@ static int ptrace_child(void)
 	_exit(ret);
 }
 
-static int start_ptraced_child(void)
+static int start_ptraced_child(void **stack_out)
 {
+	void *stack;
+	unsigned long sp;
 	int pid, n, status;
 	
-	pid = fork();
-	if(pid == 0)
-		ptrace_child();
-
+	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if(stack == MAP_FAILED)
+		panic("check_ptrace : mmap failed, errno = %d", errno);
+	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
+	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
 	if(pid < 0)
-		panic("check_ptrace : fork failed, errno = %d", errno);
+		panic("check_ptrace : clone failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0)
 		panic("check_ptrace : wait failed, errno = %d", errno);
@@ -176,6 +180,7 @@ static int start_ptraced_child(void)
 		panic("check_ptrace : expected SIGSTOP, got status = %d",
 		      status);
 
+	*stack_out = stack;
 	return(pid);
 }
 
@@ -183,12 +188,12 @@ static int start_ptraced_child(void)
  * just avoid using sysemu, not panic, but only if SYSEMU features are broken.
  * So only for SYSEMU features we test mustpanic, while normal host features
  * must work anyway!*/
-static int stop_ptraced_child(int pid, int exitcode, int mustexit)
+static int stop_ptraced_child(int pid, void *stack, int exitcode, int mustpanic)
 {
 	int status, n, ret = 0;
 
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
-		panic("stop_ptraced_child : ptrace failed, errno = %d", errno);
+		panic("check_ptrace : ptrace failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
@@ -199,13 +204,15 @@ static int stop_ptraced_child(int pid, i
 		printk("check_ptrace : child exited with exitcode %d, while "
 		      "expecting %d; status 0x%x", exit_with,
 		      exitcode, status);
-		if (mustexit)
+		if (mustpanic)
 			panic("\n");
 		else
 			printk("\n");
 		ret = -1;
 	}
 
+	if(munmap(stack, PAGE_SIZE) < 0)
+		panic("check_ptrace : munmap failed, errno = %d", errno);
 	return ret;
 }
 
@@ -227,11 +234,12 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 
 static void __init check_sysemu(void)
 {
+	void *stack;
 	int pid, syscall, n, status, count=0;
 
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
 		goto fail;
@@ -249,7 +257,7 @@ static void __init check_sysemu(void)
 		panic("check_sysemu : failed to modify system "
 		      "call return, errno = %d", errno);
 
-	if (stop_ptraced_child(pid, 0, 0) < 0)
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 1;
@@ -257,7 +265,7 @@ static void __init check_sysemu(void)
 	set_using_sysemu(!force_sysemu_disabled);
 
 	printk("Checking advanced syscall emulation patch for ptrace...");
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 	while(1){
 		count++;
 		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
@@ -282,7 +290,7 @@ static void __init check_sysemu(void)
 			break;
 		}
 	}
-	if (stop_ptraced_child(pid, 0, 0) < 0)
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 2;
@@ -293,17 +301,18 @@ static void __init check_sysemu(void)
 	return;
 
 fail:
-	stop_ptraced_child(pid, 1, 0);
+	stop_ptraced_child(pid, stack, 1, 0);
 fail_stopped:
 	printk("missing\n");
 }
 
 void __init check_ptrace(void)
 {
+	void *stack;
 	int pid, syscall, n, status;
 
 	printk("Checking that ptrace can change system call numbers...");
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
@@ -330,7 +339,7 @@ void __init check_ptrace(void)
 			break;
 		}
 	}
-	stop_ptraced_child(pid, 0, 1);
+	stop_ptraced_child(pid, stack, 0, 1);
 	printk("OK\n");
 	check_sysemu();
 }
@@ -362,10 +371,11 @@ void forward_pending_sigio(int target)
 static inline int check_skas3_ptrace_support(void)
 {
 	struct ptrace_faultinfo fi;
+	void *stack;
 	int pid, n, ret = 1;
 
 	printf("Checking for the skas3 patch in the host...");
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
 	if (n < 0) {
@@ -380,7 +390,7 @@ static inline int check_skas3_ptrace_sup
 	}
 
 	init_registers(pid);
-	stop_ptraced_child(pid, 1, 1);
+	stop_ptraced_child(pid, stack, 1, 1);
 
 	return(ret);
 }
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -433,7 +433,7 @@ acpi_pci_irq_enable (
 		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
+		if (dev->irq > 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
 			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
 			return_VALUE(0);
diff --git a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
--- a/drivers/char/tpm/tpm.c
+++ b/drivers/char/tpm/tpm.c
@@ -32,12 +32,6 @@
 
 #define	TPM_BUFSIZE			2048
 
-/* PCI configuration addresses */
-#define	PCI_GEN_PMCON_1			0xA0
-#define	PCI_GEN1_DEC			0xE4
-#define	PCI_LPC_EN			0xE6
-#define	PCI_GEN2_DEC			0xEC
-
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
 static int dev_mask[32];
@@ -61,72 +55,6 @@ void tpm_time_expired(unsigned long ptr)
 EXPORT_SYMBOL_GPL(tpm_time_expired);
 
 /*
- * Initialize the LPC bus and enable the TPM ports
- */
-int tpm_lpc_bus_init(struct pci_dev *pci_dev, u16 base)
-{
-	u32 lpcenable, tmp;
-	int is_lpcm = 0;
-
-	switch (pci_dev->vendor) {
-	case PCI_VENDOR_ID_INTEL:
-		switch (pci_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801CA_12:
-		case PCI_DEVICE_ID_INTEL_82801DB_12:
-			is_lpcm = 1;
-			break;
-		}
-		/* init ICH (enable LPC) */
-		pci_read_config_dword(pci_dev, PCI_GEN1_DEC, &lpcenable);
-		lpcenable |= 0x20000000;
-		pci_write_config_dword(pci_dev, PCI_GEN1_DEC, lpcenable);
-
-		if (is_lpcm) {
-			pci_read_config_dword(pci_dev, PCI_GEN1_DEC,
-					      &lpcenable);
-			if ((lpcenable & 0x20000000) == 0) {
-				dev_err(&pci_dev->dev,
-					"cannot enable LPC\n");
-				return -ENODEV;
-			}
-		}
-
-		/* initialize TPM registers */
-		pci_read_config_dword(pci_dev, PCI_GEN2_DEC, &tmp);
-
-		if (!is_lpcm)
-			tmp = (tmp & 0xFFFF0000) | (base & 0xFFF0);
-		else
-			tmp =
-			    (tmp & 0xFFFF0000) | (base & 0xFFF0) |
-			    0x00000001;
-
-		pci_write_config_dword(pci_dev, PCI_GEN2_DEC, tmp);
-
-		if (is_lpcm) {
-			pci_read_config_dword(pci_dev, PCI_GEN_PMCON_1,
-					      &tmp);
-			tmp |= 0x00000004;	/* enable CLKRUN */
-			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
-					       tmp);
-		}
-		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
-		tpm_write_index(0x0A, 0x00);	/* int disable */
-		tpm_write_index(0x08, base);	/* base addr lo */
-		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr hi */
-		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
-		break;
-	case PCI_VENDOR_ID_AMD:
-		/* nothing yet */
-		break;
-	}
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(tpm_lpc_bus_init);
-
-/*
  * Internal kernel interface to transmit TPM commands
  */
 static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
@@ -590,10 +518,6 @@ int tpm_pm_resume(struct pci_dev *pci_de
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
-	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
-
 	return 0;
 }
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -79,8 +79,6 @@ static inline void tpm_write_index(int i
 }
 
 extern void tpm_time_expired(unsigned long);
-extern int tpm_lpc_bus_init(struct pci_dev *, u16);
-
 extern int tpm_register_hardware(struct pci_dev *,
 				 struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -22,7 +22,10 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define	TPM_ATML_BASE			0x400
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
+};
 
 /* write status bits */
 #define	ATML_STATUS_ABORT		0x01
@@ -127,7 +130,6 @@ static struct tpm_vendor_specific tpm_at
 	.cancel = tpm_atml_cancel,
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
-	.base = TPM_ATML_BASE,
 	.miscdev = { .fops = &atmel_ops, },
 };
 
@@ -136,14 +138,16 @@ static int __devinit tpm_atml_init(struc
 {
 	u8 version[4];
 	int rc = 0;
+	int lo, hi;
 
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_ATML_BASE)) {
-		rc = -ENODEV;
-		goto out_err;
-	}
+	lo = tpm_read_index( TPM_ATMEL_BASE_ADDR_LO );
+	hi = tpm_read_index( TPM_ATMEL_BASE_ADDR_HI );
+
+	tpm_atmel.base = (hi<<8)|lo;
+	dev_dbg( &pci_dev->dev, "Operating with base: 0x%x\n", tpm_atmel.base);
 
 	/* verify that it is an Atmel part */
 	if (tpm_read_index(4) != 'A' || tpm_read_index(5) != 'T'
diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -24,6 +24,10 @@
 /* National definitions */
 #define	TPM_NSC_BASE			0x360
 #define	TPM_NSC_IRQ			0x07
+#define	TPM_NSC_BASE0_HI		0x60
+#define	TPM_NSC_BASE0_LO		0x61
+#define	TPM_NSC_BASE1_HI		0x62
+#define	TPM_NSC_BASE1_LO		0x63
 
 #define	NSC_LDN_INDEX			0x07
 #define	NSC_SID_INDEX			0x20
@@ -234,7 +238,6 @@ static struct tpm_vendor_specific tpm_ns
 	.cancel = tpm_nsc_cancel,
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
-	.base = TPM_NSC_BASE,
 	.miscdev = { .fops = &nsc_ops, },
 	
 };
@@ -243,15 +246,16 @@ static int __devinit tpm_nsc_init(struct
 				  const struct pci_device_id *pci_id)
 {
 	int rc = 0;
+	int lo, hi;
+
+	hi = tpm_read_index(TPM_NSC_BASE0_HI);
+	lo = tpm_read_index(TPM_NSC_BASE0_LO);
+
+	tpm_nsc.base = (hi<<8) | lo;
 
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_NSC_BASE)) {
-		rc = -ENODEV;
-		goto out_err;
-	}
-
 	/* verify that it is a National part (SID) */
 	if (tpm_read_index(NSC_SID_INDEX) != 0xEF) {
 		rc = -ENODEV;
diff --git a/drivers/char/tty_ioctl.c b/drivers/char/tty_ioctl.c
--- a/drivers/char/tty_ioctl.c
+++ b/drivers/char/tty_ioctl.c
@@ -476,11 +476,11 @@ int n_tty_ioctl(struct tty_struct * tty,
 			ld = tty_ldisc_ref(tty);
 			switch (arg) {
 			case TCIFLUSH:
-				if (ld->flush_buffer)
+				if (ld && ld->flush_buffer)
 					ld->flush_buffer(tty);
 				break;
 			case TCIOFLUSH:
-				if (ld->flush_buffer)
+				if (ld && ld->flush_buffer)
 					ld->flush_buffer(tty);
 				/* fall through */
 			case TCOFLUSH:
diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -261,7 +261,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.off                   = 0,
+		.off                   = 128,
 		.reg                   = MO_HUE,
 		.mask                  = 0x00ff,
 		.shift                 = 0,
diff --git a/drivers/net/hamradio/Kconfig b/drivers/net/hamradio/Kconfig
--- a/drivers/net/hamradio/Kconfig
+++ b/drivers/net/hamradio/Kconfig
@@ -17,7 +17,7 @@ config MKISS
 
 config 6PACK
 	tristate "Serial port 6PACK driver"
-	depends on AX25 && BROKEN_ON_SMP
+	depends on AX25
 	---help---
 	  6pack is a transmission protocol for the data exchange between your
 	  PC and your TNC (the Terminal Node Controller acts as a kind of
diff --git a/drivers/net/shaper.c b/drivers/net/shaper.c
--- a/drivers/net/shaper.c
+++ b/drivers/net/shaper.c
@@ -135,10 +135,8 @@ static int shaper_start_xmit(struct sk_b
 {
 	struct shaper *shaper = dev->priv;
  	struct sk_buff *ptr;
-   
-	if (down_trylock(&shaper->sem))
-		return -1;
 
+	spin_lock(&shaper->lock);
  	ptr=shaper->sendq.prev;
  	
  	/*
@@ -232,7 +230,7 @@ static int shaper_start_xmit(struct sk_b
                 shaper->stats.collisions++;
  	}
 	shaper_kick(shaper);
-	up(&shaper->sem);
+	spin_unlock(&shaper->lock);
  	return 0;
 }
 
@@ -271,11 +269,9 @@ static void shaper_timer(unsigned long d
 {
 	struct shaper *shaper = (struct shaper *)data;
 
-	if (!down_trylock(&shaper->sem)) {
-		shaper_kick(shaper);
-		up(&shaper->sem);
-	} else
-		mod_timer(&shaper->timer, jiffies);
+	spin_lock(&shaper->lock);
+	shaper_kick(shaper);
+	spin_unlock(&shaper->lock);
 }
 
 /*
@@ -332,21 +328,6 @@ static void shaper_kick(struct shaper *s
 
 
 /*
- *	Flush the shaper queues on a closedown
- */
- 
-static void shaper_flush(struct shaper *shaper)
-{
-	struct sk_buff *skb;
-
-	down(&shaper->sem);
-	while((skb=skb_dequeue(&shaper->sendq))!=NULL)
-		dev_kfree_skb(skb);
-	shaper_kick(shaper);
-	up(&shaper->sem);
-}
-
-/*
  *	Bring the interface up. We just disallow this until a 
  *	bind.
  */
@@ -375,7 +356,15 @@ static int shaper_open(struct net_device
 static int shaper_close(struct net_device *dev)
 {
 	struct shaper *shaper=dev->priv;
-	shaper_flush(shaper);
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&shaper->sendq)) != NULL)
+		dev_kfree_skb(skb);
+
+	spin_lock_bh(&shaper->lock);
+	shaper_kick(shaper);
+	spin_unlock_bh(&shaper->lock);
+
 	del_timer_sync(&shaper->timer);
 	return 0;
 }
@@ -576,6 +565,7 @@ static void shaper_init_priv(struct net_
 	init_timer(&sh->timer);
 	sh->timer.function=shaper_timer;
 	sh->timer.data=(unsigned long)sh;
+	spin_lock_init(&sh->lock);
 }
 
 /*
diff --git a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -139,7 +139,7 @@ __unregister_chrdev_region(unsigned majo
 	struct char_device_struct *cd = NULL, **cp;
 	int i = major_to_index(major);
 
-	up(&chrdevs_lock);
+	down(&chrdevs_lock);
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
 		if ((*cp)->major == major &&
 		    (*cp)->baseminor == baseminor &&
diff --git a/include/linux/if_shaper.h b/include/linux/if_shaper.h
--- a/include/linux/if_shaper.h
+++ b/include/linux/if_shaper.h
@@ -23,7 +23,7 @@ struct shaper
 	__u32 shapeclock;
 	unsigned long recovery;	/* Time we can next clock a packet out on
 				   an empty queue */
-	struct semaphore sem;
+	spinlock_t lock;
         struct net_device_stats stats;
 	struct net_device *dev;
 	int  (*hard_start_xmit) (struct sk_buff *skb,
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -111,7 +111,6 @@ static int ip_dev_loopback_xmit(struct s
 #ifdef CONFIG_NETFILTER_DEBUG
 	nf_debug_ip_loopback_xmit(newskb);
 #endif
-	nf_reset(newskb);
 	netif_rx(newskb);
 	return 0;
 }
@@ -196,8 +195,6 @@ static inline int ip_finish_output2(stru
 	nf_debug_ip_finish_output2(skb);
 #endif /*CONFIG_NETFILTER_DEBUG*/
 
-	nf_reset(skb);
-
 	if (hh) {
 		int hh_alen;
 
diff --git a/net/ipv4/netfilter/ip_conntrack_standalone.c b/net/ipv4/netfilter/ip_conntrack_standalone.c
--- a/net/ipv4/netfilter/ip_conntrack_standalone.c
+++ b/net/ipv4/netfilter/ip_conntrack_standalone.c
@@ -432,6 +432,13 @@ static unsigned int ip_conntrack_defrag(
 				        const struct net_device *out,
 				        int (*okfn)(struct sk_buff *))
 {
+#if !defined(CONFIG_IP_NF_NAT) && !defined(CONFIG_IP_NF_NAT_MODULE)
+	/* Previously seen (loopback)?  Ignore.  Do this before
+           fragment check. */
+	if ((*pskb)->nfct)
+		return NF_ACCEPT;
+#endif
+
 	/* Gather fragments. */
 	if ((*pskb)->nh.iph->frag_off & htons(IP_MF|IP_OFFSET)) {
 		*pskb = ip_ct_gather_frags(*pskb,
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -274,6 +274,9 @@ static int packet_rcv_spkt(struct sk_buf
 	dst_release(skb->dst);
 	skb->dst = NULL;
 
+	/* drop conntrack reference */
+	nf_reset(skb);
+
 	spkt = (struct sockaddr_pkt*)skb->cb;
 
 	skb_push(skb, skb->data-skb->mac.raw);
@@ -517,6 +520,9 @@ static int packet_rcv(struct sk_buff *sk
 	dst_release(skb->dst);
 	skb->dst = NULL;
 
+	/* drop conntrack reference */
+	nf_reset(skb);
+
 	spin_lock(&sk->sk_receive_queue.lock);
 	po->stats.tp_packets++;
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
