Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbVKXWrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbVKXWrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 17:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVKXWrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 17:47:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932673AbVKXWq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 17:46:58 -0500
Date: Thu, 24 Nov 2005 14:46:54 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.14.3
Message-ID: <20051124224654.GU5856@shell0.pdx.osdl.net>
References: <20051124224523.GT5856@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124224523.GT5856@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 5d47dc5..6e34293 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 14
-EXTRAVERSION = .2
+EXTRAVERSION = .3
 NAME=Affluent Albatross
 
 # *DOCUMENTATION*
diff --git a/arch/i386/kernel/cpu/mtrr/main.c b/arch/i386/kernel/cpu/mtrr/main.c
index dd4ebd6..1e9db19 100644
--- a/arch/i386/kernel/cpu/mtrr/main.c
+++ b/arch/i386/kernel/cpu/mtrr/main.c
@@ -626,6 +626,14 @@ void __init mtrr_bp_init(void)
 		if (cpuid_eax(0x80000000) >= 0x80000008) {
 			u32 phys_addr;
 			phys_addr = cpuid_eax(0x80000008) & 0xff;
+			/* CPUID workaround for Intel 0F33/0F34 CPU */
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			    boot_cpu_data.x86 == 0xF &&
+			    boot_cpu_data.x86_model == 0x3 &&
+			    (boot_cpu_data.x86_mask == 0x3 ||
+			     boot_cpu_data.x86_mask == 0x4))
+				phys_addr = 36;
+
 			size_or_mask = ~((1 << (phys_addr - PAGE_SHIFT)) - 1);
 			size_and_mask = ~size_or_mask & 0xfff00000;
 		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
diff --git a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
index c658650..8abf111 100644
--- a/arch/ppc64/Kconfig
+++ b/arch/ppc64/Kconfig
@@ -234,6 +234,10 @@ config HMT
 	  This option enables hardware multithreading on RS64 cpus.
 	  pSeries systems p620 and p660 have such a cpu type.
 
+config NUMA
+	bool "NUMA support"
+	default y if DISCONTIGMEM || SPARSEMEM
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
@@ -249,9 +253,6 @@ config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
 
-config ARCH_FLATMEM_ENABLE
-	def_bool y
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
@@ -274,10 +275,6 @@ config NODES_SPAN_OTHER_NODES
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
-config NUMA
-	bool "NUMA support"
-	default y if DISCONTIGMEM || SPARSEMEM
-
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SMP
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index cb28df1..5518428 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -993,6 +993,11 @@ static void __cpuinit init_intel(struct 
 		unsigned eax = cpuid_eax(0x80000008);
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+		/* CPUID workaround for Intel 0F34 CPU */
+		if (c->x86_vendor == X86_VENDOR_INTEL &&
+		    c->x86 == 0xF && c->x86_model == 0x3 &&
+		    c->x86_mask == 0x4)
+			c->x86_phys_bits = 36;
 	}
 
 	if (c->x86 == 15)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a280e67..a10ee02 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1191,7 +1191,7 @@ static void pkt_count_states(struct pktc
 	struct packet_data *pkt;
 	int i;
 
-	for (i = 0; i <= PACKET_NUM_STATES; i++)
+	for (i = 0; i < PACKET_NUM_STATES; i++)
 		states[i] = 0;
 
 	spin_lock(&pd->cdrw.active_list_lock);
diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 63fff7c..a7f099f 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -149,8 +149,22 @@ static void get_rtc_alm_time (struct rtc
 #ifdef RTC_IRQ
 static void rtc_dropped_irq(unsigned long data);
 
-static void set_rtc_irq_bit(unsigned char bit);
-static void mask_rtc_irq_bit(unsigned char bit);
+static void set_rtc_irq_bit_locked(unsigned char bit);
+static void mask_rtc_irq_bit_locked(unsigned char bit);
+
+static inline void set_rtc_irq_bit(unsigned char bit)
+{
+	spin_lock_irq(&rtc_lock);
+	set_rtc_irq_bit_locked(bit);
+	spin_unlock_irq(&rtc_lock);
+}
+
+static void mask_rtc_irq_bit(unsigned char bit)
+{
+	spin_lock_irq(&rtc_lock);
+	mask_rtc_irq_bit_locked(bit);
+	spin_unlock_irq(&rtc_lock);
+}
 #endif
 
 static int rtc_proc_open(struct inode *inode, struct file *file);
@@ -401,18 +415,19 @@ static int rtc_do_ioctl(unsigned int cmd
 	}
 	case RTC_PIE_OFF:	/* Mask periodic int. enab. bit	*/
 	{
-		mask_rtc_irq_bit(RTC_PIE);
+		unsigned long flags; /* can be called from isr via rtc_control() */
+		spin_lock_irqsave (&rtc_lock, flags);
+		mask_rtc_irq_bit_locked(RTC_PIE);
 		if (rtc_status & RTC_TIMER_ON) {
-			spin_lock_irq (&rtc_lock);
 			rtc_status &= ~RTC_TIMER_ON;
 			del_timer(&rtc_irq_timer);
-			spin_unlock_irq (&rtc_lock);
 		}
+		spin_unlock_irqrestore (&rtc_lock, flags);
 		return 0;
 	}
 	case RTC_PIE_ON:	/* Allow periodic ints		*/
 	{
-
+		unsigned long flags; /* can be called from isr via rtc_control() */
 		/*
 		 * We don't really want Joe User enabling more
 		 * than 64Hz of interrupts on a multi-user machine.
@@ -421,14 +436,14 @@ static int rtc_do_ioctl(unsigned int cmd
 			(!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;
 
+		spin_lock_irqsave (&rtc_lock, flags);
 		if (!(rtc_status & RTC_TIMER_ON)) {
-			spin_lock_irq (&rtc_lock);
 			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
 			add_timer(&rtc_irq_timer);
 			rtc_status |= RTC_TIMER_ON;
-			spin_unlock_irq (&rtc_lock);
 		}
-		set_rtc_irq_bit(RTC_PIE);
+		set_rtc_irq_bit_locked(RTC_PIE);
+		spin_unlock_irqrestore (&rtc_lock, flags);
 		return 0;
 	}
 	case RTC_UIE_OFF:	/* Mask ints from RTC updates.	*/
@@ -609,6 +624,7 @@ static int rtc_do_ioctl(unsigned int cmd
 	{
 		int tmp = 0;
 		unsigned char val;
+		unsigned long flags; /* can be called from isr via rtc_control() */
 
 		/* 
 		 * The max we can do is 8192Hz.
@@ -631,9 +647,9 @@ static int rtc_do_ioctl(unsigned int cmd
 		if (arg != (1<<tmp))
 			return -EINVAL;
 
-		spin_lock_irq(&rtc_lock);
+		spin_lock_irqsave(&rtc_lock, flags);
 		if (hpet_set_periodic_freq(arg)) {
-			spin_unlock_irq(&rtc_lock);
+			spin_unlock_irqrestore(&rtc_lock, flags);
 			return 0;
 		}
 		rtc_freq = arg;
@@ -641,7 +657,7 @@ static int rtc_do_ioctl(unsigned int cmd
 		val = CMOS_READ(RTC_FREQ_SELECT) & 0xf0;
 		val |= (16 - tmp);
 		CMOS_WRITE(val, RTC_FREQ_SELECT);
-		spin_unlock_irq(&rtc_lock);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 		return 0;
 	}
 #endif
@@ -844,12 +860,15 @@ int rtc_control(rtc_task_t *task, unsign
 #ifndef RTC_IRQ
 	return -EIO;
 #else
-	spin_lock_irq(&rtc_task_lock);
+	unsigned long flags;
+	if (cmd != RTC_PIE_ON && cmd != RTC_PIE_OFF && cmd != RTC_IRQP_SET)
+		return -EINVAL;
+	spin_lock_irqsave(&rtc_task_lock, flags);
 	if (rtc_callback != task) {
-		spin_unlock_irq(&rtc_task_lock);
+		spin_unlock_irqrestore(&rtc_task_lock, flags);
 		return -ENXIO;
 	}
-	spin_unlock_irq(&rtc_task_lock);
+	spin_unlock_irqrestore(&rtc_task_lock, flags);
 	return rtc_do_ioctl(cmd, arg, 1);
 #endif
 }
@@ -1306,40 +1325,32 @@ static void get_rtc_alm_time(struct rtc_
  * meddles with the interrupt enable/disable bits.
  */
 
-static void mask_rtc_irq_bit(unsigned char bit)
+static void mask_rtc_irq_bit_locked(unsigned char bit)
 {
 	unsigned char val;
 
-	spin_lock_irq(&rtc_lock);
-	if (hpet_mask_rtc_irq_bit(bit)) {
-		spin_unlock_irq(&rtc_lock);
+	if (hpet_mask_rtc_irq_bit(bit))
 		return;
-	}
 	val = CMOS_READ(RTC_CONTROL);
 	val &=  ~bit;
 	CMOS_WRITE(val, RTC_CONTROL);
 	CMOS_READ(RTC_INTR_FLAGS);
 
 	rtc_irq_data = 0;
-	spin_unlock_irq(&rtc_lock);
 }
 
-static void set_rtc_irq_bit(unsigned char bit)
+static void set_rtc_irq_bit_locked(unsigned char bit)
 {
 	unsigned char val;
 
-	spin_lock_irq(&rtc_lock);
-	if (hpet_set_rtc_irq_bit(bit)) {
-		spin_unlock_irq(&rtc_lock);
+	if (hpet_set_rtc_irq_bit(bit))
 		return;
-	}
 	val = CMOS_READ(RTC_CONTROL);
 	val |= bit;
 	CMOS_WRITE(val, RTC_CONTROL);
 	CMOS_READ(RTC_INTR_FLAGS);
 
 	rtc_irq_data = 0;
-	spin_unlock_irq(&rtc_lock);
 }
 #endif
 
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 53cc2b6..0b0f47c 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -522,8 +522,15 @@ static ssize_t set_fan_min(struct device
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+	u8 reg = it87_read_value(client, IT87_REG_FAN_DIV);
 
 	down(&data->update_lock);
+	switch (nr) {
+	case 0: data->fan_div[nr] = reg & 0x07; break;
+	case 1: data->fan_div[nr] = (reg >> 3) & 0x07; break;
+	case 2: data->fan_div[nr] = (reg & 0x40) ? 3 : 1; break;
+	}
+
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
 	up(&data->update_lock);
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index f6730dc..b24ee76 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -451,7 +451,7 @@ static DEVICE_ATTR(fan3_div, S_IRUGO, sh
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(82, data->vid));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, 82));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 3479dc5..b986f91 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -454,7 +454,9 @@ static ssize_t store_regs_in_min0(struct
 		(w83627thf == data->type || w83637hf == data->type))
 
 		/* use VRM9 calculation */
-		data->in_min[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+		data->in_min[0] =
+			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
+					255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_min[0] = IN_TO_REG(val);
@@ -479,7 +481,9 @@ static ssize_t store_regs_in_max0(struct
 		(w83627thf == data->type || w83637hf == data->type))
 		
 		/* use VRM9 calculation */
-		data->in_max[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+		data->in_max[0] =
+			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
+					255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_max[0] = IN_TO_REG(val);
diff --git a/drivers/isdn/hardware/eicon/os_4bri.c b/drivers/isdn/hardware/eicon/os_4bri.c
index cccfabc..11e6f93 100644
--- a/drivers/isdn/hardware/eicon/os_4bri.c
+++ b/drivers/isdn/hardware/eicon/os_4bri.c
@@ -16,6 +16,7 @@
 #include "diva_pci.h"
 #include "mi_pc.h"
 #include "dsrv4bri.h"
+#include "helpers.h"
 
 static void *diva_xdiLoadFileFile = NULL;
 static dword diva_xdiLoadFileLength = 0;
@@ -815,7 +816,7 @@ diva_4bri_cmd_card_proc(struct _diva_os_
 	return (ret);
 }
 
-void *xdiLoadFile(char *FileName, unsigned long *FileLength,
+void *xdiLoadFile(char *FileName, dword *FileLength,
 		  unsigned long lim)
 {
 	void *ret = diva_xdiLoadFileFile;
diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index a01efa6..1fd0466 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -192,7 +192,9 @@ static int cisco_rx(struct sk_buff *skb)
 					       "uptime %ud%uh%um%us)\n",
 					       dev->name, days, hrs,
 					       min, sec);
+#if 0
 					netif_carrier_on(dev);
+#endif
 					hdlc->state.cisco.up = 1;
 				}
 			}
@@ -225,7 +227,9 @@ static void cisco_timer(unsigned long ar
 		       hdlc->state.cisco.settings.timeout * HZ)) {
 		hdlc->state.cisco.up = 0;
 		printk(KERN_INFO "%s: Link down\n", dev->name);
+#if 0
 		netif_carrier_off(dev);
+#endif
 	}
 
 	cisco_keepalive_send(dev, CISCO_KEEPALIVE_REQ,
@@ -261,8 +265,10 @@ static void cisco_stop(struct net_device
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	del_timer_sync(&hdlc->state.cisco.timer);
+#if 0
 	if (netif_carrier_ok(dev))
 		netif_carrier_off(dev);
+#endif
 	hdlc->state.cisco.up = 0;
 	hdlc->state.cisco.request_sent = 0;
 }
diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index a5d6891..5cb399f 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -545,8 +545,10 @@ static void fr_set_link_state(int reliab
 
 	hdlc->state.fr.reliable = reliable;
 	if (reliable) {
+#if 0
 		if (!netif_carrier_ok(dev))
 			netif_carrier_on(dev);
+#endif
 
 		hdlc->state.fr.n391cnt = 0; /* Request full status */
 		hdlc->state.fr.dce_changed = 1;
@@ -560,8 +562,10 @@ static void fr_set_link_state(int reliab
 			}
 		}
 	} else {
+#if 0
 		if (netif_carrier_ok(dev))
 			netif_carrier_off(dev);
+#endif
 
 		while (pvc) {		/* Deactivate all PVCs */
 			pvc_carrier(0, pvc);
diff --git a/drivers/net/wan/hdlc_generic.c b/drivers/net/wan/hdlc_generic.c
index cdd4c09..46cef8f 100644
--- a/drivers/net/wan/hdlc_generic.c
+++ b/drivers/net/wan/hdlc_generic.c
@@ -79,11 +79,13 @@ static void __hdlc_set_carrier_on(struct
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	if (hdlc->proto.start)
 		return hdlc->proto.start(dev);
+#if 0
 #ifdef DEBUG_LINK
 	if (netif_carrier_ok(dev))
 		printk(KERN_ERR "hdlc_set_carrier_on(): already on\n");
 #endif
 	netif_carrier_on(dev);
+#endif
 }
 
 
@@ -94,11 +96,13 @@ static void __hdlc_set_carrier_off(struc
 	if (hdlc->proto.stop)
 		return hdlc->proto.stop(dev);
 
+#if 0
 #ifdef DEBUG_LINK
 	if (!netif_carrier_ok(dev))
 		printk(KERN_ERR "hdlc_set_carrier_off(): already off\n");
 #endif
 	netif_carrier_off(dev);
+#endif
 }
 
 
@@ -294,8 +298,10 @@ int register_hdlc_device(struct net_devi
 	if (result != 0)
 		return -EIO;
 
+#if 0
 	if (netif_carrier_ok(dev))
 		netif_carrier_off(dev); /* no carrier until DCD goes up */
+#endif
 
 	return 0;
 }
diff --git a/fs/locks.c b/fs/locks.c
index f7daa5f..accbc3c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1418,7 +1418,7 @@ int fcntl_setlease(unsigned int fd, stru
 	lock_kernel();
 
 	error = __setlease(filp, arg, &flp);
-	if (error)
+	if (error || arg == F_UNLCK)
 		goto out_unlock;
 
 	error = fasync_helper(fd, filp, 1, &flp->fl_fasync);
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 65ec866..53c76c8 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -237,6 +237,8 @@ extern struct ipv6_txoptions *	ipv6_rene
 						   int newtype,
 						   struct ipv6_opt_hdr __user *newopt,
 						   int newoptlen);
+struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
+					  struct ipv6_txoptions *opt);
 
 extern int ip6_frag_nqueues;
 extern atomic_t ip6_frag_mem;
diff --git a/kernel/signal.c b/kernel/signal.c
index 6904bbb..0d755c6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1524,7 +1524,7 @@ void do_notify_parent(struct task_struct
 
 	psig = tsk->parent->sighand;
 	spin_lock_irqsave(&psig->siglock, flags);
-	if (sig == SIGCHLD &&
+	if (!tsk->ptrace && sig == SIGCHLD &&
 	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
 	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
 		/*
diff --git a/net/ipv4/netfilter/ip_conntrack_ftp.c b/net/ipv4/netfilter/ip_conntrack_ftp.c
index d77d6b3..59e12b0 100644
--- a/net/ipv4/netfilter/ip_conntrack_ftp.c
+++ b/net/ipv4/netfilter/ip_conntrack_ftp.c
@@ -29,9 +29,9 @@ static char *ftp_buffer;
 static DEFINE_SPINLOCK(ip_ftp_lock);
 
 #define MAX_PORTS 8
-static short ports[MAX_PORTS];
+static unsigned short ports[MAX_PORTS];
 static int ports_c;
-module_param_array(ports, short, &ports_c, 0400);
+module_param_array(ports, ushort, &ports_c, 0400);
 
 static int loose;
 module_param(loose, int, 0600);
diff --git a/net/ipv4/netfilter/ip_conntrack_irc.c b/net/ipv4/netfilter/ip_conntrack_irc.c
index 1545741..2dea1db 100644
--- a/net/ipv4/netfilter/ip_conntrack_irc.c
+++ b/net/ipv4/netfilter/ip_conntrack_irc.c
@@ -34,7 +34,7 @@
 #include <linux/moduleparam.h>
 
 #define MAX_PORTS 8
-static short ports[MAX_PORTS];
+static unsigned short ports[MAX_PORTS];
 static int ports_c;
 static int max_dcc_channels = 8;
 static unsigned int dcc_timeout = 300;
@@ -52,7 +52,7 @@ EXPORT_SYMBOL_GPL(ip_nat_irc_hook);
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("IRC (DCC) connection tracking helper");
 MODULE_LICENSE("GPL");
-module_param_array(ports, short, &ports_c, 0400);
+module_param_array(ports, ushort, &ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of IRC servers");
 module_param(max_dcc_channels, int, 0400);
 MODULE_PARM_DESC(max_dcc_channels, "max number of expected DCC channels per IRC session");
diff --git a/net/ipv4/netfilter/ip_conntrack_netlink.c b/net/ipv4/netfilter/ip_conntrack_netlink.c
index 166e606..97fab76 100644
--- a/net/ipv4/netfilter/ip_conntrack_netlink.c
+++ b/net/ipv4/netfilter/ip_conntrack_netlink.c
@@ -58,14 +58,17 @@ ctnetlink_dump_tuples_proto(struct sk_bu
 			    const struct ip_conntrack_tuple *tuple)
 {
 	struct ip_conntrack_protocol *proto;
+	int ret = 0;
 
 	NFA_PUT(skb, CTA_PROTO_NUM, sizeof(u_int8_t), &tuple->dst.protonum);
 
 	proto = ip_conntrack_proto_find_get(tuple->dst.protonum);
-	if (proto && proto->tuple_to_nfattr)
-		return proto->tuple_to_nfattr(skb, tuple);
+	if (likely(proto && proto->tuple_to_nfattr)) {
+		ret = proto->tuple_to_nfattr(skb, tuple);
+		ip_conntrack_proto_put(proto);
+	}
 
-	return 0;
+	return ret;
 
 nfattr_failure:
 	return -1;
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_icmp.c b/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
index 98f0015..838d1d6 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
@@ -296,7 +296,8 @@ static int icmp_nfattr_to_tuple(struct n
 				struct ip_conntrack_tuple *tuple)
 {
 	if (!tb[CTA_PROTO_ICMP_TYPE-1]
-	    || !tb[CTA_PROTO_ICMP_CODE-1])
+	    || !tb[CTA_PROTO_ICMP_CODE-1]
+	    || !tb[CTA_PROTO_ICMP_ID-1])
 		return -1;
 
 	tuple->dst.u.icmp.type = 
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
index d6701ca..0658e8f 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
@@ -362,6 +362,11 @@ static int nfattr_to_tcp(struct nfattr *
 	struct nfattr *attr = cda[CTA_PROTOINFO_TCP-1];
 	struct nfattr *tb[CTA_PROTOINFO_TCP_MAX];
 
+	/* updates could not contain anything about the private
+	 * protocol info, in that case skip the parsing */
+	if (!attr)
+		return 0;
+
         if (nfattr_parse_nested(tb, CTA_PROTOINFO_TCP_MAX, attr) < 0)
                 goto nfattr_failure;
 
@@ -813,6 +818,7 @@ static u8 tcp_valid_flags[(TH_FIN|TH_SYN
 {
 	[TH_SYN]			= 1,
 	[TH_SYN|TH_ACK]			= 1,
+	[TH_SYN|TH_PUSH]		= 1,
 	[TH_SYN|TH_ACK|TH_PUSH]		= 1,
 	[TH_RST]			= 1,
 	[TH_RST|TH_ACK]			= 1,
diff --git a/net/ipv4/netfilter/ip_conntrack_tftp.c b/net/ipv4/netfilter/ip_conntrack_tftp.c
index a78736b..d3c5a37 100644
--- a/net/ipv4/netfilter/ip_conntrack_tftp.c
+++ b/net/ipv4/netfilter/ip_conntrack_tftp.c
@@ -26,9 +26,9 @@ MODULE_DESCRIPTION("tftp connection trac
 MODULE_LICENSE("GPL");
 
 #define MAX_PORTS 8
-static short ports[MAX_PORTS];
+static unsigned short ports[MAX_PORTS];
 static int ports_c;
-module_param_array(ports, short, &ports_c, 0400);
+module_param_array(ports, ushort, &ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of tftp servers");
 
 #if 0
diff --git a/net/ipv4/netfilter/ip_nat_core.c b/net/ipv4/netfilter/ip_nat_core.c
index c5e3abd..762f4d9 100644
--- a/net/ipv4/netfilter/ip_nat_core.c
+++ b/net/ipv4/netfilter/ip_nat_core.c
@@ -66,10 +66,8 @@ ip_nat_proto_find_get(u_int8_t protonum)
 	 * removed until we've grabbed the reference */
 	preempt_disable();
 	p = __ip_nat_proto_find(protonum);
-	if (p) {
-		if (!try_module_get(p->me))
-			p = &ip_nat_unknown_protocol;
-	}
+	if (!try_module_get(p->me))
+		p = &ip_nat_unknown_protocol;
 	preempt_enable();
 
 	return p;
diff --git a/net/ipv4/netfilter/ip_nat_helper_pptp.c b/net/ipv4/netfilter/ip_nat_helper_pptp.c
index 3cdd068..56e29fa 100644
--- a/net/ipv4/netfilter/ip_nat_helper_pptp.c
+++ b/net/ipv4/netfilter/ip_nat_helper_pptp.c
@@ -73,6 +73,7 @@ static void pptp_nat_expected(struct ip_
 	struct ip_conntrack_tuple t;
 	struct ip_ct_pptp_master *ct_pptp_info;
 	struct ip_nat_pptp *nat_pptp_info;
+	struct ip_nat_range range;
 
 	ct_pptp_info = &master->help.ct_pptp_info;
 	nat_pptp_info = &master->nat.help.nat_pptp_info;
@@ -110,7 +111,30 @@ static void pptp_nat_expected(struct ip_
 		DEBUGP("not found!\n");
 	}
 
-	ip_nat_follow_master(ct, exp);
+	/* This must be a fresh one. */
+	BUG_ON(ct->status & IPS_NAT_DONE_MASK);
+
+	/* Change src to where master sends to */
+	range.flags = IP_NAT_RANGE_MAP_IPS;
+	range.min_ip = range.max_ip
+		= ct->master->tuplehash[!exp->dir].tuple.dst.ip;
+	if (exp->dir == IP_CT_DIR_ORIGINAL) {
+		range.flags |= IP_NAT_RANGE_PROTO_SPECIFIED;
+		range.min = range.max = exp->saved_proto;
+	}
+	/* hook doesn't matter, but it has to do source manip */
+	ip_nat_setup_info(ct, &range, NF_IP_POST_ROUTING);
+
+	/* For DST manip, map port here to where it's expected. */
+	range.flags = IP_NAT_RANGE_MAP_IPS;
+	range.min_ip = range.max_ip
+		= ct->master->tuplehash[!exp->dir].tuple.src.ip;
+	if (exp->dir == IP_CT_DIR_REPLY) {
+		range.flags |= IP_NAT_RANGE_PROTO_SPECIFIED;
+		range.min = range.max = exp->saved_proto;
+	}
+	/* hook doesn't matter, but it has to do destination manip */
+	ip_nat_setup_info(ct, &range, NF_IP_PRE_ROUTING);
 }
 
 /* outbound packets == from PNS to PAC */
@@ -213,7 +237,7 @@ pptp_exp_gre(struct ip_conntrack_expect 
 
 	/* alter expectation for PNS->PAC direction */
 	invert_tuplepr(&inv_t, &expect_orig->tuple);
-	expect_orig->saved_proto.gre.key = htons(nat_pptp_info->pac_call_id);
+	expect_orig->saved_proto.gre.key = htons(ct_pptp_info->pns_call_id);
 	expect_orig->tuple.src.u.gre.key = htons(nat_pptp_info->pns_call_id);
 	expect_orig->tuple.dst.u.gre.key = htons(ct_pptp_info->pac_call_id);
 	inv_t.src.ip = reply_t->src.ip;
diff --git a/net/ipv4/netfilter/ip_nat_proto_gre.c b/net/ipv4/netfilter/ip_nat_proto_gre.c
index 7c12854..f7cad7c 100644
--- a/net/ipv4/netfilter/ip_nat_proto_gre.c
+++ b/net/ipv4/netfilter/ip_nat_proto_gre.c
@@ -139,8 +139,8 @@ gre_manip_pkt(struct sk_buff **pskb,
 			break;
 		case GRE_VERSION_PPTP:
 			DEBUGP("call_id -> 0x%04x\n", 
-				ntohl(tuple->dst.u.gre.key));
-			pgreh->call_id = htons(ntohl(tuple->dst.u.gre.key));
+				ntohs(tuple->dst.u.gre.key));
+			pgreh->call_id = tuple->dst.u.gre.key;
 			break;
 		default:
 			DEBUGP("can't nat unknown GRE version\n");
diff --git a/net/ipv4/netfilter/ip_nat_proto_unknown.c b/net/ipv4/netfilter/ip_nat_proto_unknown.c
index 99bbef5..f0099a6 100644
--- a/net/ipv4/netfilter/ip_nat_proto_unknown.c
+++ b/net/ipv4/netfilter/ip_nat_proto_unknown.c
@@ -62,7 +62,7 @@ unknown_print_range(char *buffer, const 
 
 struct ip_nat_protocol ip_nat_unknown_protocol = {
 	.name			= "unknown",
-	.me			= THIS_MODULE,
+	/* .me isn't set: getting a ref to this cannot fail. */
 	.manip_pkt		= unknown_manip_pkt,
 	.in_range		= unknown_in_range,
 	.unique_tuple		= unknown_unique_tuple,
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index cc51840..c4a3a99 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -437,7 +437,7 @@ int datagram_recv_ctl(struct sock *sk, s
 				break;
 			case IPPROTO_AH:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 2;
+				len = (ptr[1] + 2) << 2;
 				break;
 			default:
 				nexthdr = ptr[0];
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 9225495..be6faf3 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -628,6 +628,7 @@ ipv6_renew_options(struct sock *sk, stru
 	if (!tot_len)
 		return NULL;
 
+	tot_len += sizeof(*opt2);
 	opt2 = sock_kmalloc(sk, tot_len, GFP_ATOMIC);
 	if (!opt2)
 		return ERR_PTR(-ENOBUFS);
@@ -668,7 +669,26 @@ ipv6_renew_options(struct sock *sk, stru
 
 	return opt2;
 out:
-	sock_kfree_s(sk, p, tot_len);
+	sock_kfree_s(sk, opt2, opt2->tot_len);
 	return ERR_PTR(err);
 }
 
+struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
+					  struct ipv6_txoptions *opt)
+{
+	/*
+	 * ignore the dest before srcrt unless srcrt is being included.
+	 * --yoshfuji
+	 */
+	if (opt && opt->dst0opt && !opt->srcrt) {
+		if (opt_space != opt) {
+			memcpy(opt_space, opt, sizeof(*opt_space));
+			opt = opt_space;
+		}
+		opt->opt_nflen -= ipv6_optlen(opt->dst0opt);
+		opt->dst0opt = NULL;
+	}
+
+	return opt;
+}
+
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index bbbe80c..5f3e086 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -225,20 +225,16 @@ struct ipv6_txoptions *fl6_merge_options
 					 struct ip6_flowlabel * fl,
 					 struct ipv6_txoptions * fopt)
 {
-	struct ipv6_txoptions * fl_opt = fl ? fl->opt : NULL;
+	struct ipv6_txoptions * fl_opt = fl->opt;
 
-	if (fopt == NULL || fopt->opt_flen == 0) {
-		if (!fl_opt || !fl_opt->dst0opt || fl_opt->srcrt)
-			return fl_opt;
-	}
+	if (fopt == NULL || fopt->opt_flen == 0)
+		return fl_opt;
 
 	if (fl_opt != NULL) {
 		opt_space->hopopt = fl_opt->hopopt;
-		opt_space->dst0opt = fl_opt->srcrt ? fl_opt->dst0opt : NULL;
+		opt_space->dst0opt = fl_opt->dst0opt;
 		opt_space->srcrt = fl_opt->srcrt;
 		opt_space->opt_nflen = fl_opt->opt_nflen;
-		if (fl_opt->dst0opt && !fl_opt->srcrt)
-			opt_space->opt_nflen -= ipv6_optlen(fl_opt->dst0opt);
 	} else {
 		if (fopt->opt_nflen == 0)
 			return fopt;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index a1265a3..d77d335 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -756,7 +756,9 @@ static int rawv6_sendmsg(struct kiocb *i
 	}
 	if (opt == NULL)
 		opt = np->opt;
-	opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	if (flowlabel)
+		opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	opt = ipv6_fixup_options(&opt_space, opt);
 
 	fl.proto = proto;
 	rawv6_probe_proto_opt(&fl, msg);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index bf95193..e2b87cc 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -778,7 +778,9 @@ do_udp_sendmsg:
 	}
 	if (opt == NULL)
 		opt = np->opt;
-	opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	if (flowlabel)
+		opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	opt = ipv6_fixup_options(&opt_space, opt);
 
 	fl->proto = IPPROTO_UDP;
 	ipv6_addr_copy(&fl->fl6_dst, daddr);
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index d10d552..d3a4f30 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -117,7 +117,7 @@ int nf_queue(struct sk_buff **skb, 
 
 	/* QUEUE == DROP if noone is waiting, to be safe. */
 	read_lock(&queue_handler_lock);
-	if (!queue_handler[pf]->outfn) {
+	if (!queue_handler[pf] || !queue_handler[pf]->outfn) {
 		read_unlock(&queue_handler_lock);
 		kfree_skb(*skb);
 		return 1;
