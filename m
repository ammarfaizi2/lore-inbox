Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269400AbUJSNuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbUJSNuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 09:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269406AbUJSNuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 09:50:19 -0400
Received: from beta.netcraft.com ([195.92.95.67]:5306 "EHLO beta.netcraft.com")
	by vger.kernel.org with ESMTP id S269400AbUJSNuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 09:50:12 -0400
Date: Tue, 19 Oct 2004 14:50:06 +0100
From: Colin Phipps <cph@cph.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041019135006.GE29039@netcraft.com>
References: <20041019012103.GA1990@sa.pracom.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019012103.GA1990@sa.pracom.com.au>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 10:51:03AM +0930, John Pearson wrote:
> As far as I can see:
> 
>   - YES, Linux select 'lies' and violates POSIX wrt checksums:
>     a call to recvmsg() might well have blocked when select()
>     said data was ready, as a result of a currupt UDP packet;
> 
>   - NO, 'fixing' select() won't guarantee that recvmsg()
>     will not block/return EAGAIN, because select() only
>     guarantees that a call to recvmsg() would not have blocked
>     at that time - as others have observed, it cannot guarantee
>     that 'valid' data won't subsequently be discarded; any
>     subsequent call to recvmsg() is only 'immediate' in a fuzzy,
>     imprecise and inadequate sense.
> 
> Can we get back to arguing about something less repetitive
> (or at least, make the circle larger and more scenic)?

I would put a third point on the list; the behaviour makes the failure
case for a lot of broken apps much more likely, and easy to trigger
remotely.

In the interest of making things more "scenic", let's have a few more
broken apps:

glibc RPC - so portmap, statd, ...

It seems there's a common idiom in most of the broken programs.
Programmers assume that they can take a collection of library functions
that do blocking IO, and then multiplex them by sticking a select on the
front to choose when to call them. Given the wording of the POSIX
standard, it could be naively read to endorse this idiom - it says a
socket is readable if it won't block to read.  glibc RPC does this; the
underlying functions all assume blocking fds, and it then sticks a
select on the front. This occurs again in inetd, again in syslog, again
in net-snmp, and those are just the ones I see on my desktop machine.
You can easily patch the kernel to have it report them all (just
remember to disable syslog first, as it is one of the culprits).

Sure they are all broken, but now they are all exposed to bad UDP
checksums. Perhaps the people who benefit from the time saved by this
micro-optimisation would care to use the time saved to fix glibc?

