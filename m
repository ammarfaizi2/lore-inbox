Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265382AbUAPQPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbUAPQPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:15:00 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:12416 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265382AbUAPQOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:14:32 -0500
Date: Fri, 16 Jan 2004 17:13:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org,
       George Anzinger <george@mvista.com>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040116161341.GB258@elf.ucw.cz>
References: <200401161759.59098.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161759.59098.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> KGDB 2.0.3 is available at 
> http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> 
> Ethernet interface still doesn't work. It responds to gdb for a couple of 
> packets and then panics. gdb log for ethernet interface is pasted below.
> 
> It panics and enter kgdb_handle_exception recursively and silently. To see the 
> panic on screen make kgdb_handle_exception return immediately if 
> kgdb_connected is non-zero. 
> 
> Panic trace is pasted below. It panics in skb_release_data. Looks like skb 
> handling will have to changed to be have kgdb specific buffers.

Here are some cleanups. Added statics where possible, killed
superfluous volatile (what should it be good for?), changed calling
convention from 0 on success, 1 on failure to 0 on success, -ERRNO on
fail to be more consistent with rest of kernel, KGDB_DEG was not used
-> killed, fixed some comments to be more linux-like, and added
KERN_CRIT loglevel to "waiting for connection from remote gdb" -- to
ensure user sees the message.

Please apply,
								Pavel

--- tmp/linux/drivers/net/kgdb_eth.c	2004-01-16 17:00:07.000000000 +0100
+++ linux/drivers/net/kgdb_eth.c	2004-01-16 16:56:10.000000000 +0100
@@ -10,6 +10,7 @@
  *
  * Restructured for generic a gdb interface 
  * 	by Amit S. Kale <amitkale@emsyssoft.com>
+ * Some cleanups by Pavel Machek <pavel@suse.cz>
  */
 
 #include <linux/module.h>
@@ -47,10 +48,10 @@
 #define CHUNKSIZE 30
 #define MAXINCHUNK (CHUNKSIZE + 8)
 
-static char	kgdb_buf[GDB_BUF_SIZE] ;
-static int	kgdb_buf_in_inx ;
-static atomic_t	kgdb_buf_in_cnt ;
-static int	kgdb_buf_out_inx ;
+static char	kgdb_buf[GDB_BUF_SIZE];
+static int	kgdb_buf_in_inx;
+static atomic_t	kgdb_buf_in_cnt;
+static int	kgdb_buf_out_inx;
 
 static unsigned int	kgdb_remoteip = 0;
 static unsigned short	kgdb_listenport = 6443;
@@ -59,11 +60,12 @@
 static unsigned char	kgdb_remotemac[6] = {0xff,0xff,0xff,0xff,0xff,0xff};
 static unsigned char	kgdb_localmac[6] = {0xff,0xff,0xff,0xff,0xff,0xff};
 
-struct net_device *kgdb_netdevice = NULL;
-char		kgdbeth_sendbuf[MAXINCHUNK];
-int		kgdbeth_sendbufchars;
-irqreturn_t (*kgdbeth_irqhandler)(int, void *, struct pt_regs *) = NULL;
+static char		kgdbeth_sendbuf[MAXINCHUNK];
+static int		kgdbeth_sendbufchars;
+static irqreturn_t	(*kgdbeth_irqhandler)(int, void *, struct pt_regs *) = NULL;
+
 int		kgdbeth_is_trapped;
+struct net_device *kgdb_netdevice = NULL;
 
 /*
  * Get a char if available, return -1 if nothing available.
@@ -76,9 +78,9 @@
 	if (atomic_read(&kgdb_buf_in_cnt) != 0) {
 		int chr;
 
-		chr = kgdb_buf[kgdb_buf_out_inx++] ;
-		kgdb_buf_out_inx &= (GDB_BUF_SIZE - 1) ;
-		atomic_dec(&kgdb_buf_in_cnt) ;
+		chr = kgdb_buf[kgdb_buf_out_inx++];
+		kgdb_buf_out_inx &= (GDB_BUF_SIZE - 1);
+		atomic_dec(&kgdb_buf_in_cnt);
 		return chr;
 	}
 
@@ -382,7 +384,7 @@
 	extern void kgdb_respond_ok(void);
 	struct irqaction *ia_ptr;
 
-	sprintf(kgdb_netdev,"eth%d",kgdb_eth);
+	sprintf(kgdb_netdev, "eth%d", kgdb_eth);
 
 	for (kgdb_netdevice = dev_base;
 		kgdb_netdevice != NULL;
@@ -392,7 +394,7 @@
 		}
 	}
 	if (!kgdb_netdevice) {
-		printk("kgdbeth: Unable to find interface %s\n",kgdb_netdev);
+		printk("kgdbeth: Unable to find interface %s\n", kgdb_netdev);
 		return -1;
 	}
 	if (!(kgdb_netdevice->flags & IFF_UP)) {
@@ -418,7 +420,6 @@
 /*
  * Poll an ethernet interface for incoming characters
  */
-
 static void kgdbeth_rx_poll(void)
 {
 	if (!kgdbeth_is_trapped)
@@ -439,7 +440,7 @@
 static int
 kgdbeth_read_char(void)
 {
-	volatile int	chr;
+	int	chr;
 
 	while ((chr = read_char()) < 0) {
 		if (send_skb) {
@@ -488,12 +489,10 @@
 			(*ptr)++;
 		while((**ptr != delimiter) && (*(*ptr -1) != ':'));
 		if (i > 6)
-			break;
-	}
-	if (i != 6) {
-		return 1;
+			return -EINVAL;
 	}
-
+	if (i != 6)
+		return -EINVAL;
 	return 0;
 }
 
@@ -579,7 +578,6 @@
 		goto errout;
 
 	kgdb_serial = &kgdbeth_serial;
-
 	return 1;
 
 errout:
--- tmp/linux/kernel/kgdbstub.c	2004-01-16 17:00:07.000000000 +0100
+++ linux/kernel/kgdbstub.c	2004-01-16 16:56:51.000000000 +0100
@@ -8,13 +8,13 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
- *
  */
 
 /*
  * Copyright (C) 2000-2001 VERITAS Software Corporation.
  * Copyright (C) 2002-2004 Timesys Corporation
  * Copyright (C) 2003-2004 Amit S. Kale
+ * Copyright (C) 2004 Pavel Machek <pavel@suse.cz>
  *
  * Restructured KGDB for 2.6 kernels.
  * thread support, support for multiple processors,support for ia-32(x86) 
@@ -31,8 +31,6 @@
  * Modified for 386 by Jim Kingdon, Cygnus Support.
  * Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe <dave@gcom.com>
  * Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
- *  
-*  
  */
 
 #include <linux/string.h>
@@ -50,18 +48,14 @@
 #include <linux/notifier.h>
 #include <linux/module.h>
 #include <asm/cacheflush.h>
- 
+
 #ifdef CONFIG_KGDB_CONSOLE
 #include <linux/console.h>
 #endif
  
 #include <linux/init.h>
 
-
-
-/* DEBUGGING THE DEBUGGER */
-#undef KGDB_DEG
-/**************************/
+
 
 struct kgdb_arch *kgdb_ops = &arch_kgdb_ops;
 gdb_breakpoint_t kgdb_break[MAX_BREAKPOINTS];
@@ -84,10 +78,8 @@
 volatile int kgdb_connected;
 struct task_struct *kgdb_usethread, *kgdb_contthread;
 
-
 int debugger_step;
 atomic_t debugger_active;
-volatile int debugger_memerr_expected;
 
 /* 
  * Indicate to caller of kgdb_mem2hex or hex2mem that there has been an
@@ -245,11 +237,12 @@
 
 }
 
-/* convert the memory pointed to by mem into hex, placing result in buf */
-/* return a pointer to the last char put in buf (null) */
-/* If MAY_FAULT is non-zero, then we should set kgdb_memerr in response to
-   a fault; if zero treat a fault like any other fault in the stub.  */
-
+/*
+ * convert the memory pointed to by mem into hex, placing result in buf
+ * return a pointer to the last char put in buf (null)
+ * If MAY_FAULT is non-zero, then we should set kgdb_memerr in response to
+ * a fault; if zero treat a fault like any other fault in the stub.
+ */
 char *kgdb_mem2hex(char *mem, char *buf, int count, int can_fault)
 {
 	int i;
@@ -285,8 +278,8 @@
 }
 
 /*
- * WHILE WE FIND NICE HEX CHARS, BUILD A LONG
- * RETURN NUMBER OF CHARS PROCESSED           
+ * While we find nice hex chars, build a longValue.
+ * Return number of chars processed.
  */
 int kgdb_hexToLong(char **ptr, long *longValue)
 {
@@ -388,7 +381,7 @@
 	procindebug[processor] = 1;
 	current->thread.debuggerinfo = regs;
 
-	/* Wait till master processor goes completely into the debugger */
+	/* Wait till master processor goes completely into the debugger. FIXME: this looks racy */
 	while (!procindebug[atomic_read(&debugger_active) - 1]) {
 		int i = 10;	/* an arbitrary number */
 
@@ -411,7 +404,6 @@
 	spin_unlock(slavecpulocks + processor);
 	local_irq_restore(flags);
 }
-
 #endif
 
 static void get_mem (char *addr, unsigned char *buf, int count)
@@ -551,7 +543,7 @@
 	return ret;
 }
 
-int shadow_pid(int realpid)
+static inline int shadow_pid(int realpid)
 {
 	if (realpid) {
 		return realpid;
@@ -562,7 +554,6 @@
 /*
  * This function does all command procesing for interfacing to gdb.
  */
-
 int kgdb_handle_exception(int exVector, int signo, int err_code, 
                      struct pt_regs *linux_regs)
 {
@@ -1117,15 +1108,15 @@
 	/*
 	 * Call GDB routine to setup the exception vectors for the debugger
 	 */
-	set_debug_traps() ;
+	set_debug_traps();
 
 	/*
 	 * Call the breakpoint() routine in GDB to start the debugging
 	 * session.
 	 */
-	printk("Waiting for connection from remote gdb... ");
+	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
 	breakpoint() ;
-	printk("Connected.\n");
+	printk(KERN_CRIT "Connected.\n");
 }
 
 #ifdef CONFIG_KGDB_CONSOLE

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
