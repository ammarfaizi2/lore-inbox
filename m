Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbSJITKf>; Wed, 9 Oct 2002 15:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbSJITKf>; Wed, 9 Oct 2002 15:10:35 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:65525 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262053AbSJITKI>; Wed, 9 Oct 2002 15:10:08 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 9 Oct 2002 13:13:35 -0600
To: linux-kernel@vger.kernel.org
Subject: [BUG] CONFIG_DEBUG_SLAB broken on SMP
Message-ID: <20021009191335.GB3045@clusterfs.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were tracking down a strange bug in our code that only appeared on
SMP and not UP, and we thought that CONFIG_DEBUG_SLAB (and the ensuing
FORCED_DEBUG which enables SLAB_POISON and SLAB_REDZONE) was going to
catch problems with slab objects, so we were very very confused when a
test like:

	struct foo *obj;

	cache = kmem_cache_create("test_cache", sizeof(struct foo))
	obj = kmem_cache_alloc(cache, GFP_KERNEL);
	kmem_cache_free(cache, obj);
	// print out contents of obj

was not poisoning obj, or setting the redzone fields on obj to "free".

The problem appears to be in the SMP version of __kmem_cache_alloc()
and __kmem_cache_free(), where it simply sticks the obj in the per-CPU
list without doing the poison or redzone stuff that is done inside
kmem_cache_free_one_tail().

Granted, there are per-slab caches for performance reasons, but putting
the object poisoning and redzoning inside the per-CPU operations does
not cause any additional overhead when it is not enabled, and also helps
to find SMP bugs, especially race conditions between referencing an
object in one thread and freeing it in another (which are much more
prevelant on SMP systems as well).

I'm working on a patch now, if people are interested in this.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

