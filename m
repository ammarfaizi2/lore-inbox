Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262086AbSI3NoB>; Mon, 30 Sep 2002 09:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSI3NoA>; Mon, 30 Sep 2002 09:44:00 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:39886 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262067AbSI3Nnj> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:43:39 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (3/26): drivers.
Date: Mon, 30 Sep 2002 14:51:19 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301451.19791.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 minimal device drivers changes for 2.5.39. 

diff -urN linux-2.5.39/drivers/s390/char/ctrlchar.c linux-2.5.39-s390/drivers/s390/char/ctrlchar.c
--- linux-2.5.39/drivers/s390/char/ctrlchar.c	Fri Sep 27 23:50:58 2002
+++ linux-2.5.39-s390/drivers/s390/char/ctrlchar.c	Mon Sep 30 14:34:55 2002
@@ -26,7 +26,7 @@
 
 static void
 ctrlchar_handle_sysrq(struct tty_struct *tty) {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
+	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
 #endif
 
diff -urN linux-2.5.39/drivers/s390/char/hwc_rw.c linux-2.5.39-s390/drivers/s390/char/hwc_rw.c
--- linux-2.5.39/drivers/s390/char/hwc_rw.c	Fri Sep 27 23:49:06 2002
+++ linux-2.5.39-s390/drivers/s390/char/hwc_rw.c	Mon Sep 30 14:34:55 2002
@@ -2219,7 +2219,7 @@
 
 	u32 ext_int_param = hwc_ext_int_param ();
 
-	irq_enter (cpu, 0x2401);
+	irq_enter ();
 
 	if (hwc_data.flags & HWC_INIT) {
 
@@ -2240,7 +2240,7 @@
 		hwc_do_interrupt (ext_int_param);
 		spin_unlock (&hwc_data.lock);
 	}
-	irq_exit (cpu, 0x2401);
+	irq_exit ();
 }
 
 void 
diff -urN linux-2.5.39/drivers/s390/cio/cio.c linux-2.5.39-s390/drivers/s390/cio/cio.c
--- linux-2.5.39/drivers/s390/cio/cio.c	Fri Sep 27 23:50:57 2002
+++ linux-2.5.39-s390/drivers/s390/cio/cio.c	Mon Sep 30 14:34:55 2002
@@ -978,9 +978,9 @@
 		 */
 		if (tpi_info->adapter_IO == 1 &&
 		    tpi_info->int_type == IO_INTERRUPT_TYPE) {
-			irq_enter (cpu, -1);
+			irq_enter ();
 			do_adapter_IO (tpi_info->intparm);
-			irq_exit (cpu, -1);
+			irq_exit ();
 		} else {
 			unsigned int irq = tpi_info->irq;
 
@@ -1001,11 +1001,11 @@
 				return;
 			}
 
-			irq_enter (cpu, irq);
+			irq_enter ();
 			s390irq_spin_lock (irq);
 			s390_process_IRQ (irq);
 			s390irq_spin_unlock (irq);
-			irq_exit (cpu, irq);
+			irq_exit ();
 		}
 
 #ifdef CONFIG_FAST_IRQ
diff -urN linux-2.5.39/drivers/s390/cio/proc.c linux-2.5.39-s390/drivers/s390/cio/proc.c
--- linux-2.5.39/drivers/s390/cio/proc.c	Fri Sep 27 23:49:06 2002
+++ linux-2.5.39-s390/drivers/s390/cio/proc.c	Mon Sep 30 14:34:55 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/proc.c
  *   S/390 common I/O routines -- proc file system entries
- *   $Revision: 1.4 $
+ *   $Revision: 1.5 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -17,6 +17,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -30,6 +31,31 @@
 
 static int chan_proc_init (void);
 
+int show_interrupts(struct seq_file *p, void *v)
+{
+	int i, j;
+
+	seq_puts(p, "           ");
+
+	for (j=0; j<num_online_cpus(); j++)
+		seq_printf(p, "CPU%d       ",j);
+
+	seq_putc(p, '\n');
+
+	for (i = 0 ; i < NR_IRQS ; i++) {
+		if (ioinfo[i] == INVALID_STORAGE_AREA)
+			continue;
+
+		seq_printf(p, "%3d: ",i);
+		seq_printf(p, "  %s", ioinfo[i]->irq_desc.name);
+
+		seq_putc(p, '\n');
+	
+	} /* endfor */
+
+	return 0;
+}
+
 /* 
  * Display info on subchannels in /proc/subchannels. 
  * Adapted from procfs stuff in dasd.c by Cornelia Huck, 02/28/01.      
@@ -267,3 +293,9 @@
 }
 
 __initcall (cio_irq_proc_init);
+
+void
+init_irq_proc(void)
+{
+	/* For now, nothing... */
+}
diff -urN linux-2.5.39/drivers/s390/cio/requestirq.c linux-2.5.39-s390/drivers/s390/cio/requestirq.c
--- linux-2.5.39/drivers/s390/cio/requestirq.c	Fri Sep 27 23:50:26 2002
+++ linux-2.5.39-s390/drivers/s390/cio/requestirq.c	Mon Sep 30 14:34:55 2002
@@ -122,6 +122,16 @@
 					 NULL, irqflags, devname, dev_id);
 }
 
+/*
+ * request_irq wrapper
+ */
+int
+request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
+	    unsigned long irqflags, const char *devname, void *dev_id)
+{
+	return s390_request_irq(irq, handler, irqflags, devname, dev_id);
+}
+
 void
 s390_free_irq (unsigned int irq, void *dev_id)
 {
@@ -224,6 +234,15 @@
 }
 
 /*
+ * free_irq wrapper.
+ */
+void
+free_irq(unsigned int irq, void *dev_id)
+{
+	s390_free_irq(irq, dev_id);
+}
+
+/*
  * Enable IRQ by modifying the subchannel
  */
 static int
diff -urN linux-2.5.39/drivers/s390/cio/s390io.c linux-2.5.39-s390/drivers/s390/cio/s390io.c
--- linux-2.5.39/drivers/s390/cio/s390io.c	Fri Sep 27 23:50:28 2002
+++ linux-2.5.39-s390/drivers/s390/cio/s390io.c	Mon Sep 30 14:34:55 2002
@@ -209,6 +209,15 @@
 }
 
 /*
+ * init_IRQ wrapper
+ */
+void __init
+init_IRQ(void)
+{
+	s390_init_IRQ();
+}
+
+/*
  * dummy handler, used during init_IRQ() processing for compatibility only
  */
 static void
diff -urN linux-2.5.39/drivers/s390/misc/chandev.c linux-2.5.39-s390/drivers/s390/misc/chandev.c
--- linux-2.5.39/drivers/s390/misc/chandev.c	Fri Sep 27 23:49:45 2002
+++ linux-2.5.39-s390/drivers/s390/misc/chandev.c	Mon Sep 30 14:34:55 2002
@@ -24,6 +24,7 @@
 #include <asm/s390dyn.h>
 #include <asm/queue.h>
 #include <linux/kmod.h>
+#include <linux/tqueue.h>
 #ifndef MIN
 #define MIN(a,b) ((a<b)?a:b)
 #endif
@@ -2825,6 +2826,7 @@
 	struct stat statbuf;
 	char        *buff;
 	int         curr,left,len,fd;
+	mm_segment_t oldfs;
 
 	/* if called from chandev_register_and_probe & 
 	   the driver is compiled into the kernel the
@@ -2835,6 +2837,7 @@
 	if(in_interrupt()||current->fs->root==NULL)
 		return;
 	atomic_set(&chandev_conf_read,TRUE);
+	oldfs = get_fs();
 	set_fs(KERNEL_DS);
 	if(stat(CHANDEV_FILE,&statbuf)==0)
 	{
@@ -2859,7 +2862,7 @@
 			vfree(buff);
 		}
 	}
-	set_fs(USER_DS);
+	set_fs(oldfs);
 }
 
 static void chandev_read_conf_if_necessary(void)
diff -urN linux-2.5.39/drivers/s390/net/ctcmain.c linux-2.5.39-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.39/drivers/s390/net/ctcmain.c	Fri Sep 27 23:49:44 2002
+++ linux-2.5.39-s390/drivers/s390/net/ctcmain.c	Mon Sep 30 14:34:55 2002
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 
 #include <linux/signal.h>
 #include <linux/string.h>
@@ -195,7 +196,7 @@
 	unsigned long doios_multi;
 	unsigned long txlen;
 	unsigned long tx_time;
-	struct timeval send_stamp;
+	struct timespec send_stamp;
 } ctc_profile;
 
 /**
@@ -976,10 +977,10 @@
 	int            first = 1;
 	int            i;
 
-	struct timeval done_stamp = xtime;
+	struct timespec done_stamp = xtime;
 	unsigned long duration = 
 		(done_stamp.tv_sec - ch->prof.send_stamp.tv_sec) * 1000000 +
-		done_stamp.tv_usec - ch->prof.send_stamp.tv_usec;
+		(done_stamp.tv_nsec - ch->prof.send_stamp.tv_nsec) / 1000;
 	if (duration > ch->prof.tx_time)
 		ch->prof.tx_time = duration;
 
diff -urN linux-2.5.39/drivers/s390/net/ctctty.c linux-2.5.39-s390/drivers/s390/net/ctctty.c
--- linux-2.5.39/drivers/s390/net/ctctty.c	Fri Sep 27 23:50:18 2002
+++ linux-2.5.39-s390/drivers/s390/net/ctctty.c	Mon Sep 30 14:34:55 2002
@@ -596,21 +596,17 @@
 	ctc_tty_info *info;
 	unsigned long flags;
 
-#warning FIXME [kj] Consider using spinlocks.
-	save_flags(flags);
-	cli();
-	if (!tty) {
-		restore_flags(flags);
+	if (!tty)
 		return;
-	}
+	spin_lock_irqsave(&ctc_tty_lock, flags);
 	info = (ctc_tty_info *) tty->driver_data;
 	if (ctc_tty_paranoia_check(info, tty->device, "ctc_tty_flush_buffer")) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&ctc_tty_lock, flags);
 		return;
 	}
 	skb_queue_purge(&info->tx_queue);
 	info->lsr |= UART_LSR_TEMT;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ctc_tty_lock, flags);
 	wake_up_interruptible(&tty->write_wait);
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
 	    tty->ldisc.write_wakeup)
@@ -689,10 +685,9 @@
 	uint result;
 	ulong flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ctc_tty_lock, flags);
 	status = info->lsr;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ctc_tty_lock, flags);
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
 	put_user(result, (uint *) value);
 	return 0;
@@ -708,10 +703,9 @@
 	ulong flags;
 
 	control = info->mcr;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ctc_tty_lock, flags);
 	status = info->msr;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ctc_tty_lock, flags);
 	result = ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
 	    | ((control & UART_MCR_DTR) ? TIOCM_DTR : 0)
 	    | ((status & UART_MSR_DCD) ? TIOCM_CAR : 0)
@@ -942,11 +936,10 @@
 	printk(KERN_DEBUG "ctc_tty_block_til_ready before block: %s%d, count = %d\n",
 	       CTC_TTY_NAME, info->line, info->count);
 #endif
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ctc_tty_lock, flags);
 	if (!(tty_hung_up_p(filp)))
 		info->count--;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ctc_tty_lock, flags);
 	info->blocked_open++;
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1053,16 +1046,14 @@
 ctc_tty_close(struct tty_struct *tty, struct file *filp)
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
-	unsigned long saveflags;
 	ulong flags;
 	ulong timeout;
 
 	if (!info || ctc_tty_paranoia_check(info, tty->device, "ctc_tty_close"))
 		return;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ctc_tty_lock, flags);
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&ctc_tty_lock, flags);
 #ifdef CTC_DEBUG_MODEM_OPEN
 		printk(KERN_DEBUG "ctc_tty_close return after tty_hung_up_p\n");
 #endif
@@ -1086,7 +1077,7 @@
 		info->count = 0;
 	}
 	if (info->count) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 #ifdef CTC_DEBUG_MODEM_OPEN
 		printk(KERN_DEBUG "ctc_tty_close after info->count != 0\n");
 #endif
@@ -1117,7 +1108,9 @@
 		timeout = jiffies + HZ;
 		while (!(info->lsr & UART_LSR_TEMT)) {
 			set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irqrestore(&ctc_tty_lock, flags);
 			schedule_timeout(20);
+			spin_lock_irqsave(&ctc_tty_lock, flags);
 			if (time_after(jiffies,timeout))
 				break;
 		}
@@ -1127,9 +1120,7 @@
 		tty->driver.flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
-	spin_lock_irqsave(&ctc_tty_lock, saveflags);
 	info->tty = 0;
-	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
 	tty->closing = 0;
 	if (info->blocked_open) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1138,7 +1129,7 @@
 	}
 	info->flags &= ~(CTC_ASYNC_NORMAL_ACTIVE | CTC_ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ctc_tty_lock, flags);
 #ifdef CTC_DEBUG_MODEM_OPEN
 	printk(KERN_DEBUG "ctc_tty_close normal exit\n");
 #endif
diff -urN linux-2.5.39/drivers/s390/net/iucv.c linux-2.5.39-s390/drivers/s390/net/iucv.c
--- linux-2.5.39/drivers/s390/net/iucv.c	Fri Sep 27 23:49:04 2002
+++ linux-2.5.39-s390/drivers/s390/net/iucv.c	Mon Sep 30 14:34:55 2002
@@ -302,7 +302,7 @@
 	if (debuglevel < 3)
 		return;
 
-	printk(KERN_DEBUG __FUNCTION__ ": %s\n", title);
+	printk(KERN_DEBUG "%s\n", title);
 	printk("  ");
 	for (i = 0; i < len; i++) {
 		if (!(i % 16) && i != 0)
@@ -318,7 +318,7 @@
 #define iucv_debug(lvl, fmt, args...) \
 do { \
 	if (debuglevel >= lvl) \
-		printk(KERN_DEBUG __FUNCTION__ ": " fmt "\n" , ## args); \
+		printk(KERN_DEBUG "%s: " fmt "\n", __FUNCTION__ , ## args); \
 } while (0)
 
 #else
@@ -2183,14 +2183,13 @@
 iucv_irq_handler(struct pt_regs *regs, __u16 code)
 {
 	iucv_irqdata *irqdata;
-	int          cpu = smp_processor_id();
 
-	irq_enter(cpu, 0x4000);
+	irq_enter();
 
 	irqdata = kmalloc(sizeof(iucv_irqdata), GFP_ATOMIC);
 	if (!irqdata) {
 		printk(KERN_WARNING "%s: out of memory\n", __FUNCTION__);
-		irq_exit(cpu, 0x4000);
+		irq_exit();
 		return;
 	}
 
@@ -2206,7 +2205,7 @@
 		mark_bh(IMMEDIATE_BH);
 	}
 
-	irq_exit(cpu, 0x4000);
+	irq_exit();
 	return;
 }
 
diff -urN linux-2.5.39/drivers/s390/net/lcs.c linux-2.5.39-s390/drivers/s390/net/lcs.c
--- linux-2.5.39/drivers/s390/net/lcs.c	Fri Sep 27 23:49:06 2002
+++ linux-2.5.39-s390/drivers/s390/net/lcs.c	Mon Sep 30 14:35:09 2002
@@ -126,6 +126,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/tqueue.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
diff -urN linux-2.5.39/drivers/s390/net/netiucv.c linux-2.5.39-s390/drivers/s390/net/netiucv.c
--- linux-2.5.39/drivers/s390/net/netiucv.c	Fri Sep 27 23:50:19 2002
+++ linux-2.5.39-s390/drivers/s390/net/netiucv.c	Mon Sep 30 14:34:55 2002
@@ -88,7 +88,7 @@
 	unsigned long doios_multi;
 	unsigned long txlen;
 	unsigned long tx_time;
-	struct timeval send_stamp;
+	struct timespec send_stamp;
 } connection_profile;
 
 /**
diff -urN linux-2.5.39/drivers/s390/qdio.c linux-2.5.39-s390/drivers/s390/qdio.c
--- linux-2.5.39/drivers/s390/qdio.c	Fri Sep 27 23:49:13 2002
+++ linux-2.5.39-s390/drivers/s390/qdio.c	Mon Sep 30 14:34:55 2002
@@ -245,26 +245,21 @@
 static void qdio_wait_nonbusy(unsigned int timeout)
 {
         unsigned int start;
-        unsigned long flags;
         char dbf_text[15];
 
 	sprintf(dbf_text,"wtnb%4x",timeout);
 	QDIO_DBF_TEXT3(0,trace,dbf_text);
 
 	start=qdio_get_millis();
-	save_flags(flags); cli();
 	for (;;) {
 		set_task_state(current,TASK_INTERRUPTIBLE);
 		if (qdio_get_millis()-start>timeout) {
 			goto out;
 		}
-		restore_flags(flags);
 		schedule_timeout(((start+timeout-qdio_get_millis())>>10)*HZ);
-		save_flags(flags); cli();
 	}
 out:
 	set_task_state(current,TASK_RUNNING);
-	restore_flags(flags);
 }
 
 static int qdio_wait_for_no_use_count(atomic_t *use_count)

