Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUIOPlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUIOPlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUIOPlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:41:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:31451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266486AbUIOPlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:41:01 -0400
Date: Wed, 15 Sep 2004 08:40:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
In-Reply-To: <20040915151815.GA30138@elte.hu>
Message-ID: <Pine.LNX.4.58.0409150826150.2333@ppc970.osdl.org>
References: <20040915151815.GA30138@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Ingo Molnar wrote:
> 
> the attached patch is a new approach to get rid of Linux's Big Kernel
> Lock as we know it today.

I really think this is wrong.

Maybe not from a conceptual standpoint, but that implementation with the
scheduler doing "reaquire_kernel_lock()" and doing a down() there is just
wrong, wrong, wrong.

If we're going to do a down() and block immediately after being scheduled,
I don't think we should have been picked in the first place.

Yeah, yeah, you have all that magic to not recurse by setting lock-depth 
negative before doing the down(), but it still feels fundamentally wrong 
to me. There's also the question whether this actually _helps_ anything, 
since it may well just replace the spinning with lots of new scheduler 
activity. 

And you make schedule() a lot more expensive for kernel lock holders by 
copying the CPU map. You may have tested it on a machine where the CPU map 
is just a single word, but what about the big machines?

Spinlocks really _are_ cheaper. Wouldn't it be nice to just continue 
removing kernel lock users and keeping a very _simple_ kernel lock for 
legacy issues? 

In other words, I'd _really_ like to see some serious numbers for this.

		Linus
