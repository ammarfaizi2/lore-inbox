Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVKKT6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVKKT6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVKKT6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:58:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbVKKT6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:58:41 -0500
Date: Fri, 11 Nov 2005 11:58:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <4374F2D5.7010106@vmware.com>
Message-ID: <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Nov 2005, Zachary Amsden wrote:
> 
> Agree nested exceptions are evil.  But where is this called from execption
> context? 

We have really nice ways of handling these things, so we should just use 
them.

For example, you can do

	static inline void read_cr4(void)
	{
		unsigned long cr4;
		alternative_input("xorl %0,%0",
				  "movl %%cr4,%0",
				  X86_FEATURE_CR4,
				  "r" (cr4));
		return cr4;
	}

and then just add that feature-flag discovery early on in boot (it needs 
to be pretty early, since the alternative instruction rewriting happens 
early).

We have several "calculated" features already. Things like X86_FEATURE_P4 
etc.

		Linus
