Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTHJLMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTHJLLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:11:12 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:39180 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263638AbTHJLKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:10:04 -0400
Date: Sun, 10 Aug 2003 20:10:13 +0900 (JST)
Message-Id: <20030810.201013.124121938.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] convert fs/jbd to virt_to_pageoff()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810020444.48cb740b.davem@redhat.com>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[9/9] convert fs/jbd to virt_to_pageoff().

Index: linux-2.6/fs/jbd/journal.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/jbd/journal.c,v
retrieving revision 1.62
diff -u -r1.62 journal.c
--- linux-2.6/fs/jbd/journal.c	11 Jul 2003 07:04:11 -0000	1.62
+++ linux-2.6/fs/jbd/journal.c	10 Aug 2003 08:40:54 -0000
@@ -278,9 +278,6 @@
  * Bit 1 set == buffer copy-out performed (kfree the data after IO)
  */
 
-static inline unsigned long virt_to_offset(void *p) 
-{return ((unsigned long) p) & ~PAGE_MASK;}
-					       
 int journal_write_metadata_buffer(transaction_t *transaction,
 				  struct journal_head  *jh_in,
 				  struct journal_head **jh_out,
@@ -318,10 +315,10 @@
 	if (jh_in->b_frozen_data) {
 		done_copy_out = 1;
 		new_page = virt_to_page(jh_in->b_frozen_data);
-		new_offset = virt_to_offset(jh_in->b_frozen_data);
+		new_offset = virt_to_pageoff(jh_in->b_frozen_data);
 	} else {
 		new_page = jh2bh(jh_in)->b_page;
-		new_offset = virt_to_offset(jh2bh(jh_in)->b_data);
+		new_offset = virt_to_pageoff(jh2bh(jh_in)->b_data);
 	}
 
 	mapped_data = kmap_atomic(new_page, KM_USER0);
@@ -358,7 +355,7 @@
 		   address kmapped so that we can clear the escaped
 		   magic number below. */
 		new_page = virt_to_page(tmp);
-		new_offset = virt_to_offset(tmp);
+		new_offset = virt_to_pageoff(tmp);
 		done_copy_out = 1;
 	}
 

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
