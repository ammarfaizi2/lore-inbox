Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934422AbWK2L37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934422AbWK2L37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934180AbWK2L37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:29:59 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:52106 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1757680AbWK2L36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:29:58 -0500
Message-ID: <364799788.33437@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061129112948.946621000@intel.ustc.edu.cn>
References: <20061129111416.430835000@intel.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 19:14:18 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: [patch 2/2] readahead nfsd case: fix uninitialized ra_min/ra_max
Content-Disposition: inline; filename=readahead-nfsd-case-fix-uninitialized-ra_min-ra_max.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ra_min/ra_max are not initialized, fix it.

New benchmark numbers on

	hda: ST3250820A, ATA DISK drive
	hda: max request size: 512KiB
	hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)

with nfs mount
	mount -o tcp,rsize=$((rsize<<10)) localhost:$EXPORT $MNT

   rsize      stock  adaptive
   ==================================
f
      8k       3.07    2.51    -18.2%
     32k       2.40    2.17     -9.6%
    128k       2.40    2.35     -2.1%
ff
      8k      12.44    6.40    -48.6%
     32k      14.62    5.46    -62.7%
    128k      15.79    5.19    -67.1%
d
      8k       2.84    2.48    -12.7%
     32k       2.53    1.99    -21.3%
    128k       2.18    2.00     -8.3%
dd
      8k       8.16    7.99     -2.1%
     32k       8.27    6.88    -16.8%
    128k       7.75    6.97    -10.1%

The 4 patterns tested are:
	 f: single file read
	ff: double file parallel read
	 d: single dir read
	dd: double dir parallel read

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.19-rc6-mm1.orig/mm/readahead.c
+++ linux-2.6.19-rc6-mm1/mm/readahead.c
@@ -1616,6 +1616,10 @@ page_cache_readahead_adaptive(struct add
 	unsigned long ra_max;
 	int ret;
 
+	/* no read-ahead */
+	if (!ra->ra_pages)
+		return 0;
+
 	if (page) {
 		ClearPageReadahead(page);
 
@@ -1635,9 +1639,6 @@ page_cache_readahead_adaptive(struct add
 						offset + LAPTOP_POLL_INTERVAL))
 				return 0;
 		}
-	} else if (ra->flags & RA_FLAG_NFSD) { /* nfsd read */
-		ra_size = max_sane_readahead(req_size);
-		goto readit;
 	}
 
 	if (page)
@@ -1647,11 +1648,13 @@ page_cache_readahead_adaptive(struct add
 
 	get_readahead_bounds(ra, &ra_min, &ra_max);
 
-	/* read-ahead disabled? */
-	if (unlikely(!ra_max || !readahead_ratio)) {
-		ra_size = max_sane_readahead(req_size);
+	/* read as is */
+	if (!readahead_ratio)
+		goto readit;
+
+	/* nfsd read */
+	if (!page && (ra->flags & RA_FLAG_NFSD))
 		goto readit;
-	}
 
 	/*
 	 * Start of file.
@@ -1698,11 +1701,11 @@ page_cache_readahead_adaptive(struct add
 		return 0;
 	}
 
+readit:
 	/*
 	 * Random read.
 	 */
 	ra_size = min(req_size, ra_max);
-readit:
 	ra_size = __do_page_cache_readahead(mapping, filp, offset, ra_size, 0);
 
 	ra_account(ra, RA_EVENT_RANDOM_READ, ra_size);

--
