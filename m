Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130869AbRAKRsT>; Thu, 11 Jan 2001 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRAKRsK>; Thu, 11 Jan 2001 12:48:10 -0500
Received: from mons.uio.no ([129.240.130.14]:10628 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S130869AbRAKRr5>;
	Thu, 11 Jan 2001 12:47:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14941.61668.697523.866481@charged.uio.no>
Date: Thu, 11 Jan 2001 18:44:04 +0100 (CET)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Russell King <rmk@arm.linux.org.uk>,
        Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
In-Reply-To: <3A5DDD09.C8C70D36@colorfullife.com>
In-Reply-To: <20010110013755.D13955@suse.de>
	<200101100654.f0A6sjJ02453@flint.arm.linux.org.uk>
	<20010110163158.F19503@athlon.random>
	<shszogy2jmr.fsf@charged.uio.no>
	<3A5DDD09.C8C70D36@colorfullife.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Manfred Spraul <manfred@colorfullife.com> writes:

     > Trond Myklebust wrote:
    >>
    >>
    >> As for the issue of casting 'fh->data' as a 'struct knfsd' then
    >> that is a perfectly valid operation.
    >>
     > No it isn't.

     > fh-> data is an array of characters, thus without any alignment
     > restrictions.  'struct knfsd' begins with a pointer, thus it
     > must be 4 or 8 byte aligned.

     > The portable 'struct nfs_fh' structure would be

     > #define NFS_HANDLESIZE 64
     > struct nfs_fh {
     > 	unsigned short len; void* data[NFS_HANDLESIZE/sizeof(void*)];
     > };

Ok. I see your point now. How about the appended patch then? It means
an extra copy operation, but it should be a lot less ugly than doing
manual alignment...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.2.18/fs/lockd/svcsubs.c linux-2.2.18-fix_ppc/fs/lockd/svcsubs.c
--- linux-2.2.18/fs/lockd/svcsubs.c	Mon Dec 11 01:49:44 2000
+++ linux-2.2.18-fix_ppc/fs/lockd/svcsubs.c	Thu Jan 11 18:43:31 2001
@@ -49,34 +49,37 @@
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
+		if (file->f_handle.fh_dcookie == fh.fh_dcookie &&
+		    !memcmp(&file->f_handle, &fh, sizeof(fh)))
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
@@ -85,7 +88,7 @@
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
