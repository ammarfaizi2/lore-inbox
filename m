Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWCTHUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWCTHUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWCTHUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:20:41 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:32010 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932179AbWCTHUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:20:41 -0500
Date: Mon, 20 Mar 2006 08:18:46 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com, viro@ftp.linux.org.uk
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-ID: <20060320071846.GA19642@w.ods.org>
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org> <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org> <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org> <20060320061212.GG21493@w.ods.org> <Pine.LNX.4.64.0603192223530.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603192223530.3622@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 10:26:30PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 20 Mar 2006, Willy Tarreau wrote:
> > 
> > Now, does removing the macro completely change the output code ?
> > I think that if something written like this produces the same
> > code, it would be easier to read :
> > 
> > #define for_each_cpu_mask(cpu, mask)			\
> > 	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) {	\
> > 		unsigned long __bits = (mask).bits[0] >> (cpu); \
> > 		if (!__bits)				\
> > 			break;				\
> > 		if (!__bits & 1)			\
> > 			continue;			\
> > 		else
> 
> Absolutely, but now it has a dangling "{" that didn't get closed. So the 
> above would definitely be more readable, it just doesn't actually work.
> 
> Unless you'd do the "end_for_each_cpu" define (to close the statement), 
> and update the 300+ places that use this. Which might well be worth it.
> 
> So the subtle "break from the middle of a statement expression" was just a 
> rather hacky way to avoid having to change all the users of this macro.
>
> 			Linus

Oh, you're right, now I understand your motivation in doing this.
Then perhaps using your trick but applying it to the whole for loop
would make it easier to read ?

#define for_each_cpu_mask(cpu, mask)			\
	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) 	\
	    ({	unsigned long __bits = (mask).bits[0] >> (cpu); \
		if (!__bits)				\
			break;				\
		if (!__bits & 1)			\
			continue;			\
		else					\
                ...					\
            })

Please note that I've not read the rest of the code, so there
may be some problems left. However, if the above works, I find
it easier to read. And in this case, yes, it's interesting to
be able to break from within an expression.

Cheers,
Willy

