Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUFJQ5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUFJQ5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUFJQ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:57:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262006AbUFJQ5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:57:06 -0400
Date: Thu, 10 Jun 2004 17:57:05 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610165705.GG12308@parcelfarce.linux.theplanet.co.uk>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org> <1086842898.32053.380.camel@dooby.cs.berkeley.edu> <Pine.LNX.4.58.0406100735530.2050@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406100735530.2050@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 07:46:40AM -0700, Linus Torvalds wrote:
 
> The only way to fix the second case is to split the structure up - which
> is usually a good idea _anyway_, but which can sometimes be pretty 
> painful. Al has done some of them. The really painful one is "struct 
> iovec", which seems to be used in this capacity a fair amount.

iovec is, I'm afraid, hopeless.  E.g. TCP code does tons of work before
it even looks at the data; doing two versions (for kernel and userland
pointers) is too ridiculous for words.  So kernel users (== RPC of all
sorts) either do it from kernel threads or use set_fs() around sock_sendmsg().
That would be a convenient chokepoint, if we would e.g. always pass a
single-element arrays - we could add kernel_sendmsg() that would take
a _kernel_ pointer + length + flags, force them into iovec, call set_fs()
and pass that stuff to sock_sendmsg() (and similar for recepients).
Unfortunately, it doesn't work that way - there are places that pass
multi-element arrays.  And there are guys who don't need set_fs() since
they are in kernel threads.

It might be possible to clean up, but I would stay away from that mess for
a while.  Non-networking code is simple - it's almost always either only
kernel or only userland.  XFS is a major offender in that respect, but
that's the matter of SGI politics and not much more, AFAICS.

Note that we get very real fuckups with that - e.g. econet-over-ethernet
slaps a kernel chunk of data in front of userland ones, does verify_area()
on the latter, calls set_fs() and sends the mixed vector to UDP code.
It breaks big way on a bunch of platforms, obviously...
