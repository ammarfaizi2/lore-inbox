Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTBYAch>; Mon, 24 Feb 2003 19:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTBYAch>; Mon, 24 Feb 2003 19:32:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:52462 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264797AbTBYAcf>;
	Mon, 24 Feb 2003 19:32:35 -0500
Message-ID: <3E5ABBC1.8050203@us.ibm.com>
Date: Mon, 24 Feb 2003 16:41:37 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Horrible L2 cache effects from kernel compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was testing Martin Bligh's kernbench (a kernel compile with
-j(2*NR_CPUS)) and using DCU_MISS_OUTSTANDING as the counter event.

The surprising thing?  d_lookup() accounts for 8% of the time spent
waiting for an L2 miss.

__copy_to_user_ll should be trashing a lot of cachelines, but d_lookup()
is strange.

Counter 0 counted DCU_MISS_OUTSTANDING events (number of cycles while
DCU miss outstanding) with a unit mask of 0x00 (Not set) count 10000
c017d78c 72929    1.92175     start_this_handle
c0139b60 75317    1.98468     vm_enough_memory
c0138cd4 75367    1.986       do_no_page
c01ccae0 79475    2.09425     atomic_dec_and_lock
c0117320 80918    2.13227     scheduler_tick
c0176338 90851    2.39402     ext3_dirty_inode
c013cc38 132228   3.48434     page_remove_rmap
c0176557 148116   3.90301     .text.lock.inode
c013cae0 156345   4.11985     page_add_rmap
c012c964 157716   4.15598     find_get_page
c015797c 314165   8.27857     d_lookup
c01cc948 334779   8.82177     __copy_to_user_ll

a snippet from d_lookup(), annotated.  I've seen oprofile be off by a
line here, but we can be pretty sure it is in this area.
		...
		smp_read_barrier_depends();
		/* 106 0.002793% */
		dentry = list_entry(tmp, struct dentry, d_hash);

		/* if lookup ends up in a different bucket
		 * due to concurrent rename, fail it
		 */
		/* 154991 4.084% */
		if (unlikely(dentry->d_bucket != head))
			break;

		/* to avoid race if dentry keep coming back to original
		 * bucket due to double moves
		 */
		/* 634 0.01671% */
		if (unlikely(++lookup_count > max_dentries))
			break;
		...

-- 
Dave Hansen
haveblue@us.ibm.com

