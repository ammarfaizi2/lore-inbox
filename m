Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVIMSi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVIMSi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVIMSi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:38:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964976AbVIMSi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:38:26 -0400
Date: Tue, 13 Sep 2005 11:37:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: dev@sw.ru, torvalds@osdl.org, linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: Re: [PATCH] error path in setup_arg_pages() misses
 vm_unacct_memory()
Message-Id: <20050913113703.53d53d6a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0509131220540.7040@goblin.wat.veritas.com>
References: <4325B188.10404@sw.ru>
	<20050912132352.6d3a0e3a.akpm@osdl.org>
	<43268C21.9090704@sw.ru>
	<20050913014008.0ee54c62.akpm@osdl.org>
	<Pine.LNX.4.61.0509131220540.7040@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Tue, 13 Sep 2005, Andrew Morton wrote:
> > Kirill Korotaev <dev@sw.ru> wrote:
> > >
> > > maybe it is worth moving vm_acct_memory() out of 
> > >  security_vm_enough_memory()?
> > 
> > I think that would be saner, yes.  That means that the callers would call
> > vm_acct_memory() after security_enough_memory(), if that succeeded.
> 
> I don't like that at all.  The implementation of its tests is necessarily
> imprecise, but nonetheless, we do prefer primitives which atomically test
> and reserve.  We're not moving from request_region to check_region, are we?

I don't think that it's any racier to move the allocation to after the
check than to have it before the check.  If we're worried, take mmap_sem -
most place already do that, but not all.

> But change the naming by all means, it was never good,
> and grew worse when "security_" got stuck on the front.

Yes, renaming it to something like alloc_vm_space() would suit.
