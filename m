Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWIOK1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWIOK1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 06:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWIOK1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 06:27:34 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:47012 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750982AbWIOK1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 06:27:33 -0400
Date: Fri, 15 Sep 2006 12:27:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Alignment of fields in struct dentry
Message-ID: <20060915102736.GA767@wohnheim.fh-wedel.de>
References: <20060914093123.GA10431@wohnheim.fh-wedel.de> <20060914105029.GA1702@wohnheim.fh-wedel.de> <20060914183325.GU6441@schatzie.adilger.int> <20060914210235.GA10548@wohnheim.fh-wedel.de> <20060914215545.GC6441@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060914215545.GC6441@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 September 2006 15:55:45 -0600, Andreas Dilger wrote:
> On Sep 14, 2006  23:02 +0200, J???rn Engel wrote:
> > 
> > Using your scheme (slightly reduced) we now have:
> > 		size32	size64	funky?
> > d_count	4	4
> > d_flags	4	4
> > d_lock	4	4_	y
> > d_inode	4_	8
> > d_hash	8	16--
> > d_parent	4	8_
> > d_name	12--	16___
> > d_lru		8_	16_
> > d_rcu/d_child	8	16__
> > d_subdirs	8___	16_
> > d_alias	8	16____
> > d_time	4	8
> > d_op		4_	8_
> > d_sb		4	8
> > d_fsdata	4	8__
> > d_cookie	0	0	y
> > d_mounted	4	4
> > d_iname	36____	36
> > 
> > With the two funky fields possibly growing, depending on kernel
> > config.  [_-] mark 16-, 32- 64- and 128-byte boundaries, depending on
> > len.  What really frightens me is that a 32-byte boundary goes right
> > through d_name on 32bit machines.
> 
> Actually, splitting d_name like this is not so bad (as long as the
> compiler doesn't add padding) because the important fields (hash
> and len) are first and are compared for all non-matching dentries
> in __d_lookup().

Except that d_name is split between hash and len, not between len and
name.  You said d_lock was added later?  Looks like it broke careful
tuning for 32-byte cacheline machines.  And it could also have caused
the misalignment on 64bit.

> > Now d_lookup() should use a single cacheline, even on my aged
> > notebook, and the other hot fields remain at the top.  d_mounted is
> > also moved up to remove the misalignment on 64bit.  Might be worth
> > a benchmark or two to see whether it makes a difference...
> 
> Might not be too hard (even if it temporarily kills performance)
> to add atomic counters for each of these fields where they are
> referenced in dcache.c, namei.c and e.g. fs/ext3/*.c (which is
> only using d_inode, d_name, and d_parent).  Run a find and a
> kernel compile and dump the counters at shutdown.

Might be even simpler by running gcov/lcov.  That would not show which
fields are used at similar times, but it is a start.

Btw, I already mentioned how reducing the d_iname fields by a few
bytes could save a cacheline.  And whenever I have a good idea, Arnd
usually comes up with a better one.  How about the patch below to fix
dentries to 128/192 bytes on 32/64 bit machines, independently of
config options?  It would shrink them from 132 bytes to 128 bytes in
my current config (although I don't quite remember why I turned
CONFIG_PROFILING on).

Jörn

-- 
Joern's library part 14:
http://www.sandpile.org/

--- slab/include/linux/dcache.h~dentry_size	2006-09-14 22:19:51.000000000 +0200
+++ slab/include/linux/dcache.h	2006-09-15 12:25:27.000000000 +0200
@@ -77,7 +77,7 @@ full_name_hash(const unsigned char *name
 
 struct dcookie_struct;
 
-#define DNAME_INLINE_LEN_MIN 36
+#define DNAME_INLINE_LEN_MIN 16
 
 struct dentry {
 	atomic_t d_count;
@@ -112,7 +112,10 @@ struct dentry {
 #endif
 	int d_mounted;
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
-};
+}__attribute__((aligned(64)));	/* make sure the dentry is 128/192 bytes
+				   on 32/64 bit independently of config
+				   options.  d_iname will vary in length
+				   a bit. */
 
 /*
  * dentry->d_lock spinlock nesting subclasses:
