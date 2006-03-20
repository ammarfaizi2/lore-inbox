Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWCTGMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWCTGMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWCTGMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:12:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27914 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932066AbWCTGMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:12:40 -0500
Date: Mon, 20 Mar 2006 07:12:13 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com, viro@ftp.linux.org.uk
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-ID: <20060320061212.GG21493@w.ods.org>
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org> <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org> <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 11:33:17AM -0800, Linus Torvalds wrote:
 
> Of course, I shouldn't say "works", since it is still totally untested. It 
> _looks_ good, and that statement expression usage is just _so_ ugly it's 
> cute.
>
> 		Linus

At least, you could have moved the macro closer to where it's used.
It's very uncommon to break a statement within an if condition, and
it's not expected that the macro you're calling does a break under
you. It took me several minutes to understand precisely how this
works. Now it seems trivial, but I guess that at 3am I would have
gone to bed instead.

One first enhancement would be to make it easier to understand
by putting it closer to its user :

#elif NR_CPUS > 1
#define check_for_each_cpu(cpu, mask) \
	({ unsigned long __bits = (mask).bits[0] >> (cpu); if (!__bits) break; __bits & 1; })

#define for_each_cpu_mask(cpu, mask)		\
	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) \
		if (!check_for_each_cpu(cpu, mask))	\
			continue;		\
		else

Now, does removing the macro completely change the output code ?
I think that if something written like this produces the same
code, it would be easier to read :

#define for_each_cpu_mask(cpu, mask)			\
	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) {	\
		unsigned long __bits = (mask).bits[0] >> (cpu); \
		if (!__bits)				\
			break;				\
		if (!__bits & 1)			\
			continue;			\
		else

Regards,
Willy

