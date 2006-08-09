Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWHIGUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWHIGUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbWHIGUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:20:48 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:11499 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1030513AbWHIGUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:20:47 -0400
Date: Tue, 8 Aug 2006 23:21:59 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Jan Beulich <jbeulich@novell.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Message-ID: <20060809062159.GA3829@localhost.localdomain>
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net> <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com> <20060808140511.def9b13c.akpm@osdl.org> <6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com> <20060808143751.42f8d87c.akpm@osdl.org> <6bffcb0e0608081511x17508f89j60705bf74e09e820@mail.gmail.com> <20060808164210.edb10cdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808164210.edb10cdc.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:42:10PM -0700, Andrew Morton wrote:
> On Wed, 9 Aug 2006 00:11:38 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
> ah-hah, thanks.  The oopsing statement was added by
> slab-fix-lockdep-warnings.patch.
> 
> I guess we can fix this by whacking another #ifdef CONFIG_NUMA in there but
> I don't think that's how we want to address this.
> 
> We've been moving towards making the NUMA slab code work OK in a non-NUMA
> build by setting the NUMA-specific fields to NULL and simply blowing a few
> cycles at runtime to avoid many tens of ifdefs (it's that bad).
> 
> Here, we should have had either l3==NULL or l3->alien==NULL, but that has
> been violated, hence the crash.
> Kiran, could you take a look please?  The 0x01020304 is interesting...

Eeesh, because on SMP,  alloc_alien_cache returns 0x01020304 instead of
NULL, And it returns 0x01020304 because CPU_UP_PREPARE fails if
alloc_alien_cache returns NULL.  NUMA and non NUMA slab should be able to
work even without alien caches, currently that doesn't seem to be the case.
We are working on that.  In the meanwhile, the following patch should
fix the oops due to locdep annotation.

Thanks,
Kiran

Fix oops due to alien cache locdep annotation on non NUMA configurations.
A plain alien != NULL won't work as l3->alien is initialized with
0x01020304ul

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.18-rc3mm3/mm/slab.c
===================================================================
--- linux-2.6.18-rc3mm3.orig/mm/slab.c	2006-08-08 19:19:51.000000000 -0700
+++ linux-2.6.18-rc3mm3/mm/slab.c	2006-08-08 21:53:53.000000000 -0700
@@ -674,6 +674,8 @@ static struct kmem_cache cache_cache = {
 #endif
 };
 
+#define BAD_ALIEN_MAGIC 0x01020304ul
+
 #ifdef CONFIG_LOCKDEP
 
 /*
@@ -705,7 +707,14 @@ static inline void init_lock_keys(void)
 				continue;
 			lockdep_set_class(&l3->list_lock, &on_slab_l3_key);
 			alc = l3->alien;
-			if (!alc)
+			/*
+			 * FIXME: This check for BAD_ALIEN_MAGIC
+			 * should go away when common slab code is taught to 
+			 * work even without alien caches.  
+			 * Currently, non NUMA code returns BAD_ALIEN_MAGIC
+			 * for alloc_alien_cache,
+			 */
+			if (!alc || (unsigned long) alc == BAD_ALIEN_MAGIC)
 				continue;
 			for_each_node(r) {
 				if (alc[r])
@@ -1112,7 +1121,7 @@ static inline int cache_free_alien(struc
 
 static inline struct array_cache **alloc_alien_cache(int node, int limit)
 {
-	return (struct array_cache **) 0x01020304ul;
+	return (struct array_cache **) BAD_ALIEN_MAGIC;
 }
 
 static inline void free_alien_cache(struct array_cache **ac_ptr)
