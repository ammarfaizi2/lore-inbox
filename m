Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317375AbSFCLdS>; Mon, 3 Jun 2002 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317376AbSFCLdR>; Mon, 3 Jun 2002 07:33:17 -0400
Received: from pat.uio.no ([129.240.130.16]:65409 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317375AbSFCLdP>;
	Mon, 3 Jun 2002 07:33:15 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        "David S. Miller" <davem@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
In-Reply-To: <1023096034.19717.62.camel@storm.christs.cam.ac.uk>
	<3CFB3B87.74C7E9DF@zip.com.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 Jun 2002 13:32:56 +0200
Message-ID: <shshekkbnrr.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > Anton Altaparmakov wrote:
    >>
    >> Hi,
    >>
    >> Just got this (reproducible) kernel panic (BUG in
    >> asm-i386/highmem.h::kmap_atomic(), the if
    >> (!pte_none(*(kmap_pte-idx))) BUG(); triggers). It happens every
    >> time I boot and on an NFS mount do a ./configure.

     > Dunno about this one.  I'm seeing some (totally different) NFS
     > funnies at present - pagecache data on the client is coming up
     > zeroes under memory pressure.  Trond mentioned that NFS
     > recently went to kmap_atomic, so there is a common thread
     > there.

Following an off-list chat with David, I believe that the appended
patch should fix the problem reported by Anton. It replaces the
obsolete km_type "KM_SKB_DATA" with an entry that the RPC layer can
use in the socket bottom half.

I'm less sure whether or not it will fix your problem, Andrew, but I'm
hoping you'll find time to give it a brief test ;-)...

Cheers,
  Trond

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.413   -> 1.414  
#	include/asm-ppc/kmap_types.h	1.7     -> 1.8    
#	include/asm-x86_64/kmap_types.h	1.1     -> 1.2    
#	include/asm-sparc/kmap_types.h	1.5     -> 1.6    
#	    net/sunrpc/xdr.c	1.7     -> 1.8    
#	include/asm-i386/kmap_types.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/03	trond.myklebust@fys.uio.no	1.414
# include/asm-*/kmap_types.h:
#    Replace the obsolete km_type KM_SKB_DATA with KM_SKB_SUNRPC_DATA.
# 
# net/sunrpc/xdr.c:
#    Replace KM_USER0 with KM_SKB_SUNRPC_DATA in xdr_partial_copy_from_skb
# --------------------------------------------
#
diff -Nru a/include/asm-i386/kmap_types.h b/include/asm-i386/kmap_types.h
--- a/include/asm-i386/kmap_types.h	Tue Feb 19 16:27:39 2002
+++ b/include/asm-i386/kmap_types.h	Mon Jun  3 12:39:12 2002
@@ -11,7 +11,7 @@
 
 enum km_type {
 D(0)	KM_BOUNCE_READ,
-D(1)	KM_SKB_DATA,
+D(1)	KM_SKB_SUNRPC_DATA,
 D(2)	KM_SKB_DATA_SOFTIRQ,
 D(3)	KM_USER0,
 D(4)	KM_USER1,
diff -Nru a/include/asm-ppc/kmap_types.h b/include/asm-ppc/kmap_types.h
--- a/include/asm-ppc/kmap_types.h	Sat Mar  2 10:03:46 2002
+++ b/include/asm-ppc/kmap_types.h	Mon Jun  3 12:39:12 2002
@@ -7,7 +7,7 @@
 
 enum km_type {
 	KM_BOUNCE_READ,
-	KM_SKB_DATA,
+	KM_SKB_SUNRPC_DATA,
 	KM_SKB_DATA_SOFTIRQ,
 	KM_USER0,
 	KM_USER1,
diff -Nru a/include/asm-sparc/kmap_types.h b/include/asm-sparc/kmap_types.h
--- a/include/asm-sparc/kmap_types.h	Tue Feb  5 16:21:48 2002
+++ b/include/asm-sparc/kmap_types.h	Mon Jun  3 12:39:12 2002
@@ -3,7 +3,7 @@
 
 enum km_type {
 	KM_BOUNCE_READ,
-	KM_SKB_DATA,
+	KM_SKB_SUNRPC_DATA,
 	KM_SKB_DATA_SOFTIRQ,
 	KM_USER0,
 	KM_USER1,
diff -Nru a/include/asm-x86_64/kmap_types.h b/include/asm-x86_64/kmap_types.h
--- a/include/asm-x86_64/kmap_types.h	Thu Feb  7 15:27:25 2002
+++ b/include/asm-x86_64/kmap_types.h	Mon Jun  3 12:39:12 2002
@@ -3,7 +3,7 @@
 
 enum km_type {
 	KM_BOUNCE_READ,
-	KM_SKB_DATA,
+	KM_SKB_SUNRPC_DATA,
 	KM_SKB_DATA_SOFTIRQ,
 	KM_USER0,
 	KM_USER1,
diff -Nru a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
--- a/net/sunrpc/xdr.c	Sat May 25 21:16:06 2002
+++ b/net/sunrpc/xdr.c	Mon Jun  3 13:13:30 2002
@@ -290,7 +290,7 @@
 		char *kaddr;
 
 		len = PAGE_CACHE_SIZE;
-		kaddr = kmap_atomic(*ppage, KM_USER0);
+		kaddr = kmap_atomic(*ppage, KM_SKB_SUNRPC_DATA);
 		if (base) {
 			len -= base;
 			if (pglen < len)
@@ -302,7 +302,7 @@
 				len = pglen;
 			ret = copy_actor(desc, kaddr, len);
 		}
-		kunmap_atomic(kaddr, KM_USER0);
+		kunmap_atomic(kaddr, KM_SKB_SUNRPC_DATA);
 		if (ret != len || !desc->count)
 			return;
 		ppage++;
