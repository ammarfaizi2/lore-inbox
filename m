Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSGLRde>; Fri, 12 Jul 2002 13:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSGLRdd>; Fri, 12 Jul 2002 13:33:33 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:64011 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S316709AbSGLRda>; Fri, 12 Jul 2002 13:33:30 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17) 
cc: pmenage@ensim.com
In-reply-to: Your message of "Fri, 12 Jul 2002 10:29:53 EDT."
             <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jul 2002 10:35:55 -0700
Message-Id: <E17T4Kh-0005pB-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Note: measurements on 2.4 do not make sense; reduction of cacheline
>bouncing between 2.4 and 2.5 will change the results anyway and
>if any of these patches are going to be applied to 2.4, reduction of
>cacheline bouncing on ->d_count is going to go in before that one.

I think there are some other possibilities for cache-bounce removal in
struct dentry. The most obvious one is d_vfs_flags - not only does it
get written to on every d_lookup (to set DCACHE_REFERENCED) but it also
shares a cache line (on Pentium IV) with d_op, d_iname and part of
d_name (along with d_sb and d_fsdata, but these don't seem to be so
crucial).

Some quick stats gathering suggested that DCACHE_REFERENCED is already
set 95%-98% of the time, so this cache bounce is not even doing anything
useful. I submitted this patch a while ago making the DCACHE_REFERENCED
bit setting be conditional on it not being already set, which didn't
generate any interest. One problem with this patch would be the
additional branch prediction misses (on some architectures?) that would
work against the benefits of not dirtying a cache line. 

Maybe we should have a function definition something like the following:

static __inline__ void __ensure_bit_set(int nr, volatile unsigned long * addr) 
{
#if defined (CONFIG_BIG_SMP) || defined(ARCH_HAVE_PREDICATED_WRITE)
	if(!test_bit(nr, addr))
#endif
		set_bit(nr, addr);
}	

so that architectures that support conditional writes (arm and ia64?) and 
for SMP systems with enough processors that cache-bouncing is an issue, 
the test can be performed, and for others where the branch prediction 
miss would hurt us more than the cache dirtying it would just do it 
unconditionally.
 
--- linux-2.5.13/fs/dcache.c	Thu May  2 17:22:42 2002
+++ linux-2.5.13-nodref/fs/dcache.c	Sat May  4 16:36:38 2002
@@ -883,7 +883,8 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+		if(!(dentry->d_vfs_flags & DCACHE_REFERENCED))
+			dentry->d_vfs_flags |= DCACHE_REFERENCED;
 		return dentry;
 	}
 	return NULL;


Perhaps another solution is to rearrange struct dentry - put the
volatile stuff in one cache line (or set of lines), and the constant
stuff in another. So probably d_count, d_lru and d_vfs_flags
would be in the volatile line, and most other stuff in the the other.

It would probably make sense to ensure that d_name and d_iname share a
cache line if possible, even on smaller cache-line architectures, and
maybe also d_hash and d_parent on that same line.

Paul



