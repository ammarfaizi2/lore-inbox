Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbRBZOe1>; Mon, 26 Feb 2001 09:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbRBZOcT>; Mon, 26 Feb 2001 09:32:19 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130255AbRBZO3V>;
	Mon, 26 Feb 2001 09:29:21 -0500
Date: Mon, 26 Feb 2001 12:49:31 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] quick reboot on i386
Message-ID: <20010226124931.A20095@ugly.wh8.tu-dresden.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi there,

remember quarterdeck's quickreboot from "good" (*cough*) old D{o|O}S
days? here it is for linux! it's only of limited use, especially
in it's current state, but some people might find it useful.

the first patch is the kernel patch. note, that it makes qreboot the
default, if you specify reboot=q on the kernel command line.
to enforce a long (i.e., normal) reboot, you need a modified version
of sysvinit - this is the second patch. it is a bit debian-specific
(in the script part), but this shouldn't matter much.

have fun!

best regards

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Nothing is fool-proof to a sufficiently talented fool.

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Description: the QReboot kernel patch
Content-Disposition: attachment; filename="linux-2.4.2.patch"

diff -ur linux-2.4.2-org/arch/i386/kernel/process.c linux-2.4.2/arch/i386/kernel/process.c
--- linux-2.4.2-org/arch/i386/kernel/process.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.2/arch/i386/kernel/process.c	Thu Feb 22 18:26:45 2001
@@ -153,11 +153,15 @@
 static long no_idt[2];
 static int reboot_mode;
 static int reboot_thru_bios;
+static int reboot_quick;
 
 static int __init reboot_setup(char *str)
 {
 	while(1) {
 		switch (*str) {
+		case 'q': /* "quick" reboot (only reload operating system) */
+			reboot_quick = 1;
+			break;
 		case 'w': /* "warm" reboot (no memory testing etc) */
 			reboot_mode = 0x1234;
 			break;
@@ -251,12 +255,61 @@
 			break;
 }
 
+/* The idea for the following code is stolen form Quarterdeck's QuickReboot.
+   However, it is quite problematic, because after switching back to real mode
+   it relies on the BIOS-variables (including IDT) being in the same state
+   as before the BIOS loaded the system the first time. If you boot with LILO,
+   you should have no problems with it, as LILO does not change critical data,
+   AFAIK. Problems begin, when you use LOADLIN - then DOS and some drivers you
+   possibly loaded have scrambled your BIOS data. In this case you need
+   something like Quarterdeck's DOSDATA.SYS. For more info on this topic look
+   at http://www.inf.tu-dresden.de/cgi-bin/cgiwrap/ob6/archive?info%20bs.asm
+   The PCI-Bus is not reset and thus may cause malfunction.
+   It is also known, that at least some SCSI-systems hang upon QReboot.
+
+   Setup stack, reset drives and reload operating system.
+*/
+static unsigned char real_mode_reinit [] =
+{
+	0x0f, 0x20, 0xc0,               /* mov  eax,cr0         */
+	0x66, 0x83, 0xe0, 0x16,         /* and  eax,16h         */
+	0x0f, 0x22, 0xc0,               /* mov  cr0,eax         */
+	0x0f, 0x22, 0xd8,               /* mov  cr3,eax         */
+	0xea, 0x12, 0x0f, 0x00, 0x00,   /* jmp  far rm          */
+	0x33, 0xc0,                 /* rm: xor  ax,ax           */
+	0x8e, 0xd8,                     /* mov  ds,ax           */
+	0x8e, 0xd0,                     /* mov  ss,ax           */
+	0xbc, 0x00, 0x7c,               /* mov  sp,7c00h        */
+	/* the following code searches for my qreboot-helper and uses it */
+	0xbf, 0xe0, 0x01,               /* mov  di,1e0h         */
+	0xb9, 0x80, 0x00,               /* mov  cx,80h          */
+	0x81, 0x3d, 0xcd, 0x19,     /* lo: cmp  [di],19cdh      */
+	0x74, 0x16,                     /* je   ma              */
+	0x47,                           /* inc  di              */
+	0xe2, 0xf7,                     /* loop lo              */
+	/* reset video mode, drives and reload system */
+	0xb8, 0x03, 0x00,           /* rb: mov  ax,3            */
+	0xcd, 0x10,                     /* int  10h             */
+	0xb4, 0x00,                     /* mov  ah,0            */
+	0xb2, 0x00,                     /* mov  dl,0            */
+	0xcd, 0x13,                     /* int  13h             */
+	0xb4, 0x00,                     /* mov  ah,0            */
+	0xb2, 0x80,                     /* mov  dl,80h          */
+	0xcd, 0x13,                     /* int  13h             */
+	0xcd, 0x19,			/* int  19h             */
+	/* revector int 0e0h and let the helper-code clean up things */
+	0xc6, 0x45, 0x01, 0xe0,     /* ma: mov  [di+1],0e0h     */
+	0xc7, 0x06, 0x80, 0x03, 0x2a, 0x0f, /* mov [0e0h*4],offset rb */
+	0x8c, 0x0e, 0x82, 0x03,         /* mov  [0e0h*4+2],cs   */
+	0xcd, 0x19                      /* int  19h             */
+};
+
 /*
  * Switch to real mode and then execute the code
  * specified by the code and length parameters.
- * We assume that length will aways be less that 100!
+ * We assume that length will always be less than 240!
  */
-void machine_real_restart(unsigned char *code, int length)
+void copy_and_switch(unsigned char *code1, int len1, unsigned char *code2, int len2)
 {
 	unsigned long flags;
 
@@ -307,9 +360,9 @@
 	   off paging.  Copy it near the end of the first page, out of the way
 	   of BIOS variables. */
 
-	memcpy ((void *) (0x1000 - sizeof (real_mode_switch) - 100),
-		real_mode_switch, sizeof (real_mode_switch));
-	memcpy ((void *) (0x1000 - 100), code, length);
+	memcpy ((unsigned char *)0xf00, code1, len1);
+	if (code2)
+		memcpy ((unsigned char *)0xf00 + len1, code2, len2);
 
 	/* Set up the IDT for real mode. */
 
@@ -338,12 +391,15 @@
 	   and the cache, switches to real mode, and jumps to the BIOS reset
 	   entry point. */
 
-	__asm__ __volatile__ ("ljmp $0x0008,%0"
-				:
-				: "i" ((void *) (0x1000 - sizeof (real_mode_switch) - 100)));
+	__asm__ __volatile__ ("ljmp $0x0008,$0xf00");
+}
+
+void machine_real_restart(unsigned char *code, int length)
+{
+	copy_and_switch(real_mode_switch, sizeof (real_mode_switch), code, length);
 }
 
-void machine_restart(char * __unused)
+void machine_restart(char * mode)
 {
 #if CONFIG_SMP
 	/*
@@ -354,7 +410,7 @@
 	disable_IO_APIC();
 #endif
 
-	if(!reboot_thru_bios) {
+	if(!reboot_thru_bios && (!reboot_quick || mode)) {
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
 		for (;;) {
@@ -371,7 +427,21 @@
 		}
 	}
 
-	machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
+	if(reboot_quick && !mode) {
+
+		outb_p(0x34, 0x43);                     /* reset timer  */
+		outb_p(0xff, 0x40); outb_p(0xff, 0x40);
+
+		outb_p(0x11, 0x20); outb_p(0x08, 0x21); /* reset PICs   */
+		outb_p(0x04, 0x21); outb_p(0x01, 0x21); outb_p(0x00, 0x21);
+		outb_p(0x11, 0xa0); outb_p(0x70, 0xa1);
+		outb_p(0x02, 0xa1); outb_p(0x01, 0xa1); outb_p(0x00, 0xa1);
+
+		copy_and_switch(real_mode_reinit, sizeof (real_mode_reinit), 0, 0);
+
+	} else
+
+		machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
 }
 
 void machine_halt(void)
diff -ur linux-2.4.2-org/include/linux/reboot.h linux-2.4.2/include/linux/reboot.h
--- linux-2.4.2-org/include/linux/reboot.h	Fri Feb  9 23:46:13 2001
+++ linux-2.4.2/include/linux/reboot.h	Sun Feb 25 21:42:37 2001
@@ -23,6 +23,7 @@
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
+#define	LINUX_REBOOT_CMD_LRESTART	0x07654321
 #define	LINUX_REBOOT_CMD_HALT		0xCDEF0123
 #define	LINUX_REBOOT_CMD_CAD_ON		0x89ABCDEF
 #define	LINUX_REBOOT_CMD_CAD_OFF	0x00000000
diff -ur linux-2.4.2-org/kernel/sys.c linux-2.4.2/kernel/sys.c
--- linux-2.4.2-org/kernel/sys.c	Mon Oct 16 21:58:51 2000
+++ linux-2.4.2/kernel/sys.c	Sun Feb 25 21:45:23 2001
@@ -288,6 +288,12 @@
 		machine_restart(NULL);
 		break;
 
+	case LINUX_REBOOT_CMD_LRESTART:
+		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+		printk(KERN_EMERG "Restarting system (without qreboot).\n");
+		machine_restart("long");
+		break;
+
 	case LINUX_REBOOT_CMD_CAD_ON:
 		C_A_D = 1;
 		break;

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Description: the "enforce long reboot" sysvinit patch
Content-Disposition: attachment; filename="sysvinit278.patch"

diff -ur sysvinit-org/debian/etc/init.d/rc sysvinit/debian/etc/init.d/rc
--- sysvinit-org/debian/etc/init.d/rc	Sun Nov  7 16:35:31 1999
+++ sysvinit/debian/etc/init.d/rc	Sun Jul  2 12:33:25 2000
@@ -36,6 +36,7 @@
   trap ":" INT QUIT TSTP
 
   # Set onlcr to avoid staircase effect.
+  case $1 in 0|5|6) exec <>/dev/tty1 >&0 2>&1; chvt 1 &;; esac
   stty onlcr 0>&1
 
   # Now find out what the current and what the previous runlevel are.
@@ -68,6 +69,7 @@
 			startup $i stop
 		done
 	fi
+	sleep 1
 	# Now run the START scripts for this runlevel.
 	for i in /etc/rc$runlevel.d/S*
 	do
@@ -90,7 +92,7 @@
 			[ -f $previous_start ] && [ ! -f $stop ] && continue
 		fi
 		case "$runlevel" in
-			0|6)
+			0|5|6)
 				startup $i stop
 				;;
 			*)
diff -ur sysvinit-org/src/halt.c sysvinit/src/halt.c
--- sysvinit-org/src/halt.c	Mon Mar  9 21:08:38 1998
+++ sysvinit/src/halt.c	Sun Jul  2 12:32:02 2000
@@ -3,17 +3,18 @@
  *		It re-enables CTRL-ALT-DEL, so that a hard reboot can
  *		be done. If called as reboot, it will reboot the system.
  *
- *		If the system is not in runlevel 0 or 6, halt will just
+ *		If the system is not in runlevel 0, 5 or 6, halt will just
  *		execute a "shutdown -h" to halt the system, and reboot will
  *		execute an "shutdown -r". This is for compatibility with
  *		sysvinit 2.4.
  *
- * Usage:	halt [-n] [-w] [-d] [-f] [-p]
+ * Usage:	halt [-n] [-w] [-d] [-f] [-p] [-l]
  *		-n: don't sync before halting the system
  *		-w: only write a wtmp reboot record and exit.
  *		-d: don't write a wtmp record.
  *		-f: force halt/reboot, don't call shutdown.
  *		-p: power down the system (if possible, otherwise halt)
+ *		-l: force a long reboot (without qreboot)
  *
  *		Reboot and halt are both this program. Reboot
  *		is just a link to halt. Invoking the program
@@ -61,7 +62,7 @@
  */
 void usage()
 {
-	fprintf(stderr, "usage: %s [-n] [-w] [-d] [-f] [-i] [-p]\n", progname);
+	fprintf(stderr, "usage: %s [-n] [-w] [-d] [-f] [-i] [-p] [-l]\n", progname);
 	exit(1);
 }
 
@@ -153,6 +154,7 @@
 int main(int argc, char **argv)
 {
 	int do_reboot = 0;
+	int do_lreboot = 0;
 	int do_sync = 1;
 	int do_wtmp = 1;
 	int do_nothing = 0;
@@ -176,12 +178,13 @@
 	}
 
 	if (!strcmp(progname, "reboot")) do_reboot = 1;
+	if (!strcmp(progname, "lreboot")) do_reboot = do_lreboot = 1;
 	if (!strcmp(progname, "poweroff")) do_poweroff = 1;
 
 	/*
 	 *	Get flags
 	 */
-	while((c = getopt(argc, argv, ":idfnpwt:")) != EOF) {
+	while((c = getopt(argc, argv, ":idfnplwt:")) != EOF) {
 		switch(c) {
 			case 'n':
 				do_sync = 0;
@@ -202,6 +205,9 @@
 			case 'p':
 				do_poweroff = 1;
 				break;
+			case 'l':
+				do_lreboot = 1;
+				break;
 			case 't':
 				tm = optarg;
 				break;
@@ -218,8 +224,8 @@
 		 *	See if we are in runlevel 0 or 6.
 		 */
 		c = get_runlevel();
-		if (c != '0' && c != '6')
-			do_shutdown(do_reboot ? "-r" : "-h", tm);
+		if (c != '0' && c != '5' && c != '6')
+			do_shutdown(do_reboot ? do_lreboot ? "-l" : "-r" : "-h", tm);
 	}
 
 	/*
@@ -242,7 +248,7 @@
 		(void)ifdown();
 
 	if (do_reboot) {
-		init_reboot(BMAGIC_REBOOT);
+		init_reboot(do_lreboot ? BMAGIC_LREBOOT : BMAGIC_REBOOT);
 	} else {
 		/*
 		 *	Turn on hard reboot, CTRL-ALT-DEL will reboot now
diff -ur sysvinit-org/src/reboot.h sysvinit/src/reboot.h
--- sysvinit-org/src/reboot.h	Wed Sep 24 10:55:52 1997
+++ sysvinit/src/reboot.h	Sun Jul  2 12:32:02 2000
@@ -13,6 +13,7 @@
 #define BMAGIC_HARD	0x89ABCDEF
 #define BMAGIC_SOFT	0
 #define BMAGIC_REBOOT	0x01234567
+#define BMAGIC_LREBOOT	0x07654321
 #define BMAGIC_HALT	0xCDEF0123
 #define BMAGIC_POWEROFF	0x4321FEDC
 
diff -ur sysvinit-org/src/shutdown.c sysvinit/src/shutdown.c
--- sysvinit-org/src/shutdown.c	Sat Nov 13 17:39:01 1999
+++ sysvinit/src/shutdown.c	Sun Jul  2 12:32:02 2000
@@ -1,9 +1,10 @@
 /*
  * shutdown.c	Shut the system down.
  *
- * Usage:	shutdown [-krhfnc] time [warning message]
+ * Usage:	shutdown [-krlhfnc] time [warning message]
  *		  -k: don't really shutdown, only warn.
  *		  -r: reboot after shutdown.
+ *		  -l: reboot after shutdown (no qreboot).
  *		  -h: halt after shutdown.
  *		  -f: do a 'fast' reboot (skip fsck).
  *		  -F: Force fsck on reboot.
@@ -90,10 +91,11 @@
 void usage()
 {
  fprintf(stderr,
-	"Usage:\t  shutdown [-akrhfnc] [-t secs] time [warning message]\n"
+	"Usage:\t  shutdown [-akrlhfnc] [-t secs] time [warning message]\n"
 	"\t\t  -a:      use /etc/shutdown.allow\n"
 	"\t\t  -k:      don't really shutdown, only warn.\n"
 	"\t\t  -r:      reboot after shutdown.\n"
+	"\t\t  -l:      reboot after shutdown (no qreboot).\n"
 	"\t\t  -h:      halt after shutdown.\n"
 	"\t\t  -f:      do a 'fast' reboot (skip fsck).\n"
 	"\t\t  -F:      Force fsck on reboot.\n"
@@ -230,7 +232,7 @@
 }
 
 /*
- * Go to runlevel 0, 1 or 6.
+ * Go to runlevel 0, 1, 5 or 6.
  */
 void shutdown()
 {
@@ -309,7 +311,7 @@
   strcpy(down_level, "1");
 
   /* Process the options. */
-  while((c = getopt(argc, argv, "acqkrhnfFyt:g:i:")) != EOF) {
+  while((c = getopt(argc, argv, "acqkrlhnfFyt:g:i:")) != EOF) {
   	switch(c) {
 		case 'a': /* Access control. */
 			useacl = 1;
@@ -323,6 +325,9 @@
   		case 'r': /* Automatic reboot */
 			down_level[0] = '6';
   			break;
+  		case 'l': /* Automatic reboot without qreboot */
+			down_level[0] = '5';
+  			break;
   		case 'h': /* Halt after shutdown */
 			down_level[0] = '0';
   			break;
@@ -458,6 +463,9 @@
   switch(down_level[0]) {
 	case '0':
 		strcpy(newstate, "for system halt");
+		break;
+	case '5':
+		strcpy(newstate, "for reboot without qreboot");
 		break;
 	case '6':
 		strcpy(newstate, "for reboot");
Only in sysvinit/src: shutdown.c.orig

--/9DWx/yDrRhgMJTb--
