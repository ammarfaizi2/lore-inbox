Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUJUCp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUJUCp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbUJUClh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:41:37 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:44866 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270604AbUJUCie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:38:34 -0400
Subject: Re: belkin usb serial converter (mct_u232), break not working
From: Paul Fulghum <paulkf@microgate.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200410210004.13214.thomas@stewarts.org.uk>
References: <200410201946.35514.thomas@stewarts.org.uk>
	 <200410202308.02624.thomas@stewarts.org.uk>
	 <1098311228.6006.3.camel@at2.pipehead.org>
	 <200410210004.13214.thomas@stewarts.org.uk>
Content-Type: text/plain
Message-Id: <1098326278.6017.19.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 21:37:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 18:04, Thomas Stewart wrote:
> porttest.c:
> #include <sys/fcntl.h>
> #include <sys/ioctl.h>
> main(int argc, char ** argv) {
>         int r, fd = open(argv[1], O_RDWR|O_NOCTTY);
>         r=ioctl(fd, TCSBRKP, 20);
>         printf("%d\n", r);
>         close(fd);
> }
> 
> $ ./porttest /dev/ttyS0
> 0
> $ ./porttest /dev/ttyUSB0
> 0

OK, this is a kernel problem with send_break() in tty_io.c

Original:

static int send_break(struct tty_struct *tty, int duration)
{
	set_current_state(TASK_INTERRUPTIBLE);

	tty->driver->break_ctl(tty, -1);
	if (!signal_pending(current))
		schedule_timeout(duration);
	tty->driver->break_ctl(tty, 0);
	if (signal_pending(current))
		return -EINTR;
	return 0;
}

The USB serial driver break_ctl() sends a URB which does
a sleep and wakeup changing the task state back to TASK_RUNNING.
Because of this, schedule_timeout() above gets short circuited
and the break condition is not maintained long enough.

The normal serial driver break_ctl() leaves the task state
as TASK_INTERRUPTIBLE so you get the proper delay.

Thomas: try the patch below and let me know the results.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.8/drivers/char/tty_io.c	2004-08-14 00:37:15.000000000 -0500
+++ b/drivers/char/tty_io.c	2004-10-20 21:31:55.000000000 -0500
@@ -1703,11 +1703,11 @@ static int tiocsetd(struct tty_struct *t
 
 static int send_break(struct tty_struct *tty, int duration)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	tty->driver->break_ctl(tty, -1);
-	if (!signal_pending(current))
+	if (!signal_pending(current)) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(duration);
+	}
 	tty->driver->break_ctl(tty, 0);
 	if (signal_pending(current))
 		return -EINTR;


