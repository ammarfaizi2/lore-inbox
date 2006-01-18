Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWARRKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWARRKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWARRKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:10:48 -0500
Received: from ns1.suse.de ([195.135.220.2]:58057 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751379AbWARRKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:10:47 -0500
Date: Wed, 18 Jan 2006 18:10:46 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] atomic_add_unless sadness
Message-ID: <20060118171046.GF28418@wotan.suse.de>
References: <20060118063636.GA14608@wotan.suse.de> <Pine.LNX.4.64.0601180842440.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601180842440.3240@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 08:48:01AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 18 Jan 2006, Nick Piggin wrote:
> >
> > For some reason gcc 4 on at least i386 and ppc64 (that I have tested with)
> > emit two cmpxchges for atomic_add_unless unless we put branch hints in.
> > (it is unlikely for the "unless" case to trigger, and it is unlikely for
> > cmpxchg to fail).
> 
> Irrelevant. If "atomic_add_unless()" is in a hot path and inlined, we're 
> doing something else wrong anyway. It's not a good op to use. Just think 
> of it as being very expensive.
> 

I don't think it is quite irrelevant. Regardless of where it is used, it
doesn't hurt to make something smaller and more efficient.

> The _only_ user of "atomic_add_unless()" is "dec_and_lock()", which isn't 
> even inlined. The fact that gcc ends up "unrolling" the loop once is just 
> fine.
> 

dec_and_lock is not exactly a slow path. Maybe unrolling doesn't slow it
down in the traditional sense, but you're the one (rightly, I gather)
always talking about icache. In fact it unrolls an exceedingly rare second
iteration into the main code path.

> Please keep it that way. 
> 

fs/file_table.c uses it as well (inc_not_zero).

Nick

