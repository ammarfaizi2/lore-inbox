Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWE3RDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWE3RDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWE3RDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:03:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932343AbWE3RDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:03:13 -0400
Date: Tue, 30 May 2006 10:02:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages 
In-Reply-To: <7966.1149006374@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0605300953390.17716@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0605260825160.31609@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
 <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy>
 <24747.1148653985@warthog.cambridge.redhat.com> <12042.1148976035@warthog.cambridge.redhat.com>
  <7966.1149006374@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, David Howells wrote:

> > If set_page_dirty cannot reserve the page then we know that some severe
> > action is required. The FS method set_page_dirty() could:
> 
> But by the time set_page_dirty() is called, it's too late as the code
> currently stands.  We've already marked the PTE writable and dirty.  The
> page_mkwrite() op is called _first_.

We are in set_page_dirty and this would be part of set_page_dirty 
processing.

> > 2. Track down all processes that use the mapping (or maybe less
> 
> That's bad, even if you restrict it to those that have MAP_SHARED and
> PROT_WRITE set.  They should not be terminated if they haven't attempted to
> write to the mapping.

Its bad but the out of space situation is an exceptional situation. We do 
similar contortions when we run out of memory space. As I said: One can 
track down the processes that have dirtied the pte to the page in question 
and just terminate those and remove the page.

> What's wrong with my suggestion anyway?

Adds yet another method with functionality that for the most part 
is the same as set_page_dirty().

The advantage of such a method seems to be that it reserves filesystem 
space for pages that could potentially be written to. This allows the 
filesystem to accurately deal with out of space situations (a very rare 
condition. Is this really justifiable?). Maybe having already reserved 
space could speed up the real dirtying of pages?
