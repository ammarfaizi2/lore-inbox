Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274079AbRJBOEN>; Tue, 2 Oct 2001 10:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274134AbRJBOEE>; Tue, 2 Oct 2001 10:04:04 -0400
Received: from pat.uio.no ([129.240.130.16]:64975 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S274079AbRJBODx>;
	Tue, 2 Oct 2001 10:03:53 -0400
MIME-Version: 1.0
Message-ID: <15289.51533.788916.244457@charged.uio.no>
Date: Tue, 2 Oct 2001 16:03:57 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: matt@theBachChoir.org.uk (Matt Bernstein),
        hpa@transmeta.com (H. Peter Anvin), alan@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: NFSv3 and linux-2.4.10-ac3 => oops
In-Reply-To: <E15oPv4-0004gl-00@the-village.bc.nu>
In-Reply-To: <15289.44299.915454.3729@charged.uio.no>
	<E15oPv4-0004gl-00@the-village.bc.nu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    >> what I can see, Alan merged that particular patch into
    >> 2.4.9-ac11 (but without merging in the related changes to
    >> linux/mm/filemap.c).

     > Ok its probably better I merge the related mm/filemap.c changes
     > if someone has the relevant bits handy. That helps to keep the
     > differences down

The following ought to be sufficient.

Cheers,
   Trond

--- linux-2.4.10-ac/mm/filemap.c	Tue Oct  2 15:53:04 2001
+++ linux-2.4.10-new/mm/filemap.c	Tue Oct  2 15:56:29 2001
@@ -2673,10 +2673,10 @@
 			PAGE_BUG(page);
 		}
 
+		kaddr = kmap(page);
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
 			goto sync_failure;
-		kaddr = page_address(page);
 		status = __copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
 		if (status) {
@@ -2695,6 +2695,7 @@
 			buf += status;
 		}
 unlock:
+		kunmap(page);
 		/* Mark it unlocked again and drop the page.. */
 		UnlockPage(page);
 		if (deactivate)
@@ -2728,9 +2729,9 @@
 fail_write:
 	status = -EFAULT;
 	ClearPageUptodate(page);
-	kunmap(page);
 	goto unlock;
 sync_failure:
+	kunmap(page);
 	UnlockPage(page);
 	deactivate_page(page);
 	page_cache_release(page);
