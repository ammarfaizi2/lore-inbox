Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270455AbUJUKLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270455AbUJUKLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbUJUKJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:09:03 -0400
Received: from wang.choosehosting.com ([212.42.1.230]:35976 "EHLO
	wang.choosehosting.com") by vger.kernel.org with ESMTP
	id S270538AbUJUKHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:07:19 -0400
Date: Thu, 21 Oct 2004 11:06:37 +0100
To: Paul Fulghum <paulkf@microgate.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: belkin usb serial converter (mct_u232), break not working
Message-ID: <20041021100637.GA7003@diamond>
References: <200410201946.35514.thomas@stewarts.org.uk> <200410202308.02624.thomas@stewarts.org.uk> <1098311228.6006.3.camel@at2.pipehead.org> <200410210004.13214.thomas@stewarts.org.uk> <1098326278.6017.19.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098326278.6017.19.camel@at2.pipehead.org>
User-Agent: Mutt/1.5.6+20040722i
From: Thomas Stewart <thomas@stewarts.org.uk>
X-Scanner: Exiscan on wang.choosehosting.com at 2004-10-21 11:07:17
X-Spam-Score: 0.0
X-Spam-Bars: /
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 09:37:58PM -0500, Paul Fulghum wrote:
> static int send_break(struct tty_struct *tty, int duration)
> {
> 	set_current_state(TASK_INTERRUPTIBLE);
> 
> 	tty->driver->break_ctl(tty, -1);
> 	if (!signal_pending(current))
> 		schedule_timeout(duration);
> 	tty->driver->break_ctl(tty, 0);
> 	if (signal_pending(current))
> 		return -EINTR;
> 	return 0;
> }
> 
> The USB serial driver break_ctl() sends a URB which does
> a sleep and wakeup changing the task state back to TASK_RUNNING.
> Because of this, schedule_timeout() above gets short circuited
> and the break condition is not maintained long enough.
> 
> The normal serial driver break_ctl() leaves the task state
> as TASK_INTERRUPTIBLE so you get the proper delay.
> 
> Thomas: try the patch below and let me know the results.

I tryed again with your patch applyed, with both minicom and porttest

porttest.c:
#include <sys/fcntl.h>
#include <sys/ioctl.h>
main(int argc, char ** argv) {
        int r, fd = open(argv[1], O_RDWR|O_NOCTTY);
        r=ioctl(fd, TCSBRKP, 20);
        printf("%d\n", r);
        close(fd);
}

$ time ./porttest /dev/ttyS0
0

real    0m2.001s
user    0m0.000s
sys     0m0.001s
$ time ./porttest /dev/ttyUSB0
0

real    0m2.003s
user    0m0.000s
sys     0m0.001s

As you can see, this time there is the correct pause. However
it still does not send the break.

To add the mix, I dug about and found a differnt type of USB serial
converter, a no-brand one that uses the pl2303 module. Both minicom
and porttest with either stock 2.6.8.1 or 2.6.8.1 with your patch
send the break fine with this different converter.

This makes me think it is a problem with the mct_u232 driver?

Regards
-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID		[0x68A70C48]
