Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAKSbV>; Thu, 11 Jan 2001 13:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRAKSbK>; Thu, 11 Jan 2001 13:31:10 -0500
Received: from mons.uio.no ([129.240.130.14]:8581 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S130006AbRAKSbG>;
	Thu, 11 Jan 2001 13:31:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14941.64473.902580.756312@charged.uio.no>
Date: Thu, 11 Jan 2001 19:30:49 +0100 (CET)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
In-Reply-To: <20010111192758.E3560@athlon.random>
In-Reply-To: <20010110013755.D13955@suse.de>
	<200101100654.f0A6sjJ02453@flint.arm.linux.org.uk>
	<20010110163158.F19503@athlon.random>
	<shszogy2jmr.fsf@charged.uio.no>
	<3A5DDD09.C8C70D36@colorfullife.com>
	<14941.61668.697523.866481@charged.uio.no>
	<shsae8y2blg.fsf@charged.uio.no>
	<20010111192758.E3560@athlon.random>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:

     > On Thu, Jan 11, 2001 at 07:22:03PM +0100, Trond Myklebust
     > wrote:
    >> [..] Are there any alignment requirements on them?

     > On some arch int can be read only at a sizeof(int) byte aligned
     > address (details in my example in reply to Russell).

OK. In that case my patch, would just be amended to eliminate the
redundant comparison as is the case below.

Cheers,
   Trond

diff -u --recursive --new-file linux-2.2.18/fs/lockd/svcsubs.c linux-2.2.18-fix_ppc/fs/lockd/svcsubs.c
--- linux-2.2.18/fs/lockd/svcsubs.c	Mon Dec 11 01:49:44 2000
+++ linux-2.2.18-fix_ppc/fs/lockd/svcsubs.c	Thu Jan 11 19:00:11 2001
@@ -49,34 +49,36 @@
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 					struct nfs_fh *f)
 {
-	struct knfs_fh	*fh = (struct knfs_fh *) f->data;
+	struct knfs_fh	fh;
 	struct nlm_file	*file;
 	unsigned int	hash;
 	u32		nfserr;
 
+	/* Copy filehandle to avoid pointer alignment issues */
+	memcpy(&fh, f->data, sizeof(fh));
+
 	dprintk("lockd: nlm_file_lookup(%s/%u)\n",
-		kdevname(u32_to_kdev_t(fh->fh_dev)), fh->fh_ino);
+		kdevname(u32_to_kdev_t(fh.fh_dev)), fh.fh_ino);
 
-	hash = file_hash(u32_to_kdev_t(fh->fh_dev), u32_to_ino_t(fh->fh_ino));
+	hash = file_hash(u32_to_kdev_t(fh.fh_dev), u32_to_ino_t(fh.fh_ino));
 
 	/* Lock file table */
 	down(&nlm_file_sema);
 
 	for (file = nlm_files[hash]; file; file = file->f_next) {
-		if (file->f_handle.fh_dcookie == fh->fh_dcookie &&
-		    !memcmp(&file->f_handle, fh, sizeof(*fh)))
+		if (!memcmp(&file->f_handle, &fh, sizeof(fh)))
 			goto found;
 	}
 
 	dprintk("lockd: creating file for %s/%u\n",
-		kdevname(u32_to_kdev_t(fh->fh_dev)), fh->fh_ino);
+		kdevname(u32_to_kdev_t(fh.fh_dev)), fh.fh_ino);
 	nfserr = nlm4_lck_denied_nolocks;
 	file = (struct nlm_file *) kmalloc(sizeof(*file), GFP_KERNEL);
 	if (!file)
 		goto out_unlock;
 
 	memset(file, 0, sizeof(*file));
-	file->f_handle = *fh;
+	memcpy(&file->f_handle, &fh, sizeof(file->f_handle));
 	file->f_sema   = MUTEX;
 
 	/* Open the file. Note that this must not sleep for too long, else
@@ -85,7 +87,7 @@
 	 * We have to make sure we have the right credential to open
 	 * the file.
 	 */
-	if ((nfserr = nlmsvc_ops->fopen(rqstp, fh, &file->f_file)) != 0) {
+	if ((nfserr = nlmsvc_ops->fopen(rqstp, &fh, &file->f_file)) != 0) {
 		dprintk("lockd: open failed (nfserr %d)\n", ntohl(nfserr));
 		goto out_free;
 	}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
