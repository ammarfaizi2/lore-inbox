Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbUJZXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUJZXbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUJZXbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:31:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19892 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261544AbUJZXbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:31:39 -0400
Message-ID: <417EDE4C.20003@pobox.com>
Date: Tue, 26 Oct 2004 19:31:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH 2.4] the perils of kunmap_atomic
Content-Type: multipart/mixed;
 boundary="------------050501010008070200090100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050501010008070200090100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


kunmap_atomic() violates the Principle of Least Surprise in a nasty way. 
    kmap(), kunmap(), and kmap_atomic() all take struct page* to 
reference the memory location.  kunmap_atomic() is the oddball of the 
three, and takes a kernel address.

Ignoring the driver-related bugs that are present due to 
kunmap_atomic()'s weirdness, there also appears to be a big in the 
!CONFIG_HIGHMEM implementation in 2.4.x.

(Bart is poking through some of the 2.6.x-related kunmap_atomic slip-ups)

Anyway, what do people think about the attached patch to 2.4.x?  I'm 
surprised it has gone unnoticed until now.

	Jeff




--------------050501010008070200090100
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== include/linux/highmem.h 1.12 vs edited =====
--- 1.12/include/linux/highmem.h	2003-06-30 20:18:42 -04:00
+++ edited/include/linux/highmem.h	2004-10-26 19:26:14 -04:00
@@ -70,7 +70,7 @@
 #define kunmap(page) do { } while (0)
 
 #define kmap_atomic(page,idx)		kmap(page)
-#define kunmap_atomic(page,idx)		kunmap(page)
+#define kunmap_atomic(addr,idx)		kunmap(virt_to_page(addr))
 
 #define bh_kmap(bh)			((bh)->b_data)
 #define bh_kunmap(bh)			do { } while (0)

--------------050501010008070200090100--
