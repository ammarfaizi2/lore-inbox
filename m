Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUDCUxr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUDCUxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:53:47 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:59834 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261979AbUDCUxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:53:45 -0500
Subject: solved (was Re: xterm scrolling speed - scheduling weirdness
	in	2.6 ?!)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: jamie@shareable.org, tconnors+linuxkernel1080972247@astro.swin.edu.au
Content-Type: text/plain
Message-Id: <1081025611.1351.108.camel@localhost>
Mime-Version: 1.0
Date: Sat, 03 Apr 2004 22:53:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for breaking up the thread... This is copy+paste work.

[...]
> > I fixed this issue in multi-gnome-terminal by using a buffer of 32kb.
> > It is filled as long as there is input comming in within 10ms.
> > If the buffer is full or 10ms passed the buffer is written out to the
> > screen. This makes it also 2-3 times faster on kernel 2.4.
> 
> A factor of 2 or 3 though?
> 
> In 2.4, to ls -lA my home directory with its 510 files, took less than
> 0.5 sec. Currently, buffering via cat in 2.6 takes 0.5 sec. Just
> straight ls -lA takes 6 seconds or so.
>
> Does your factor of 3 bring you up to what you were seeing in 2.4, or
> do you still have a regression?

Huh? Maybe you read the mail again. IT IS NOW 2-3 TIMES FASTER ON 2.4 !

And yes on kernel 2.6, ls -lA /usr/bin (~3200files) pops up 0.6s on this
667Mhz G4 powerbook here (which might be a little faster than your
machine).

To make it clear once again. There was a busy loop in the terminal doing
while ( (saveerrno == EAGAIN) && (count = read (fd, buffer, 4096)) > 0) 
{
    saveerrno = errno;

	output stuff
}

If the terminal process gets to much cpu for too long this will make the
terminal spit out characters one by one. This in turn will obviously
turn of any jumpscrolling. When I add a usleep of 5ms in this loop jump
scrolling is working nicely again (but it is still slower than the
solution I proposed). This again underlines that _this_ is not a kernel
schedulers bug.

And yes, since probably all other terminals have their roots in xterm
every terminal is affected!

The fix (see other mail) was for multi-gnome-terminal, which in turn has
its roots in the old gnome-terminal.

This fix is now in debian unstable/mgt cvs.

Wwwoffle might have other issues. Is your CPU to the max while this is
happening ? Which process eats up CPU then ? In the mgt/xterm case this
was easily observable - mgt eat up all cpu. If that is the case you
observe another polling bug triggered by this scheduler making your
process to get too high priority and thus via polling cpu time. 

Soeren

PS: Please CC me I am not subscribed, sometimes reading the archives
though.

