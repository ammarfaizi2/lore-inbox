Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131591AbQKQLIA>; Fri, 17 Nov 2000 06:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131924AbQKQLHw>; Fri, 17 Nov 2000 06:07:52 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:2555 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S131591AbQKQLHk>;
	Fri, 17 Nov 2000 06:07:40 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Nov 2000 10:37:35 +0000
Message-ID: <8004.974457455@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Missing up_and_exit() which is required for killing kernel threads on 
cleanup_module(). 

This patch also fixes JFFS and USB hub.c to use it. 

Index: include/linux/kernel.h
===================================================================
RCS file: /inst/cvs/linux/include/linux/kernel.h,v
retrieving revision 1.1.1.1.2.11
diff -u -r1.1.1.1.2.11 kernel.h
--- include/linux/kernel.h	2000/09/26 18:57:59	1.1.1.1.2.11
+++ include/linux/kernel.h	2000/11/17 10:30:05
@@ -45,10 +45,14 @@
 #define FASTCALL(x)	x
 #endif
 
+struct semaphore;
+
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 NORET_TYPE void do_exit(long error_code)
+	ATTRIB_NORET;
+NORET_TYPE void up_and_exit(struct semaphore *, long)
 	ATTRIB_NORET;
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
 extern long simple_strtol(const char *,char **,unsigned int);
Index: kernel/exit.c
===================================================================
RCS file: /inst/cvs/linux/kernel/exit.c,v
retrieving revision 1.3.2.29
diff -u -r1.3.2.29 exit.c
--- kernel/exit.c	2000/09/18 13:54:01	1.3.2.29
+++ kernel/exit.c	2000/11/17 10:30:05
@@ -467,6 +467,14 @@
 	goto fake_volatile;
 }
 
+NORET_TYPE void up_and_exit(struct semaphore *sem, long code)
+{
+	if (sem)
+		up(sem);
+	
+	do_exit(code);
+}
+
 asmlinkage long sys_exit(int error_code)
 {
 	do_exit((error_code&0xff)<<8);
Index: kernel/ksyms.c
===================================================================
RCS file: /inst/cvs/linux/kernel/ksyms.c,v
retrieving revision 1.3.2.66
diff -u -r1.3.2.66 ksyms.c
--- kernel/ksyms.c	2000/11/17 09:35:53	1.3.2.66
+++ kernel/ksyms.c	2000/11/17 10:30:05
@@ -418,6 +418,7 @@
 EXPORT_SYMBOL(iomem_resource);
 
 /* process management */
+EXPORT_SYMBOL(up_and_exit);
 EXPORT_SYMBOL(__wake_up);
 EXPORT_SYMBOL(wake_up_process);
 EXPORT_SYMBOL(sleep_on);
Index: drivers/usb/hub.c
===================================================================
RCS file: /inst/cvs/linux/drivers/usb/hub.c,v
retrieving revision 1.2.2.41
diff -u -r1.2.2.41 hub.c
--- drivers/usb/hub.c	2000/11/13 11:00:15	1.2.2.41
+++ drivers/usb/hub.c	2000/11/17 10:30:05
@@ -36,7 +36,7 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(khubd_wait);
 static int khubd_pid = 0;			/* PID of khubd */
-static int khubd_running = 0;
+static DECLARE_MUTEX_LOCKED(khubd_exited);
 
 static int usb_get_hub_descriptor(struct usb_device *dev, void *data, int size)
 {
@@ -741,8 +741,6 @@
 
 static int usb_hub_thread(void *__hub)
 {
-	khubd_running = 1;
-
 	lock_kernel();
 
 	/*
@@ -762,9 +760,8 @@
 	} while (!signal_pending(current));
 
 	dbg("usb_hub_thread exiting");
-	khubd_running = 0;
 
-	return 0;
+	up_and_exit(&khubd_exited, 0);
 }
 
 static struct usb_device_id hub_id_table [] = {
@@ -815,18 +812,8 @@
 
 	/* Kill the thread */
 	ret = kill_proc(khubd_pid, SIGTERM, 1);
-	if (!ret) {
-		/* Wait 10 seconds */
-		int count = 10 * 100;
 
-		while (khubd_running && --count) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(1);
-		}
-
-		if (!count)
-			err("giving up on killing khubd");
-	}
+	down(&khubd_exited);
 
 	/*
 	 * Hub resources are freed for us by usb_deregister. It calls
Index: fs/jffs/intrep.c
===================================================================
RCS file: /inst/cvs/linux/fs/jffs/Attic/intrep.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 intrep.c
--- fs/jffs/intrep.c	2000/11/15 12:15:06	1.1.2.5
+++ fs/jffs/intrep.c	2000/11/17 10:30:05
@@ -3054,9 +3054,8 @@
 			case SIGKILL:
 				D1(printk("jffs_garbage_collect_thread(): SIGKILL received.\n"));
 				c->gc_task = NULL;
-				up(&c->gc_thread_sem);
 				unlock_kernel();
-				return(0);
+				up_and_exit(&c->gc_thread_sem, 0);
 			}
 		}
 


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
