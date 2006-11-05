Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161439AbWKERv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161439AbWKERv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWKERv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:51:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161439AbWKERv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:51:56 -0500
Date: Sun, 5 Nov 2006 09:51:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
In-Reply-To: <1162748079.3160.102.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0611050944380.25218@g5.osdl.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com>  <200611050641.14724.ak@suse.de>
 <454D9A75.7010204@vmware.com>  <200611051801.18277.ak@suse.de> 
 <Pine.LNX.4.64.0611050920220.25218@g5.osdl.org> <1162748079.3160.102.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Arjan van de Ven wrote:
> 
> actually lockdep is pretty good at finding this type of bug IMMEDIATELY
> even without the actual race triggering ;)

Ehh. Last time this happened, lockdep didn't find _squat_. 

This was when NT and AC leaked across context switches, because the 
context switching had removed the "expensive" save/restore.

The thing is, complexity is in the unintended side effects, not in the 
code itself. For example, let's say that we changed "restore_flags()" to 
do

	static inline void restore_flags(unsigned long x)
	{
		if (x & 0x200)
			asm volatile("sti");
	}

(I didn't check that IF is 0x200, but it's something like that) and it was 
two cycles faster on average than just doing a "popf". The _complexity_ 
here is that now there might be some other x86-architecture-specific code 
sequence that nobody even _realized_ actually depended on saving the other 
flags too. Like the context switching thing did.

Is it likely? Maybe not. But that's the thing about complexity - you'd not 
know, would you?

Do a few of these kinds of things, and _individually_ they are unlikely to 
add new bugs, but once you've done ten or twenty of them, the likelihood 
that _one_ of them added a subtle bug that it will take months or years to 
find is suddenly not all that small any more.

This is why "robust" is so important. So _much_ more important than a 
cycle or two. The fact is, saving and restoring all the eflags over a 
context switch is just _more_robust_. If you do a pushfl/popfl, there's 
simply not a lot you can screw up.

			Linus
