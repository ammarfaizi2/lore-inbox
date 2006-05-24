Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWEXPYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWEXPYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWEXPYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:24:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16350 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932630AbWEXPYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:24:19 -0400
Date: Wed, 24 May 2006 08:23:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] swapless page migration: fix swapops.h:97 BUG
In-Reply-To: <Pine.LNX.4.64.0605241329010.9391@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0605240816080.15446@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605241329010.9391@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006, Hugh Dickins wrote:

> Such an orphan may be left behind if an earlier migration raced with fork:
> copy_one_pte can duplicate a migration entry from parent to child, after
> remove_anon_migration_ptes has checked the child vma, but before it has
> removed it from the parent vma.  (If the process were later to fault on
> this orphaned entry, it would hit the same BUG from migration_entry_wait.)

Right the pte lock does not help us there. sigh.

> This could be fixed by locking anon_vma in copy_one_pte, but we'd rather
> not.  There's no such problem with file pages, because vma_prio_tree_add
> adds child vma after parent vma, and the page table locking at each end
> is enough to serialize.  Follow that example with anon_vma: add new vmas
> to the tail instead of the head.

Thats is very subtle. I hope there are no other areas where the child vma 
has to be processed before the parent vma? An alternativbe would be to 
make remove_anon_migration_ptes walk the list in reverse and add a big 
comment.

Thank you.

