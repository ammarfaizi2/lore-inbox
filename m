Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275982AbRJBJki>; Tue, 2 Oct 2001 05:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275981AbRJBJk3>; Tue, 2 Oct 2001 05:40:29 -0400
Received: from pat.uio.no ([129.240.130.16]:62863 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S275982AbRJBJkP>;
	Tue, 2 Oct 2001 05:40:15 -0400
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: alan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NFSv3 and linux-2.4.10-ac3 => oops
In-Reply-To: <200110012340.QAA02719@sw170.transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Oct 2001 11:40:34 +0200
In-Reply-To: "H. Peter Anvin"'s message of "Mon, 1 Oct 2001 16:40:05 -0700"
Message-ID: <shszo7a4bxp.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == H Peter Anvin <hpa@transmeta.com> writes:

     > Hello everyone, I have a reproducible (and rather quick) oops
     > on a system running linux-2.4.10-ac3, which seems to be NFS
     > (v3) related; although ksymoops core dumps when I try to use
     > it, I have manually decoded the dump to indicate that it
     > happens in rwsem_down_read_failed called from nfs_file_wite.
     > Rather than posting too much here, I have put as much
     > information as I have been able to gather at:

     > ftp://ftp.zytor.com/pub/hpa/oops/

I'm trying to look at this, but it seems a hopeless mess: there are no
calls to any read/write semaphore routines in the NFS code.

AFAICS the second stack return point corresponds to the call to
generic_file_write() in nfs_file_write(), so I'd guess that the Oops
is actually happening somewhere there...

Hmm... Looking at the code in generic_file_write(), I see that Alan
hasn't merged in the kmap() stuff in generic_file_write()from
Linus. At the same time, the nfs_prepare_write() seems to have been
synced with Linus, and so the kmap() that used to be there has
disappeared.

As  your  config  indicates  that  you  *are*  using CONFIG_HIGHMEM4G,
perhaps one ought to start with a patch that fixes the obvious bug (in
the hope that it'll at least clean up the next Oops)...

Cheers,
  Trond

--- linux-2.4.10-hpa/fs/nfs/file.c.orig	Sun Sep 23 18:48:01 2001
+++ linux-2.4.10-hpa/fs/nfs/file.c	Tue Oct  2 11:33:43 2001
@@ -155,7 +155,12 @@
  */
 static int nfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
-	return nfs_flush_incompatible(file, page);
+	int status;
+	kmap(page);
+	status = nfs_flush_incompatible(file, page);
+	if (status)
+		kunmap(page);
+	return status;
 }
 
 static int nfs_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
