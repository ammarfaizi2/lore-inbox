Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262892AbTCSCJX>; Tue, 18 Mar 2003 21:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262893AbTCSCJX>; Tue, 18 Mar 2003 21:09:23 -0500
Received: from rrcs-nys-24-97-68-224.biz.rr.com ([24.97.68.224]:31346 "EHLO
	lando.vestal.timesys") by vger.kernel.org with ESMTP
	id <S262892AbTCSCJV>; Tue, 18 Mar 2003 21:09:21 -0500
Message-ID: <3E77D398.6030709@goodmis.org>
Date: Tue, 18 Mar 2003 21:19:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] read(tty, (char *)-1, 1) exempt from EFAULT ?
References: <3E773A83.9020800@BitWagon.com>
In-Reply-To: <3E773A83.9020800@BitWagon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

John Reiser posted a question on c.o.l.d.s about why reading from
a tty with a bad buffer doesn't return -EFAULT to the user.
I looked into it and believe that this is a minor bug. Below is
part of John's post and below that is my patch.

John Reiser wrote:
> Why is reading from a tty exempt from EFAULT?
> 
> -----readerr.c
> #include <errno.h>
> 
> int
> main()
> {
>     int v = read(0,(char *)-1,1);  /* should get EFAULT [14] */
>     printf("read(0,(char *)-1,1)=0x%x  errno=%d\n", v, errno);
>     return v;
> }
> -----
> $ gcc -o readerr readerr.c
> $ ./readerr </dev/tty; echo $?
>    # type <Enter>
> read(0,(char *)-1,1)=0x1  errno=0
> 1
> $ date | ./readerr; echo $?
> read(0,(char *)-1,1)=0xffffffff  errno=14
> 255
> $


===========================
--- linux-2.4.20/drivers/char/n_tty.c_orig	Tue Mar 18 20:19:33 2003
+++ linux-2.4.20/drivers/char/n_tty.c	Tue Mar 18 21:06:57 2003
@@ -1030,7 +1030,10 @@
  				break;
  			cs = tty->link->ctrl_status;
  			tty->link->ctrl_status = 0;
-			put_user(cs, b++);
+			if (put_user(cs, b++)) {
+				retval = -EFAULT;
+				break;
+			}
+                               retval = -EFAULT;
+                               break;
+                       }
                         nr--;
                         break;
                 }
@@ -1069,7 +1072,10 @@

                 /* Deal with packet mode. */
                 if (tty->packet && b == buf) {
-                       put_user(TIOCPKT_DATA, b++);
+                       if (put_user(TIOCPKT_DATA, b++)) {
+                               retval = -EFAULT;
+                               break;
+                       }
                         nr--;
                 }

@@ -1096,12 +1102,17 @@
                                 spin_unlock_irqrestore(&tty->read_lock, 
flags);

                                 if (!eol || (c != __DISABLED_CHAR)) {
-                                       put_user(c, b++);
+                                       if (put_user(c, b++)) {
+                                               retval = -EFAULT;
+                                               break;
+                                       }
                                         nr--;
                                 }
                                 if (eol)
                                         break;
                         }
+                       if (retval)
+                               break;
                 } else {
                         int uncopied;
                         uncopied = copy_from_read_buf(tty, &b, &nr);
@@ -1136,7 +1147,7 @@

         current->state = TASK_RUNNING;
         size = b - buf;
-       if (size) {
+       if (!retval && size) {
                 retval = size;
                 if (nr)
                         clear_bit(TTY_PUSH, &tty->flags);

