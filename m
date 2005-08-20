Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVHTDVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVHTDVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVHTDVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:21:41 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10972 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932356AbVHTDVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:21:40 -0400
Subject: [PATCH] race condition with drivers/char/vt.c (bug in vt_ioctl.c)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 19 Aug 2005 23:21:27 -0400
Message-Id: <1124508087.18408.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging Ingo's RT patch, I came accross this race condition.
The mainline seems to be susceptible to this bug, although it may be 1
in a 1,000,000 to happen. But those are the nastiest races.

With debugging information in the RT patch, I was able to reproduce this
race several times. Enough to be able to debug it. 

The race is with the tty->driver_data, tty->count and vt.c

Here's the scoop:

Process P1 opens a tty:
  tty_open 
    --> init_dev
          sets tty->count to 1

P1 does what it needs to, and closes the tty.
  tty_release  (now showing locks)
    (grabs BKL)
    --> release_dev
        --> tty->driver->close ==> con_close (vt.c)
            (down tty_sem)
            (aquire console_sem)
            tty->driver_data = NULL

Now process P2 opens the console:
   tty_open
      (block on tty_sem)

back to P1
         (release console_sem)
         (up tty_sem)

back to P2
       (down tty_sem)
       --> init_dev
           tty->count++ (tty->count now == 2)
           (up tty_sem)
           --> tty->driver->open ==> con_open (vt.c)
              (aquire console_sem)
               if (tty->count == 1) (which it does not)
                    allocate tty->driver_data
                          (which doesn't happen)
              (release console_sem)
  
     And P2 goes happily along with driver_data == NULL.

Now in something like vt_ioctl (which I first saw the bug)

int vt_ioctl(struct tty_struct *tty, struct file * file,
	     unsigned int cmd, unsigned long arg)
{
	struct vc_data *vc = (struct vc_data *)tty->driver_data;
	struct console_font_op op;	/* used in multiple places here */
	struct kbd_struct * kbd;
	unsigned int console;
	unsigned char ucval;
	void __user *up = (void __user *)arg;
	int i, perm;
	
	console = vc->vc_num;

Where here vc->vc_num could very well be (0)->vc_num.

I googled a little and found where this may have already happened in the
main line kernel:

http://seclists.org/lists/linux-kernel/2005/Aug/1603.html

So here's my proposal: 

  Instead of checking for tty->count == 1 in con_open, which we see is
not reliable.  Just check for tty->driver_data == NULL.

This should work since it should always be NULL when we need to assign
it.  If we switch the events of the race, so that the init_dev went
first, the driver_data would not be NULL and would not need to be
allocated, because after init_dev tty->count would be greater than 1
(this is assuming the case that it is already allocated) and the
con_close would not deallocate it.  The tty_sem and console_sem and
order of events protect the tty->driver_data but not the tty->count.

Without the patch, I was able to get the system to BUG on bootup every
other time.  With the patch applied, I was able to bootup 6 out of 6
times without a single crash. 

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc6-git10/drivers/char/vt.c.orig	2005-08-19 22:51:25.000000000 -0400
+++ linux-2.6.13-rc6-git10/drivers/char/vt.c	2005-08-19 22:52:22.000000000 -0400
@@ -2433,7 +2433,7 @@ static int con_open(struct tty_struct *t
 	int ret = 0;
 
 	acquire_console_sem();
-	if (tty->count == 1) {
+	if (tty->driver_data == NULL) {
 		ret = vc_allocate(currcons);
 		if (ret == 0) {
 			struct vc_data *vc = vc_cons[currcons].d;


