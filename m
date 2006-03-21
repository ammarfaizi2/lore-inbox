Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWCUGgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWCUGgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 01:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCUGga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 01:36:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23819 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750719AbWCUGga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 01:36:30 -0500
Date: Tue, 21 Mar 2006 07:32:52 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com, viro@ftp.linux.org.uk
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-ID: <20060321063252.GA24614@w.ods.org>
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org> <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org> <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org> <20060320061212.GG21493@w.ods.org> <Pine.LNX.4.64.0603192223530.3622@g5.osdl.org> <20060320071846.GA19642@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320071846.GA19642@w.ods.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 08:18:46AM +0100, Willy Tarreau wrote:
> On Sun, Mar 19, 2006 at 10:26:30PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Mon, 20 Mar 2006, Willy Tarreau wrote:
> > > 
> > > Now, does removing the macro completely change the output code ?
> > > I think that if something written like this produces the same
> > > code, it would be easier to read :
> > > 
> > > #define for_each_cpu_mask(cpu, mask)			\
> > > 	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) {	\
> > > 		unsigned long __bits = (mask).bits[0] >> (cpu); \
> > > 		if (!__bits)				\
> > > 			break;				\
> > > 		if (!__bits & 1)			\
> > > 			continue;			\
> > > 		else
> > 
> > Absolutely, but now it has a dangling "{" that didn't get closed. So the 
> > above would definitely be more readable, it just doesn't actually work.
> > 
> > Unless you'd do the "end_for_each_cpu" define (to close the statement), 
> > and update the 300+ places that use this. Which might well be worth it.
> > 
> > So the subtle "break from the middle of a statement expression" was just a 
> > rather hacky way to avoid having to change all the users of this macro.
> >
> > 			Linus
> 
> Oh, you're right, now I understand your motivation in doing this.
> Then perhaps using your trick but applying it to the whole for loop
> would make it easier to read ?
> 
> #define for_each_cpu_mask(cpu, mask)			\
> 	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) 	\
> 	    ({	unsigned long __bits = (mask).bits[0] >> (cpu); \
> 		if (!__bits)				\
> 			break;				\
> 		if (!__bits & 1)			\
> 			continue;			\
> 		else					\
>                 ...					\
>             })

Well, forget it !
I did not realize that the 'else' was what called the inner loop.
So this construct it not possible at all either for the same reason.

Sorry for not having read the code before posting.

Cheers,
Willy

