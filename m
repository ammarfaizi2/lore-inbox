Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTBYAuP>; Mon, 24 Feb 2003 19:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264820AbTBYAuP>; Mon, 24 Feb 2003 19:50:15 -0500
Received: from holomorphy.com ([66.224.33.161]:49331 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264790AbTBYAuN>;
	Mon, 24 Feb 2003 19:50:13 -0500
Date: Mon, 24 Feb 2003 16:59:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <20030225005922.GU10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Gerrit Huizenga <gh@us.ibm.com>
References: <3E5ABBC1.8050203@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5ABBC1.8050203@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 04:41:37PM -0800, Dave Hansen wrote:
> c01cc948 334779   8.82177     __copy_to_user_ll
> c015797c 314165   8.27857     d_lookup
> c012c964 157716   4.15598     find_get_page
> c013cae0 156345   4.11985     page_add_rmap
> c0176557 148116   3.90301     .text.lock.inode
> c013cc38 132228   3.48434     page_remove_rmap
> c0176338 90851    2.39402     ext3_dirty_inode
> c0117320 80918    2.13227     scheduler_tick
> c01ccae0 79475    2.09425     atomic_dec_and_lock
> c0138cd4 75367    1.986       do_no_page
> c0139b60 75317    1.98468     vm_enough_memory
> c017d78c 72929    1.92175     start_this_handle

Your profile was upside down. I've re-sorted it.
It probably confused people who were wondering why the numbers
at the top of the profile were lower than the ones below them.


On Mon, Feb 24, 2003 at 04:41:37PM -0800, Dave Hansen wrote:
> a snippet from d_lookup(), annotated.  I've seen oprofile be off by a
> line here, but we can be pretty sure it is in this area.
> 		smp_read_barrier_depends();
> 		/* 106 0.002793% */
> 		dentry = list_entry(tmp, struct dentry, d_hash);
> 		/* if lookup ends up in a different bucket
> 		 * due to concurrent rename, fail it
> 		 */
> 		/* 154991 4.084% */
> 		if (unlikely(dentry->d_bucket != head))
> 			break;
> 		/* to avoid race if dentry keep coming back to original
> 		 * bucket due to double moves
> 		 */
> 		/* 634 0.01671% */
> 		if (unlikely(++lookup_count > max_dentries))
> 			break;
> 		...

Well, you're walking hash chains, you're going to get a lot of cache
misses, about the whole length of the chain's worth. You could try
changing the dcache to use something like a B+ tree or some such
nonsense to reduce its cache footprint.

I'd collect statistics to see if the dcache hash function is badly
distributing things. That's relatively easily fixable if so.


-- wli
