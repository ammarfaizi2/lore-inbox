Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUEAXo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUEAXo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUEAXo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:44:56 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:2225 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262648AbUEAXoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:44:54 -0400
Date: Sat, 1 May 2004 16:44:44 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: koke@amedias.org, linux-kernel@vger.kernel.org,
       Andries Brouwer <aeb@cwi.nl>
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040501234444.GA24120@taniwha.stupidest.org>
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501232448.GA4707@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 01:24:48AM +0200, Petr Vandrovec wrote:

> I do not think that it is init...

No, it's not.

> (1) agetty (at least from util-linux 2.12 from current debian
> unstable) opens /dev/console and calls VT_OPENQRY to find first
> unopened VT.

yes, this i discovered too

> I have no idea why it does this, especially as it causes problems
> when more than one agetty is started simultaneously. I cannot
> believe that there is no better way how to detect whether tty is in
> use or not (as comment in the agetty suggests).

read below

> (2) tty hangup is scheduled for work_queue.

> (3) when you have bad luck then scheduled hangup work runs AFTER
> newly created agetty calls VT_OPENQRY, and you get an error that
> ttyX is already in use...

Unless I misunderstand you, I'm not conviced... it get tty's 'stuck',
they never come right even after hours or days.

> I think that we should concentrate on how is it possible that init
> can spawn agetty and agetty can parse whole /var/run/utmp, open
> /dev/console and issue VT_OPENQRY before work scheduled before init
> was even notified is done. It looks to me like that someone
> schedules some job on the workqueue although that job apparently
> deserves its own kernel thread due to time it takes.

Yes, as far as the kernel is concerned this needs checking.

By comments (from before I got this email) and a pointer to the fix I
use...


I see unused tty's (such as tty4) and ioctl(..., VT_OPENQRY, ...)
returning numbers like 8 --- which agetty barfs on.

The solution I hacked up was to have agetty use vhangup on the tty and
not even use the ioctl which seems fragile at the best of time.  The
present patch is at:

	http://stupidest.org/patches/util-linux-2.12-agetty-vhangup.001.patch

(ugly URL, sorry about that).

I've cc'd Andries Brouwer his his comments as he is the util-linux
maintainer.



Thanks,

  --cw
