Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTDRXCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbTDRXCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:02:53 -0400
Received: from holomorphy.com ([66.224.33.161]:44171 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263290AbTDRXCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:02:51 -0400
Date: Fri, 18 Apr 2003 16:14:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       plars@linuxtestproject.org
Subject: Re: [Bug 601] New: BUG when running ipcs after huge page shm
Message-ID: <20030418231422.GC12469@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, akpm@digeo.com,
	plars@linuxtestproject.org
References: <1382570000.1050698909@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1382570000.1050698909@flay>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 01:48:29PM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=601
>            Summary: BUG when running ipcs after huge page shm
>     Kernel Version: 2.5.67-bk current
>             Status: NEW
>           Severity: normal
>              Owner: akpm@digeo.com
>          Submitter: plars@austin.ibm.com

Trivial. We must remember to check for hugetlb in shm_get_stat().

-- wli


diff -urpN linux-2.5.67-bk9/ipc/shm.c shmstat-2.5.67-bk9-2/ipc/shm.c
--- linux-2.5.67-bk9/ipc/shm.c	2003-04-07 10:31:20.000000000 -0700
+++ shmstat-2.5.67-bk9-2/ipc/shm.c	2003-04-18 15:53:38.000000000 -0700
@@ -361,27 +361,35 @@ static inline unsigned long copy_shminfo
 	}
 }
 
-static void shm_get_stat (unsigned long *rss, unsigned long *swp) 
+static void shm_get_stat(unsigned long *rss, unsigned long *swp) 
 {
-	struct shmem_inode_info *info;
 	int i;
 
 	*rss = 0;
 	*swp = 0;
 
-	for(i = 0; i <= shm_ids.max_id; i++) {
-		struct shmid_kernel* shp;
-		struct inode * inode;
+	for (i = 0; i <= shm_ids.max_id; i++) {
+		struct shmid_kernel *shp;
+		struct inode *inode;
 
 		shp = shm_get(i);
-		if(shp == NULL)
+		if(!shp)
 			continue;
+
 		inode = shp->shm_file->f_dentry->d_inode;
-		info = SHMEM_I(inode);
-		spin_lock (&info->lock);
-		*rss += inode->i_mapping->nrpages;
-		*swp += info->swapped;
-		spin_unlock (&info->lock);
+
+		if (is_file_hugepages(shp->shm_file)) {
+			struct address_space *mapping = inode->i_mapping;
+			spin_lock(&mapping->page_lock);
+			*rss += (HPAGE_SIZE/PAGE_SIZE)*mapping->nrpages;
+			spin_unlock(&mapping->page_lock);
+		} else {
+			struct shmem_inode_info *info = SHMEM_I(inode);
+			spin_lock(&info->lock);
+			*rss += inode->i_mapping->nrpages;
+			*swp += info->swapped;
+			spin_unlock(&info->lock);
+		}
 	}
 }
 
