Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162021AbWKVJXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162021AbWKVJXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 04:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162022AbWKVJXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 04:23:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:42731 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1162021AbWKVJXx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 04:23:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/2] fix call to alloc_bootmem after bootmem has been freed
Date: Wed, 22 Nov 2006 10:23:40 +0100
User-Agent: KMail/1.9.5
Cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <20061115193049.3457b44c@localhost> <20061121190213.1700761b@localhost> <20061121102616.47d03ccc.akpm@osdl.org>
In-Reply-To: <20061121102616.47d03ccc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611221023.41807.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 19:26, Andrew Morton wrote:
> slab is a very different thing from vmalloc.  One could easily envisage
> situations (now or in the future) in which slab is ready, but vmalloc is
> not (more likely vice versa).
> 
> It'd be better to add a new vmalloc_is_available.  (Just an int - no need
> for a helper function).

In the time line, we currently have

start_kernel()
   ...
   setup_arch()
      init_bootmem()              # alloc_bootmem starts working
      ...
      paging_init()               # needed for vmalloc
   ...                            #
   mem_init()
      free_all_bootmem()          # alloc_bootmem stops working, alloc_pages
				  # starts working
   kmem_cache_init()              # kmalloc and vmalloc start working
   ...
   system_state = SYSTEM_RUNNING

The one interesting point here is where you have to transition between
calling alloc_bootmem and calling the regular allocator functions.
Maybe calling it slab_is_available() was not the best choice for a name,
but I don't see a point in having different names for essentially the
same question, "bootmem or not bootmem". The powerpc platform has an
integer variable called 'mem_init_done', which expresses this well
IMHO, but it's currently not portable.

Checking for SYSTEM_RUNNING is obviously the wrong choice, since it is
set at a very late point in bootup, long after bootmem is gone.

	Arnd <><
