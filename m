Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVHJXSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVHJXSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVHJXSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:18:52 -0400
Received: from smtp.istop.com ([66.11.167.126]:53938 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932597AbVHJXSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:18:51 -0400
From: Daniel Phillips <phillips@arcor.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Thu, 11 Aug 2005 09:19:13 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, hugh@veritas.com
References: <200508102334.43662.phillips@arcor.de> <31567.1123679613@warthog.cambridge.redhat.com> <21701.1123684072@warthog.cambridge.redhat.com>
In-Reply-To: <21701.1123684072@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508110919.13897.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 00:27, David Howells wrote:
> What happens is this:
>
>  (1) readpage() is issued against NFS (for example).
>
>  (2) NFS consults the local cache, and finds the page isn't available
> there.
>
>  (3) NFS reads the page from the server.
>
>  (4) NFS sets PG_fs_misc and tells the cache to store the page.
>
>  (5) NFS sets PG_uptodate and unlocks the page.
>
> Some time later, the cache finishes writing the page to disk:
>
>  (6) The cache calls NFS to say that it's finished writing the page.
>
>  (7) NFS calls end_page_fs_misc() - which clears PG_fs_misc - to indicate
> to any waiters that the page can now be written to.
>
> Now: any PTEs set up to point to this page start life read-only. If they're
> part of a shared-writable mapping, then the MMU will generate a WP fault
> when someone attempts to write to the page through that mapping:
>
>  (a) do_wp_page() gets called.
>
>  (b) do_wp_page() sees that the page's host has registered an interest in
>      knowing that the page is becoming writable:
>
> 	vm_operations_struct::page_mkwrite()
>
>  (c) do_wp_page() calls out to the filesystem.
>
>  (d) NFS sees the page is wanting to become writable and waits for the
>      PG_fs_misc flag to become cleared.
>
>  (e) NFS returns to the caller and things proceed as normal.
>
> Doing this permits the cache state to be more predictable in the event of
> power loss because we know that userspace won't have scribbled on this page
> whilst the cache was trying to write it to disk.

Hi David,

To be honest I'm having some trouble following this through logically.  I'll 
read through a few more times and see if that fixes the problem.  This seems 
cluster-related, so I have an interest.

Who is using this interface?

Regards,

Daniel
