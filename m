Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWDNTXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWDNTXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWDNTXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 15:23:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45711 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751425AbWDNTXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 15:23:20 -0400
Date: Fri, 14 Apr 2006 12:22:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: Implement lookup_swap_cache for migration entries
In-Reply-To: <20060414121537.11134d26.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604141214060.22652@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
 <20060413222921.2834d897.akpm@osdl.org> <Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
 <20060414113104.72a5059b.akpm@osdl.org> <Pine.LNX.4.64.0604141143520.22475@schroedinger.engr.sgi.com>
 <20060414121537.11134d26.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, Andrew Morton wrote:

> > > What locking ensures that the state of `entry' remains unaltered across the
> > > is_migration_entry() and migration_entry_to_page() calls?
> > 
> > entry is a variable passed by value to the function.
> 
> Sigh.
> 
> What locking ensures that the state of the page referred to by `entry' is
> stable?

Oh, that.

Well, there is no locking when retrieving a pte atomically from the page 
table. In do_swap_cache we figure out the page from the pte, lock the page 
and then check that the pte has not changed. If it has changed then we 
redo the fault. If the pte is still the same then we know that the page 
was stable in the sense that it is still mapped the same way. So it was 
not freed.

This applies to all pages handled by do_swap_page().

The differences are:

1. A migration entry does not take the tree_lock in lookup_swap_cache().

2. The migration thread will restore the regular pte before 
   dropping the page lock.

So after we succeed with the page lock we know that the pte has been 
changed. The fault will be redone with the regular pte.

