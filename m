Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWE3Q17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWE3Q17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWE3Q16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:27:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932319AbWE3Q15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:27:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com>  <Pine.LNX.4.64.0605260825160.31609@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com> <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy> <24747.1148653985@warthog.cambridge.redhat.com> <12042.1148976035@warthog.cambridge.redhat.com> 
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 30 May 2006 17:26:14 +0100
Message-ID: <7966.1149006374@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:

> Maybe I do not understand properly. I thought page_mkwrite is called 
> before a page is made writable not before it is dirtied. If its only 
> called before the page is dirtied then a better name maybe before_dirty or 
> so?

page_mkwrite() is called before any of the PTEs referring to a page are made
writable.  This must precede a page being dirtied by writing to it directly
through an mmap'd section.  It does not catch write() and co. dirtying pages,
but then there's no need since prepare_write() is available for that.

> What do you mean by "written to the cache"? It cannot be written back 
> since the page has been dirtied yet. So "written to the cache" means 
> that the FS does some reservation, right?

See the FS-Cache patches posted to LKML on the 19th of May, in particular the
documentation included in the patch with the subject:

	[PATCH 10/14] FS-Cache: Generic filesystem caching facility [try #10]

These patches permit data retrieved from network filesystems (NFS and AFS for
now) to be cached locally on disk.

The page is fetched from the server and then written to the cache.  We don't
let the clean page be modified or released until the write to the cache is
complete.  This permits us to keep track of what state the cache is in.

> If set_page_dirty cannot reserve the page then we know that some severe
> action is required. The FS method set_page_dirty() could:

But by the time set_page_dirty() is called, it's too late as the code
currently stands.  We've already marked the PTE writable and dirty.  The
page_mkwrite() op is called _first_.

> 1. Determine the ENOSPC condition before it sets the page dirty.
>    That leaves the potential that some writes to the page have occurred
>    by other processes.

You have to detect ENOSPC before you modify the PTE, otherwise someone else
can jump through your hoop and dirty the page before you can stop them.

> 2. Track down all processes that use the mapping (or maybe less

That's bad, even if you restrict it to those that have MAP_SHARED and
PROT_WRITE set.  They should not be terminated if they haven't attempted to
write to the mapping.

>    severe: processes that have set the dirty bit in the pte) and 
>    terminate them with SIGBUS.

Brrrr.

What's wrong with my suggestion anyway?

David
