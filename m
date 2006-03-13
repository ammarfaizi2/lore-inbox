Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWCMGkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWCMGkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 01:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWCMGkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 01:40:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:24534 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751534AbWCMGkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 01:40:51 -0500
Date: Mon, 13 Mar 2006 07:40:48 +0100
From: Nick Piggin <npiggin@suse.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
Message-ID: <20060313064047.GA2090@wotan.suse.de>
References: <20060207021822.10002.30448.sendpatchset@linux.site> <20060207021831.10002.84268.sendpatchset@linux.site> <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com> <44128EDA.6010105@yahoo.com.au> <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 08:34:53AM +0530, Balbir Singh wrote:
> On 3/11/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > Balbir Singh wrote:
> > > <snip>
> > >
> > >>                if (slot->slots[i]) {
> > >>-                       results[nr_found++] = slot->slots[i];
> > >>+                       results[nr_found++] = &slot->slots[i];
> > >>                        if (nr_found == max_items)
> > >>                                goto out;
> > >>                }
> > >
> > >
> > > A quick clarification - Shouldn't accesses to slot->slots[i] above be
> > > protected using rcu_derefence()?
> > >
> >
> > I think we're safe here -- this is the _address_ of the pointer.
> > However, when dereferencing this address in _gang_lookup,
> > I think we do need rcu_dereference indeed.
> >
> 
> Yes, I saw the address operator, but we still derefence "slots" to get
> the address.
> 

OK, I reread what you wrote and I misunderstood you earlier I guess.
slot->slots[i] does dereference the pointer at the ith entry of slots,
but &slot->slots[i] does not, it will return the same thing as
slot->slots+i, which only dereferences 'slot' (which we've established
to be safe).

Even if &slot->slots[i] did, for some silly compiler, dereference the
pointer, we never actually see it or use it so it should be harmless.

Nick

