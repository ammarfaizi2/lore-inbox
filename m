Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285249AbRLMXHr>; Thu, 13 Dec 2001 18:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285251AbRLMXHh>; Thu, 13 Dec 2001 18:07:37 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:39156 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S285249AbRLMXHY>;
	Thu, 13 Dec 2001 18:07:24 -0500
Date: Thu, 13 Dec 2001 16:07:06 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: optimize DNAME_INLINE_LEN
Message-ID: <20011213160706.E940@lynx.no>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <3C192A37.4547D2A7@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C192A37.4547D2A7@colorfullife.com>; from manfred@colorfullife.com on Thu, Dec 13, 2001 at 11:22:47PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 13, 2001  23:22 +0100, Manfred Spraul wrote:
> The dcache entries are allocated with SLAB_HWCACHE_ALIGN. For better
> memory usage, we should increase DNAME_INLINE_LEN so that sizeof(struct
> dentry) becomes a multiple of the L1 cache line size.
> 
> On i386 the DNAME_INLINE_LEN becomes 36 bytes instead of 16, which saves
> thousands of kmallocs for external file names. (12818 on my debug
> system, after updatedb)

If the dentries are already aligned on cachelines, I don't see any reason
NOT to do this.  Why waste all the memory for alignment when it can be
used for something else?

> The attached patch is preliminary, it doesn't compile with egcs-1.1.2.
> Which gcc version added support for unnamed structures?

Hmm, I thought it was gcc 3.0 that supported unnames structures.  For
sure gcc 2.95.2 does not, because unnamed structs are used in the NTFS
tools, and I couldn't compile them.

If you wanted to keep compatibility for older compilers (may be a good idea)
you could do something ugly like using a named struct like "du" and then:

#define d_inode du.du_inode
#define d_count du.du_count
.
.
.
#define d_fsdata du.du_fsdata



Alternately (also ugly) you could just define struct dentry the as now,
but have a fixed size declaration for d_iname, like:

#define DNAME_INLINE_MIN 16

	unsigned char d_iname[DNAME_INLINE_MIN];
	
and only set DNAME_INLINE_LEN afterwards like:

#define DNAME_INLINE_LEN \
	(DNAME_INLINE_MIN+L1_CACHE_BYTES - sizeof(struct dentry)%L1_CACHE_BYTES)

This _should_ work for all code that uses DNAME_INLINE_LEN, and if the
alignment doesn't change.  It will break horribly if you do sizeof(struct
dentry), declare a dentry on the stack, or if someone changes the alignment.

You can also do preprocessor macro tricks to get something like an unnamed
union in a struct, but it is also a bit ugly.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

