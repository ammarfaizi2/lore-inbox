Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWJJJnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWJJJnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWJJJnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:43:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965129AbWJJJnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:43:42 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1160170629.5453.34.camel@lade.trondhjem.org> 
References: <1160170629.5453.34.camel@lade.trondhjem.org> 
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Andrew Morton <akpm@osdl.org>, Steve Dickson <SteveD@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 10 Oct 2006 10:43:30 +0100
Message-ID: <2069.1160473410@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> -	if (PagePrivate(page) && !try_to_release_page(page, 0))
> +	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))

This can't be the right way to fix things.  try_to_release_page() may fail
whatever GFP flags you give it.  If the page *must* be invalidated at this
point then you _must_ call the invalidatepage() op, not the releasepage() op.

What is currently there allows an instikill to take place on a page at this
point, but defers the kill on pages that are busy until all the pages have
been scanned once, thus giving I/O time to happen on busy pages whilst reaping
pages that can be made immediately available.

David
