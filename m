Return-Path: <linux-kernel-owner+w=401wt.eu-S1752476AbWLXSHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbWLXSHs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbWLXSHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 13:07:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49070 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbWLXSHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 13:07:47 -0500
Date: Sun, 24 Dec 2006 10:07:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061224100728.731d2c14.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	<97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	<Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	<20061222100004.GC10273@deprecation.cyrius.com>
	<20061222021714.6a83fcac.akpm@osdl.org>
	<1166790275.6983.4.camel@localhost>
	<20061222123249.GG13727@deprecation.cyrius.com>
	<20061222125920.GA16763@deprecation.cyrius.com>
	<1166793952.32117.29.camel@twins>
	<20061222192027.GJ4229@deprecation.cyrius.com>
	<97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	<Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	<20061224005752.937493c8.akpm@osdl.org>
	<1166962478.7442.0.camel@localhost>
	<20061224043102.d152e5b4.akpm@osdl.org>
	<1166978752.7022.1.camel@localhost>
	<Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2006 09:16:06 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Sun, 24 Dec 2006, Andrei Popa wrote:
> 
> > On Sun, 2006-12-24 at 04:31 -0800, Andrew Morton wrote:
> > > Andrei Popa <andrei.popa@i-neo.ro> wrote:
> > > > /dev/sda7 on / type ext3 (rw,noatime,nobh)
> > > > 
> > > > I don't have corruption. I tested twice.
> > > 
> > > This is a surprising result.  Can you pleas retest ext3 data=writeback,nobh?
> > 
> > Yes, no corruption. Also tested only with data=writeback and had no
> > corruption.
> 
> Ok, so it would seem to be writeback related _somehow_. However, most of 
> the differences (I _thought_) in ext3 actually show up only if you have 
> *both* "nobh" and "data=writeback", and as far as I can tell, just a 
> simple "data=writeback" should still use the bog-standard 
> "block_write_full_page()".
> 
> Andrew?
> 
> Although as far as I can see, then ext2 should work as-is too (since it 
> too also just uses "block_write_full_page()" without anything fancy).

ext2 uses the multipage-bio assembly code for writeback whereas ext3
doesn't.  But ext3 doesn't use that code in data=ordered mode, of course.

Still, this:

--- a/fs/ext2/inode.c~a
+++ a/fs/ext2/inode.c
@@ -693,7 +693,7 @@ const struct address_space_operations ex
 	.commit_write		= generic_commit_write,
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
-	.writepages		= ext2_writepages,
+//	.writepages		= ext2_writepages,
 	.migratepage		= buffer_migrate_page,
 };
 
@@ -711,7 +711,7 @@ const struct address_space_operations ex
 	.commit_write		= nobh_commit_write,
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
-	.writepages		= ext2_writepages,
+//	.writepages		= ext2_writepages,
 	.migratepage		= buffer_migrate_page,
 };
 
_

will switch it off for ext2.


> Strange.
> 
> How about this particularly stupid diff? (please test with something that 
> _would_ cause corruption normally).
> 
> It is _entirely_ untested, but what it tries to do is to simply serialize 
> any writeback in progress with any process that tries to re-map a shared 
> page into its address space and dirty it. I haven't tested it, and maybe 
> it misses some case, but it looks likea good way to try to avoid races 
> with marking pages dirty and the writeback phase ..
> 
> 			Linus
> ---
> diff --git a/mm/memory.c b/mm/memory.c
> index 563792f..64ed10b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1544,6 +1544,7 @@ static int do_wp_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			if (!pte_same(*page_table, orig_pte))
>  				goto unlock;
>  		}
> +		wait_on_page_writeback(old_page);
>  		dirty_page = old_page;
>  		get_page(dirty_page);
>  		reuse = 1;
> @@ -2215,6 +2216,7 @@ retry:
>  				page_cache_release(new_page);
>  				return VM_FAULT_SIGBUS;
>  			}
> +			wait_on_page_writeback(new_page);
>  		}
>  	}

yup.  Also, we could perhaps lock the target page during pagefaults..

