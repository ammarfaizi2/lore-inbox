Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTKPPuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 10:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKPPuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 10:50:32 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:5640 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S262868AbTKPPu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 10:50:28 -0500
Date: Sun, 16 Nov 2003 17:50:24 +0200
To: linux-kernel@vger.kernel.org
Subject: watchdog inconsistency.
Message-ID: <20031116155024.GB31957@nbase.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: gleb@nbase.co.il (Gleb Natapov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 There is inconsistency in fops->write() implementation in different watchdog drivers.
Some of them return number of bytes written while others return 1. 

I think the correct implementation should always return number of bytes written (we examine all the
buffer after all) otherwise "echo V > /dev/watchdog" doesn't work as expected (it doesn't stop watchdog).

The included patch fix watchdog drivers in linux-2.6.0-test9 (patch is trivial but isn't tested).


diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/i810-tco.c linux-2.6.0-test9.fix/drivers/char/watchdog/i810-tco.c
--- linux-2.6.0-test9/drivers/char/watchdog/i810-tco.c	2003-10-25 20:42:47.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/i810-tco.c	2003-11-16 15:23:21.000000000 +0200
@@ -232,9 +232,8 @@
 
 		/* someone wrote to us, we should reload the timer */
 		tco_timer_reload ();
-		return 1;
 	}
-	return 0;
+	return len;
 }
 
 static int i810tco_ioctl (struct inode *inode, struct file *file,
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/ib700wdt.c linux-2.6.0-test9.fix/drivers/char/watchdog/ib700wdt.c
--- linux-2.6.0-test9/drivers/char/watchdog/ib700wdt.c	2003-10-25 20:44:43.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/ib700wdt.c	2003-11-16 15:03:16.000000000 +0200
@@ -161,9 +161,8 @@
 			}
 		}
 		ibwdt_ping();
-		return 1;
 	}
-	return 0;
+	return count;
 }
 
 static int
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/indydog.c linux-2.6.0-test9.fix/drivers/char/watchdog/indydog.c
--- linux-2.6.0-test9/drivers/char/watchdog/indydog.c	2003-10-25 20:44:45.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/indydog.c	2003-11-16 15:05:02.000000000 +0200
@@ -113,9 +113,8 @@
 			}
 		}
 		indydog_ping();
-		return 1;
 	}
-	return 0;
+	return len;
 }
 
 static int indydog_ioctl(struct inode *inode, struct file *file,
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/machzwd.c linux-2.6.0-test9.fix/drivers/char/watchdog/machzwd.c
--- linux-2.6.0-test9/drivers/char/watchdog/machzwd.c	2003-10-25 20:43:04.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/machzwd.c	2003-11-16 15:24:00.000000000 +0200
@@ -343,10 +343,9 @@
 		next_heartbeat = jiffies + ZF_USER_TIMEO;
 		dprintk("user ping at %ld\n", jiffies);
 		
-		return 1;
 	}
 
-	return 0;
+	return count;
 }
 
 static int zf_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/mixcomwd.c linux-2.6.0-test9.fix/drivers/char/watchdog/mixcomwd.c
--- linux-2.6.0-test9/drivers/char/watchdog/mixcomwd.c	2003-10-25 20:43:14.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/mixcomwd.c	2003-11-16 15:06:31.000000000 +0200
@@ -156,9 +156,8 @@
 			}
 		}
 		mixcomwd_ping();
-		return 1;
 	}
-	return 0;
+	return len;
 }
 
 static int mixcomwd_ioctl(struct inode *inode, struct file *file,
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/pcwd.c linux-2.6.0-test9.fix/drivers/char/watchdog/pcwd.c
--- linux-2.6.0-test9/drivers/char/watchdog/pcwd.c	2003-10-25 20:42:53.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/pcwd.c	2003-11-16 15:24:30.000000000 +0200
@@ -419,9 +419,8 @@
 			}
 		}
 		pcwd_send_heartbeat();
-		return 1;
 	}
-	return 0;
+	return len;
 }
 
 static int pcwd_open(struct inode *ino, struct file *filep)
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/sa1100_wdt.c linux-2.6.0-test9.fix/drivers/char/watchdog/sa1100_wdt.c
--- linux-2.6.0-test9/drivers/char/watchdog/sa1100_wdt.c	2003-10-25 20:43:35.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/sa1100_wdt.c	2003-11-16 15:25:03.000000000 +0200
@@ -106,7 +106,7 @@
 		OSMR3 = OSCR + pre_margin;
 	}
 
-	return len ? 1 : 0;
+	return len;
 }
 
 static struct watchdog_info ident = {
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/softdog.c linux-2.6.0-test9.fix/drivers/char/watchdog/softdog.c
--- linux-2.6.0-test9/drivers/char/watchdog/softdog.c	2003-10-25 20:43:30.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/softdog.c	2003-11-16 15:09:32.000000000 +0200
@@ -155,9 +155,8 @@
 			}
 		}
 		mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-		return 1;
 	}
-	return 0;
+	return len;
 }
 
 static int softdog_ioctl(struct inode *inode, struct file *file,
diff -urX /home/gleb/work/dontdiff linux-2.6.0-test9/drivers/char/watchdog/wdt.c linux-2.6.0-test9.fix/drivers/char/watchdog/wdt.c
--- linux-2.6.0-test9/drivers/char/watchdog/wdt.c	2003-10-25 20:43:40.000000000 +0200
+++ linux-2.6.0-test9.fix/drivers/char/watchdog/wdt.c	2003-11-16 15:10:09.000000000 +0200
@@ -265,9 +265,8 @@
 			}
 		}
 		wdt_ping();
-		return 1;
 	}
-	return 0;
+	return count;
 }
 
 /**
--
			Gleb.
