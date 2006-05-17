Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWEQPwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWEQPwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWEQPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:52:40 -0400
Received: from gold.veritas.com ([143.127.12.110]:56702 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750738AbWEQPwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:52:40 -0400
X-IronPort-AV: i="4.05,138,1146466800"; 
   d="scan'208"; a="59601783:sNHT30676772"
Date: Wed, 17 May 2006 16:52:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org
Subject: Re: swapper_space export
In-Reply-To: <1147864721.3051.17.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0605171626460.6711@blonde.wat.veritas.com>
References: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu>
 <1147864721.3051.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 May 2006 15:52:39.0737 (UTC) FILETIME=[ECF2F290:01C679C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Arjan van de Ven wrote:
> On Tue, 2006-05-16 at 19:24 -0400, Josef Sipek wrote:
> > I was trying to compile the Unionfs[1] to get it up to sync it up with
> > the kernel developments from the past few months. Anyway, long story
> > short...swapper_space (defined in mm/swap_state.c) is not exported
> > anymore (git commit: 4936967374c1ad0eb3b734f24875e2484c3786cc). This
> > apparently is not an issue for most modules. Troubles arise when the
> > modules include mm.h or any of its relatives.
> > 
> > One simply gets a linker error about swapper_space not being defined.
> > The problem is that it is used in mm.h.
> 
> don't you think it's really suspect that no other filesystem, in fact no
> other driver in the kernel needs this? Could it just be that unionfs is 
> using a wrong API ? Because if that's the case you're patch is just the
> wrong thing. Maybe the unionfs people should try to submit their code
> for review etc......

Much as I'd love to side with Jeff against you and Adrian ;)
I think you're right.

I see no reference to page_mapping() in the unionfs source (and at
present there's no other justifiable modular use of swapper_space);
but my guess would be that Jeff is being more conscientious than is
called for in getting it to sync up with the kernel -

The unionfs source does contain its own inline "sync_page" which
comments that it "is copied verbatim from mm/filemap.c".  I'm
guessing Jeff has noticed that it's no longer a verbatim copy,
has made it so, and is thereby involving page_mapping().

No need for that here (nor for the smp_mb nor for the io_schedule):
unionfs's sync_page is working on a locked pagecache page of the
lower-level filesystem, that's not going to be a PageSwapCache page
nor a PageAnon page (nor even a truncated page with NULL mapping:
page lock is held).  Just use page->mapping as before.

(But I notice that unionfs better not have a tmpfs in its union:
the unionfs use of grab_cache_page is not strictly compatible with
the way tmpfs pages are swapped out under memory pressure.)

Hugh
