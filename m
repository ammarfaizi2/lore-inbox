Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbTLCTl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbTLCTl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:41:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:2506 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265108AbTLCTlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:41:24 -0500
Date: Wed, 03 Dec 2003 11:41:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: memory hotremove prototype, take 3
Message-ID: <187360000.1070480461@flay>
In-Reply-To: <20031201034155.11B387007A@sv1.valinux.co.jp>
References: <20031201034155.11B387007A@sv1.valinux.co.jp>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this is a new version of my memory hotplug prototype patch, against
> linux-2.6.0-test11.
> 
> Freeing 100% of a specified memory zone is non-trivial and necessary
> for memory hot removal.  This patch splits memory into 1GB zones, and
> implements complete zone memory freeing using kswapd or "remapping".
> 
> A bit more detailed explanation and some test scripts are at:
> 	http://people.valinux.co.jp/~iwamoto/mh.html
> 
> Main changes against previous versions are:
> - The stability is greatly improved.  Kernel crashes (probably related
>   with kswapd) still happen, but they are rather rare so that I'm
>   having difficulty reproducing crashes.
>   Page remapping under simultaneous tar + rm -rf works.
> - Implemented a solution to a deadlock caused by ext2_rename, which
>   increments a refcount of a directory page twice.
> 
> Questions and comments are welcome.

I really think that doing this over zones and pgdats isn't the best approach.
You're going to make memory allocation and reclaim vastly less efficient,
and you're exposing a bunch of very specialised code inside the main
memory paths. 

Have you looked at Daniel's CONFIG_NONLINEAR stuff? That provides a much
cleaner abstraction for getting rid of discontiguous memory in the non
truly-NUMA case, and should work really well for doing mem hot add / remove
as well.

M.

PS. What's this bit of the patch for?

 void *vmalloc(unsigned long size)
 {
+#ifdef CONFIG_MEMHOTPLUGTEST
+       return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
+#else
        return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+#endif
 }
