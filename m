Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266097AbUFPDMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUFPDMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbUFPDLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:11:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:51077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266086AbUFPDJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:09:24 -0400
Date: Tue, 15 Jun 2004 20:09:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, mingo@elte.hu, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au, akpm@osdl.org,
       wli@holomorphy.com, markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
In-Reply-To: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.58.0406152004540.4142@ppc970.osdl.org>
References: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jun 2004, Herbert Xu wrote:
>
> Martin J. Bligh <mbligh@aracnet.com> wrote:
> > 
> > How the hell can that have any effect on non-threaded workloads? Perhaps
> > some part of kernel compile *is* multi-threaded. It does seem to get 
> 
> make(1) with vfork(2) perhaps?

Very likely. And in the vfork() case it is definitely WRONG to try to
reschedule (either threads _or_ processes), since the parent is going to
go to sleep real soon now.

I think this code:

                        if (clone_flags & CLONE_VM)
                                wake_up_forked_thread(p);
                        else
                                wake_up_forked_process(p);

is just wrong, and it should be replaced with

			wake_up_new_process(p, clone_flags);

and then "wake_up_new_process()" can do the right thing, which is 
basically:

	if (clone_flags & CLONE_VFORK)
		synchronous wakeup, same as pipe-will-block case
	else if (clone_flags & CLONE_VM)
		thread-wakeup-case
	else
		process-wakeup-case

No?

		Linus
