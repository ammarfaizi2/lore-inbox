Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268440AbRHKQKh>; Sat, 11 Aug 2001 12:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268453AbRHKQKU>; Sat, 11 Aug 2001 12:10:20 -0400
Received: from t2.redhat.com ([199.183.24.243]:14833 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S268440AbRHKQKB>; Sat, 11 Aug 2001 12:10:01 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15VYRl-0002aB-00@the-village.bc.nu> 
In-Reply-To: <E15VYRl-0002aB-00@the-village.bc.nu> 
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: moz@compsoc.man.ac.uk (John Levon), linux-kernel@vger.kernel.org
Subject: Re: complete_and_exit 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Aug 2001 17:06:39 +0100
Message-ID: <12089.997545999@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > Is complete_and_exit() going to be in 2.4.8 ? 

>  I've no idea. It depends whether Linus takes it when its fed to him
> or not.

It was fed to him the same time it was fed to you. Time for a retry, I 
suppose.

Index: drivers/i2o/i2o_block.c
===================================================================
RCS file: /inst/cvs/linux/drivers/i2o/i2o_block.c,v
retrieving revision 1.3.2.25
diff -u -r1.3.2.25 i2o_block.c
--- drivers/i2o/i2o_block.c	2001/07/20 08:52:40	1.3.2.25
+++ drivers/i2o/i2o_block.c	2001/08/11 16:04:45
@@ -61,6 +61,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
+#include <linux/completion.h>
 #include <asm/io.h>
 #include <asm/atomic.h>
 #include <linux/smp_lock.h>
@@ -187,7 +188,7 @@
  * evt_msg contains the last event.
  */
 static DECLARE_MUTEX_LOCKED(i2ob_evt_sem);
-static DECLARE_MUTEX_LOCKED(i2ob_thread_dead);
+static DECLARE_COMPLETION(i2ob_thread_dead);
 static spinlock_t i2ob_evt_lock = SPIN_LOCK_UNLOCKED;
 static u32 evt_msg[MSG_FRAME_SIZE>>2];
 
@@ -859,7 +860,7 @@
 		}
 	};
 
-	up_and_exit(&i2ob_thread_dead,0);
+	complete_and_exit(&i2ob_thread_dead,0);
 	return 0;
 }
 
@@ -2002,7 +2003,7 @@
 			printk("waiting...");
 		}
 		/* Be sure it died */
-		down(&i2ob_thread_dead);
+		wait_for_completion(&i2ob_thread_dead);
 		printk("done.\n");
 	}
 
Index: drivers/i2o/i2o_core.c
===================================================================
RCS file: /inst/cvs/linux/drivers/i2o/i2o_core.c,v
retrieving revision 1.3.2.25
diff -u -r1.3.2.25 i2o_core.c
--- drivers/i2o/i2o_core.c	2001/05/14 10:36:06	1.3.2.25
+++ drivers/i2o/i2o_core.c	2001/08/11 16:04:48
@@ -43,6 +43,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <asm/semaphore.h>
+#include <linux/completion.h>
 
 #include <asm/io.h>
 #include <linux/reboot.h>
@@ -206,7 +207,7 @@
  */
  
 static DECLARE_MUTEX(evt_sem);
-static DECLARE_MUTEX_LOCKED(evt_dead);
+static DECLARE_COMPLETION(evt_dead);
 DECLARE_WAIT_QUEUE_HEAD(evt_wait);
 
 static struct notifier_block i2o_reboot_notifier =
@@ -905,7 +906,7 @@
 			dprintk(KERN_INFO "I2O event thread dead\n");
 			printk("exiting...");
 			evt_running = 0;
-			up_and_exit(&evt_dead, 0);
+			complete_and_exit(&evt_dead, 0);
 		}
 
 		/* 
@@ -3427,7 +3428,7 @@
 		stat = kill_proc(evt_pid, SIGTERM, 1);
 		if(!stat) {
 			printk("waiting...");
-			down(&evt_dead);
+			wait_for_completion(&evt_dead);
 		}
 		printk("done.\n");
 	}
Index: drivers/net/8139too.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/8139too.c,v
retrieving revision 1.1.2.28
diff -u -r1.1.2.28 8139too.c
--- drivers/net/8139too.c	2001/07/19 07:54:26	1.1.2.28
+++ drivers/net/8139too.c	2001/08/11 16:04:51
@@ -137,7 +137,7 @@
 */
 
 #define DRV_NAME	"8139too"
-#define DRV_VERSION	"0.9.18"
+#define DRV_VERSION	"0.9.18a"
 
 
 #include <linux/config.h>
@@ -152,10 +152,10 @@
 #include <linux/delay.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
+#include <linux/completion.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-
 #define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver " DRV_VERSION
 #define PFX DRV_NAME ": "
 
@@ -585,7 +585,7 @@
 	chip_t chipset;
 	pid_t thr_pid;
 	wait_queue_head_t thr_wait;
-	struct semaphore thr_exited;
+	struct completion thr_exited;
 	u32 rx_config;
 	struct rtl_extra_stats xstats;
 };
@@ -970,7 +970,7 @@
 	tp->mmio_addr = ioaddr;
 	spin_lock_init (&tp->lock);
 	init_waitqueue_head (&tp->thr_wait);
-	init_MUTEX_LOCKED (&tp->thr_exited);
+	init_completion (&tp->thr_exited);
 
 	/* dev is fully set up and ready to use now */
 	DPRINTK("about to register device named %s (%p)...\n", dev->name, dev);
@@ -1632,7 +1632,7 @@
 		rtnl_unlock ();
 	}
 
-	up_and_exit (&tp->thr_exited, 0);
+	complete_and_exit (&tp->thr_exited, 0);
 }
 
 
@@ -2138,7 +2138,7 @@
 			printk (KERN_ERR "%s: unable to signal thread\n", dev->name);
 			return ret;
 		}
-		down (&tp->thr_exited);
+		wait_for_completion (&tp->thr_exited);
 	}
 
 	DPRINTK ("%s: Shutting down ethercard, status was 0x%4.4x.\n",
Index: drivers/usb/hub.c
===================================================================
RCS file: /inst/cvs/linux/drivers/usb/hub.c,v
retrieving revision 1.2.2.41
diff -u -r1.2.2.41 hub.c
--- drivers/usb/hub.c	2001/05/14 09:53:16	1.2.2.41
+++ drivers/usb/hub.c	2001/08/11 16:04:52
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/completion.h>
 #include <linux/sched.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -36,7 +37,7 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(khubd_wait);
 static int khubd_pid = 0;			/* PID of khubd */
-static DECLARE_MUTEX_LOCKED(khubd_exited);
+static DECLARE_COMPLETION(khubd_exited);
 
 static int usb_get_hub_descriptor(struct usb_device *dev, void *data, int size)
 {
@@ -781,7 +782,7 @@
 
 	dbg("usb_hub_thread exiting");
 
-	up_and_exit(&khubd_exited, 0);
+	complete_and_exit(&khubd_exited, 0);
 }
 
 static struct usb_device_id hub_id_table [] = {
@@ -834,7 +835,7 @@
 	/* Kill the thread */
 	ret = kill_proc(khubd_pid, SIGTERM, 1);
 
-	down(&khubd_exited);
+	wait_for_completion(&khubd_exited);
 
 	/*
 	 * Hub resources are freed for us by usb_deregister. It calls
Index: fs/jffs/inode-v23.c
===================================================================
RCS file: /inst/cvs/linux/fs/jffs/Attic/inode-v23.c,v
retrieving revision 1.1.2.12
diff -u -r1.1.2.12 inode-v23.c
--- fs/jffs/inode-v23.c	2001/06/28 11:16:55	1.1.2.12
+++ fs/jffs/inode-v23.c	2001/08/11 16:04:54
@@ -157,7 +157,7 @@
 		D1(printk (KERN_NOTICE "jffs_put_super(): Telling gc thread to die.\n"));
 		send_sig(SIGKILL, c->gc_task, 1);
 	}
-	down (&c->gc_thread_sem);
+	wait_for_completion(&c->gc_thread_comp);
 
 	D1(printk (KERN_NOTICE "jffs_put_super(): Successfully waited on thread.\n"));
 
Index: fs/jffs/intrep.c
===================================================================
RCS file: /inst/cvs/linux/fs/jffs/Attic/intrep.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 intrep.c
--- fs/jffs/intrep.c	2001/02/24 19:01:45	1.1.2.5
+++ fs/jffs/intrep.c	2001/08/11 16:04:56
@@ -3008,7 +3008,7 @@
 
 	current->session = 1;
 	current->pgrp = 1;
-	init_MUTEX_LOCKED(&c->gc_thread_sem); /* barrier */ 
+	init_completion(&c->gc_thread_comp); /* barrier */ 
 	spin_lock_irq(&current->sigmask_lock);
 	siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 	recalc_sigpending(current);
@@ -3055,7 +3055,7 @@
 				D1(printk("jffs_garbage_collect_thread(): SIGKILL received.\n"));
 				c->gc_task = NULL;
 				unlock_kernel();
-				up_and_exit(&c->gc_thread_sem, 0);
+				complete_and_exit(&c->gc_thread_comp, 0);
 			}
 		}
 
Index: include/linux/jffs.h
===================================================================
RCS file: /inst/cvs/linux/include/linux/jffs.h,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 jffs.h
--- include/linux/jffs.h	2000/12/05 10:51:21	1.1.1.1.2.2
+++ include/linux/jffs.h	2001/08/11 16:04:58
@@ -22,6 +22,8 @@
 
 #define JFFS_VERSION_STRING "1.0"
 
+#include <linux/completion.h>
+
 /* This is a magic number that is used as an identification number for
    this file system.  It is written to the super_block structure.  */
 #define JFFS_MAGIC_SB_BITMASK 0x07c0  /* 1984 */
@@ -185,7 +187,7 @@
 	struct jffs_delete_list *delete_list; /* Track deleted files.  */
 	pid_t thread_pid;		/* GC thread's PID */
 	struct task_struct *gc_task;	/* GC task struct */
-	struct semaphore gc_thread_sem; /* GC thread exit mutex */
+	struct completion gc_thread_comp; /* GC thread exit mutex */
 	__u32 gc_minfree_threshold;	/* GC trigger thresholds */
 	__u32 gc_maxdirty_threshold;
 };
Index: include/linux/kernel.h
===================================================================
RCS file: /inst/cvs/linux/include/linux/kernel.h,v
retrieving revision 1.1.1.1.2.18
diff -u -r1.1.1.1.2.18 kernel.h
--- include/linux/kernel.h	2001/06/13 06:41:40	1.1.1.1.2.18
+++ include/linux/kernel.h	2001/08/11 16:04:58
@@ -45,14 +45,14 @@
 #define FASTCALL(x)	x
 #endif
 
-struct semaphore;
+struct completion;
 
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
-NORET_TYPE void up_and_exit(struct semaphore *, long)
+NORET_TYPE void complete_and_exit(struct completion *, long)
 	ATTRIB_NORET;
 extern int abs(int);
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
Index: kernel/exit.c
===================================================================
RCS file: /inst/cvs/linux/kernel/exit.c,v
retrieving revision 1.3.2.32
diff -u -r1.3.2.32 exit.c
--- kernel/exit.c	2001/06/02 14:40:18	1.3.2.32
+++ kernel/exit.c	2001/08/11 16:04:58
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/completion.h>
 #include <linux/tty.h>
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
@@ -473,10 +474,10 @@
 	goto fake_volatile;
 }
 
-NORET_TYPE void up_and_exit(struct semaphore *sem, long code)
+NORET_TYPE void complete_and_exit(struct completion *comp, long code)
 {
-	if (sem)
-		up(sem);
+	if (comp)
+		complete(comp);
 	
 	do_exit(code);
 }
Index: kernel/ksyms.c
===================================================================
RCS file: /inst/cvs/linux/kernel/ksyms.c,v
retrieving revision 1.3.2.81
diff -u -r1.3.2.81 ksyms.c
--- kernel/ksyms.c	2001/08/11 11:18:55	1.3.2.81
+++ kernel/ksyms.c	2001/08/11 16:04:58
@@ -429,7 +429,7 @@
 EXPORT_SYMBOL(iomem_resource);
 
 /* process management */
-EXPORT_SYMBOL(up_and_exit);
+EXPORT_SYMBOL(complete_and_exit);
 EXPORT_SYMBOL(__wake_up);
 EXPORT_SYMBOL(wake_up_process);
 EXPORT_SYMBOL(sleep_on);



--
dwmw2


