Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVHJO2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVHJO2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbVHJO2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:28:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965130AbVHJO2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:28:23 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508102334.43662.phillips@arcor.de> 
References: <200508102334.43662.phillips@arcor.de>  <20050808145430.15394c3c.akpm@osdl.org> <200508090724.30962.phillips@arcor.de> <31567.1123679613@warthog.cambridge.redhat.com> 
To: Daniel Phillips <phillips@arcor.de>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, hugh@veritas.com
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Wed, 10 Aug 2005 15:27:52 +0100
Message-ID: <21701.1123684072@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:

> > An extra page flag beyond PG_uptodate, PG_lock and PG_writeback is
> > required to make readpage through the cache non-synchronous.

Sorry, I meant to say "filesystem cache": FS-Cache/CacheFS.

> Interesting, have you got a pointer to a full explanation?  Is this about aio?

No, it's nothing to do with AIO. This is to do with using local disk to cache
network filesystems and other relatively slow devices.

What happens is this:

 (1) readpage() is issued against NFS (for example).

 (2) NFS consults the local cache, and finds the page isn't available there.

 (3) NFS reads the page from the server.

 (4) NFS sets PG_fs_misc and tells the cache to store the page.

 (5) NFS sets PG_uptodate and unlocks the page.

Some time later, the cache finishes writing the page to disk:

 (6) The cache calls NFS to say that it's finished writing the page.

 (7) NFS calls end_page_fs_misc() - which clears PG_fs_misc - to indicate to
     any waiters that the page can now be written to.

Now: any PTEs set up to point to this page start life read-only. If they're
part of a shared-writable mapping, then the MMU will generate a WP fault when
someone attempts to write to the page through that mapping:

 (a) do_wp_page() gets called.

 (b) do_wp_page() sees that the page's host has registered an interest in
     knowing that the page is becoming writable:

	vm_operations_struct::page_mkwrite()

 (c) do_wp_page() calls out to the filesystem.

 (d) NFS sees the page is wanting to become writable and waits for the
     PG_fs_misc flag to become cleared.

 (e) NFS returns to the caller and things proceed as normal.

Doing this permits the cache state to be more predictable in the event of
power loss because we know that userspace won't have scribbled on this page
whilst the cache was trying to write it to disk.

David
