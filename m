Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRAKP26>; Thu, 11 Jan 2001 10:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132138AbRAKP2t>; Thu, 11 Jan 2001 10:28:49 -0500
Received: from pat.uio.no ([129.240.130.16]:22707 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129927AbRAKP2i>;
	Thu, 11 Jan 2001 10:28:38 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
In-Reply-To: <20010110013755.D13955@suse.de> <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk> <20010110163158.F19503@athlon.random>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Jan 2001 16:28:28 +0100
In-Reply-To: Andrea Arcangeli's message of "Wed, 10 Jan 2001 16:31:58 +0100"
Message-ID: <shszogy2jmr.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:

     > As far I can see the only reason size makes sense to be 32bit
     > is to get some more strict behaviour in the below code (to
     > avoid discarding the most significant 16bits in sanity checks
     > like this):

     > nlm4_decode_fh(u32 *p, struct nfs_fh *f) {
     >         memset(f->data, 0, sizeof(f->data));
     >         f-> size = ntohl(*p++);
     >         if (f->size > NFS_MAXFHSIZE) {
     >                 printk(KERN_NOTICE
     >                         "lockd: bad fhandle size %d (should be
     >                         <=%d)\n",
     >                         f-> size, NFS_MAXFHSIZE);
     >                 return NULL;
     >         }
     >         memcpy(f->data, p, f->size);
     >         return p + XDR_QUADLEN(f->size);
     > }

I agree, and if that's the only problem, then the appended patch will
fix it without any need to change struct nfs_fh.

As for the issue of casting 'fh->data' as a 'struct knfsd' then that
is a perfectly valid operation.
The fh->data is a cookie as far as the client is concerned, and hence
it will pass back exactly whatever the server sent it (alignment and
all).

IOW: the knfsd server copied a struct knfsd and sent it off to the
client, and now the exact same server is receiving a completely
unadulterated version of said struct knfsd for use by the lockd server
routines.
Unless somebody is using one compiler for the knfsd directory and then
a completely different one for lockd, I fail to see why this should
result in structure alignment problems on PPC or on any other
platform.

Cheers,
   Trond





--- fs/lockd/xdr4.c.orig	Thu Jan 11 15:52:44 2001
+++ fs/lockd/xdr4.c	Thu Jan 11 15:53:37 2001
@@ -83,16 +83,19 @@
 static u32 *
 nlm4_decode_fh(u32 *p, struct nfs_fh *f)
 {
+	unsigned int size;
+
 	memset(f->data, 0, sizeof(f->data));
-	f->size = ntohl(*p++);
-	if (f->size > NFS_MAXFHSIZE) {
+	size = ntohl(*p++);
+	if (size > NFS_MAXFHSIZE) {
 		printk(KERN_NOTICE
 			"lockd: bad fhandle size %x (should be %d)\n",
-			f->size, NFS_MAXFHSIZE);
+			size, NFS_MAXFHSIZE);
 		return NULL;
 	}
-      	memcpy(f->data, p, f->size);
-	return p + XDR_QUADLEN(f->size);
+	f->size = size;
+      	memcpy(f->data, p, size);
+	return p + XDR_QUADLEN(size);
 }
 
 static u32 *
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
