Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262890AbTCSC4D>; Tue, 18 Mar 2003 21:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262916AbTCSC4D>; Tue, 18 Mar 2003 21:56:03 -0500
Received: from rrcs-nys-24-97-68-224.biz.rr.com ([24.97.68.224]:39282 "EHLO
	lando.vestal.timesys") by vger.kernel.org with ESMTP
	id <S262890AbTCSC4C>; Tue, 18 Mar 2003 21:56:02 -0500
Message-ID: <3E77DE8B.5070600@goodmis.org>
Date: Tue, 18 Mar 2003 22:05:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read(tty, (char *)-1, 1) exempt from EFAULT ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had a cut and paste error in my last patch. This should be correct:

--- linux-2.4.20/drivers/char/n_tty.c_orig      Tue Mar 18 20:19:33 2003
+++ linux-2.4.20/drivers/char/n_tty.c   Tue Mar 18 21:06:57 2003
@@ -1030,7 +1030,10 @@
                                  break;
                          cs = tty->link->ctrl_status;
                          tty->link->ctrl_status = 0;
-                       put_user(cs, b++);
+                       if (put_user(cs, b++)) {
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


