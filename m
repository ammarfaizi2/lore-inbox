Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbUKVX5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUKVX5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUKVXvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:51:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:24272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262465AbUKVXub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:50:31 -0500
Date: Mon, 22 Nov 2004 15:54:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, wli@holomorphy.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
Message-Id: <20041122155434.758c6fff.akpm@osdl.org>
In-Reply-To: <11948.1101130077@redhat.com>
References: <11948.1101130077@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch overhauls compound page handling.
> 
>  (1) A new bit flag PG_compound_slave has been added. This is used to mark the
>      second+ subpages of a compound page, thus making get_page() and
>      put_page() able to determine the need to perform weird stuff quickly.
> 
>      This could be changed to do horribly things with the page count or to
>      abuse the page->lru member instead of eating another page flag.
> 
>  (2) Compound page metadata is now always set on high-order pages when
>      allocating and always checked when freeing:
> 
> 	- PG_compound is set on all subpages
> 	- PG_compound_slave is set on all but the first subpage
> 	- page[1].index holds the compound page order
> 	- page[1...N-1].private points to page[0]
> 	- page[1].mapping may hold a destructor function for put_page()

ugh, sorry, I'd forgotten that !MMU needs to use the fields inside
pages[1].  It seems that the !MMU requirement is in that case quite
dissimilar from what compound pages are supposed to do.  Perhaps we should
just forget the whole thing and stick with the current design approach?
