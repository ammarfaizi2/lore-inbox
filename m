Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTBEOl4>; Wed, 5 Feb 2003 09:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTBEOl4>; Wed, 5 Feb 2003 09:41:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3854 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261375AbTBEOlz>; Wed, 5 Feb 2003 09:41:55 -0500
Date: Wed, 5 Feb 2003 14:51:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, tytso@thunk.org,
       rddunlap@osdl.org
Subject: Re: [PATCH][RESEND 3] disassociate_ctty SMP fix
Message-ID: <20030205145126.A28758@flint.arm.linux.org.uk>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, tytso@thunk.org, rddunlap@osdl.org
References: <Pine.LNX.4.50L.0302042235180.32328-100000@imladris.surriel.com> <Pine.LNX.4.50L.0302042306230.32328-100000@imladris.surriel.com> <20030204175109.57bbfc51.akpm@digeo.com> <Pine.LNX.4.50L.0302042356580.32328-100000@imladris.surriel.com> <20030205095114.A25479@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205095114.A25479@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Feb 05, 2003 at 09:51:14AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, what seems to be going on is as follows:

1. you kill 'dd' as per the bug report
2. the kernel closes the file descriptors that 'dd' had open as part of
   the do_exit() cleanup.
3. this calls tty_release(), which takes the BKL, and the tty layer
   does its necessary cleanup, setting filp->private_data to NULL.
   *note* the file descriptor is still on the tty->tty_files list.
4. tty_release() releases the BKL, at which point preemption occurs,
   switching to the master sshd process.
5. sshd closes the master end of the pty device, which causes
   tty_vhangup to be called.
6. do_tty_hangup scans the file descriptors attached to tty->tty_files,
   and calls tty_fasync for each.
7. we come across the file descriptor that 'dd' had open (since it is
   still on the tty->tty_files list).
8. tty_fasync looks at filp->private_data, and tty_paranoia_check finds
   it to be NULL, and so complains.

So, where do we take the file descriptor off the tty list?  __fput() -
list_del(&file->f_list);

This problem could still be present on non-preempt configurations,
although to a lesser degree.  As the code currently stands in both
2.4 and 2.5, we generally do not see any reschedules between tty_release
and __fput which would allow the above scenario to occur.  Preempt
just provides the extra bait for the bug to show itself.

As to the fix, umm, yea.  I'll get to that in a little while.  The good
news is that we know what's happening now.

(note: the "scheduling while atomic" below is caused by the method I
used to discover this problem, and shows the point at which the pesky
reschedule happened in the tty code.  pid135 is the dd process on the
pty slave end, pid130 is the sshd on the pty master end.)

tty_release: (pid=135) filp = c131ecb4 filp->private_data = c12d3000
bad: scheduling while atomic!
[<c0227d10>] (dump_stack+0x0/0x14)
[<c023cde8>] (schedule+0x0/0x3b4)
[<c023d19c>] (preempt_schedule+0x0/0x50)
[<c02f17b8>] (tty_release+0x0/0x110)
[<c0276230>] (__fput+0x0/0x1a8)
[<c02761f8>] (fput+0x0/0x38)
[<c0274864>] (filp_close+0x0/0x110)
[<c0242b0c>] (put_files_struct+0x0/0x110)
[<c024357c>] (do_exit+0x0/0x528)
[<c024a724>] (sig_exit+0x0/0x74)
[<c02268f8>] (do_signal+0x0/0x470)
[<c0226d68>] (do_notify_resume+0x0/0x34)
tty_release: (pid=130) filp = c131e984 filp->private_data = c1264000
do_tty_hangup: (pid=130) filp = c131ecb4, filp->private_data = 00000000
Warning: null TTY for (88:01) in tty_fasync
tty_release: (pid=130) done
tty_release: (pid=135) done

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

