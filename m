Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUEAXZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUEAXZN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUEAXZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:25:13 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:35458 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262605AbUEAXZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:25:06 -0400
Date: Sun, 2 May 2004 01:24:48 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: koke@amedias.org, linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040501232448.GA4707@vana.vc.cvut.cz>
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501214617.GA6446@taniwha.stupidest.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 02:46:17PM -0700, Chris Wedgwood wrote:
> On Fri, Apr 30, 2004 at 09:53:51PM +0200, Jorge Bernal wrote:
> 
> I'm not sure who is to blame here, it looks like some tty's get into a
> state that either init or the getty doesn't like and don't want to
> come unstuck easily (stty sane > /dev/tty<foo> sometimes helps).
> 
> I need to get an init working as pid != 1 with debugging so I can
> figure out what init thinks here.  I've just been so short of time.

I do not think that it is init... 

If I did analysis correct, problem is that:

(1) agetty (at least from util-linux 2.12 from current debian unstable)
opens /dev/console and calls VT_OPENQRY to find first unopened VT. I have
no idea why it does this, especially as it causes problems when more than
one agetty is started simultaneously. I cannot believe that there is
no better way how to detect whether tty is in use or not (as comment
in the agetty suggests). Even spawning fuser /dev/ttyX looks less racy
to me. This race between different agetty starting in parallel is reason
why some gettys are missing after bootup. As they all use 10 sec timeout it
takes some time until all my 24 gettys come up.

(2) tty hangup is scheduled for work_queue.

(3) when you have bad luck then scheduled hangup work runs AFTER newly
created agetty calls VT_OPENQRY, and you get an error that ttyX is already
in use...

When I just put /dev/ttyX instead of ttyX into /etc/inittab, problem
disappears (as then VT_OPENQRY code in agetty is not triggered) and
everything works as it should - except 'w', so I just disabled OPENQRY
code in agetty instead as final solution.

I think that we should concentrate on how is it possible that init can
spawn agetty and agetty can parse whole /var/run/utmp, open /dev/console
and issue VT_OPENQRY before work scheduled before init was even notified
is done. It looks to me like that someone schedules some job on the
workqueue although that job apparently deserves its own kernel thread
due to time it takes.
						Best regards,
							Petr Vandrovec
