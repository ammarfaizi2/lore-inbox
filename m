Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272484AbRJBMDr>; Tue, 2 Oct 2001 08:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272540AbRJBMDh>; Tue, 2 Oct 2001 08:03:37 -0400
Received: from mons.uio.no ([129.240.130.14]:40911 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S272484AbRJBMDW>;
	Tue, 2 Oct 2001 08:03:22 -0400
MIME-Version: 1.0
Message-ID: <15289.44299.915454.3729@charged.uio.no>
Date: Tue, 2 Oct 2001 14:03:23 +0200
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, <alan@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: NFSv3 and linux-2.4.10-ac3 => oops
In-Reply-To: <Pine.LNX.4.33.0110021227340.31037-100000@nick.dcs.qmul.ac.uk>
In-Reply-To: <shszo7a4bxp.fsf@charged.uio.no>
	<Pine.LNX.4.33.0110021227340.31037-100000@nick.dcs.qmul.ac.uk>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Matt Bernstein <matt@theBachChoir.org.uk> writes:

     > I wonder if this is related to oopses I sent in in the last two
     > days?  We're running 4GB setups with NFSv3 client and server on
     > our fileservers, and the oopses might (don't really have strong
     > correlation evidence yet) be related to when our fileservers
     > push online backups to cheaper NFS servers (running the same
     > kernel based on 2.4.9-ac10). Is there a last known good kernel
     > I can try on my production systems while I try to reproduce the
     > problem on smaller boxes? Or would you like me to try your
     > patch?

Linus changed nfs_prepare_write() in his tree around 2.4.10-pre5. From
what I can see, Alan merged that particular patch into 2.4.9-ac11 (but
without merging in the related changes to linux/mm/filemap.c).

Argh. I see that in the patch I put out earlier today, I forgot to
also revert the removal of the kunmap() in nfs_commit_write() (sorry -
my coffee was particularly weak this morning).

Please apply the following patch to the 'ac' tree instead.

People who use Linus' tree should *not* apply this patch!!!!!

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.10-reclaim/fs/nfs/file.c linux-2.4.10-ac4/fs/nfs/file.c
--- linux-2.4.10-reclaim/fs/nfs/file.c	Sun Sep 23 18:48:01 2001
+++ linux-2.4.10-ac4/fs/nfs/file.c	Tue Oct  2 13:40:58 2001
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
@@ -164,6 +169,7 @@
 	loff_t pos = ((loff_t)page->index<<PAGE_CACHE_SHIFT) + to;
 	struct inode *inode = page->mapping->host;
 
+	kunmap(page);
 	lock_kernel();
 	status = nfs_updatepage(file, page, offset, to-offset);
 	unlock_kernel();
