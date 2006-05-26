Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWEZC3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWEZC3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 22:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWEZC3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 22:29:07 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:18686 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932182AbWEZC3G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 22:29:06 -0400
From: "Jeff Anderson-Lee" <jonah@eecs.berkeley.edu>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "'Peter Zijlstra'" <a.p.zijlstra@chello.nl>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Hugh Dickins'" <hugh@veritas.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'David Howells'" <dhowells@redhat.com>,
       "'Christoph Lameter'" <christoph@lameter.com>,
       "'Martin Bligh'" <mbligh@google.com>, "'Nick Piggin'" <npiggin@suse.de>,
       "'Linus Torvalds'" <torvalds@osdl.org>
References: <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy> <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages
Date: Thu, 25 May 2006 19:28:36 -0700
Message-ID: <000001c6806c$19403760$ce2a2080@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
Thread-Index: AcaAbAAT9leDrSnoRhG9HOCKDyVcyw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

> I am a bit confused about the need for Davids patch. set_page_dirty() is 
> already a notification that a page is to be dirtied. Why do we need it 
> twice? set_page_dirty could return an error code and the file system can 
> use the set_page_dirty() hook to get its notification. What we would need 
> to do is to make sure that set_page_dirty can sleep.

set_page_dirty() is actually called fairly late in the game by
zap_pte_range() and follow_page().  Thus, it is a notification that a page
HAS BEEN dirtied and needs a writeback.

What is needed (at least for log structured or copy-on-write filesystems) is
a function that is called during the page fault BEFORE the pte's writeable
bit is set so that the pages' mapping can either be unmapped or remapped. 
That prevents possible readers of the old (read-only) version of the page
from seeing any changes via the page map cache.  If the page was unmapped, a
second call is needed later to map it to a new set of blocks on the device. 
For a log structured filesystem it can makes sense to defer the remapping
until late in the game when the block is about to be queued for i/o, in case
it gets deleted before it is ever flushed from the page cache.

I looked at using set_page_dirty for the first of these hooks, but it comes
too late.  It might be OK for the second (remapping) hook though.

do_wp_page() is called by handle_pte_fault() in exactly the case where this
would apply: if write access is needed and !pte_write(entry).  This patch
appears to address the necessary issue in a way that set_page_dirty cannot.

Jeff Anderson-Lee

[I'm a little late in coming in on this thread, and not 100% familiar with
the latest kernels, so please pardon me if I'm not fully up to speed yet. 
I'm trying to catch up as quickly as I can though!]

