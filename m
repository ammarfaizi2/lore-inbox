Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbUBEBkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUBEBkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:40:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:22953 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264981AbUBEBkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 20:40:13 -0500
Subject: [PATCH 2.6.2-rc3-mm1] DIO read race fix
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Janet Morgan <janetmor@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <20040109035510.GA3279@in.ibm.com>
References: <3FCD4B66.8090905@us.ibm.com>
	 <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	 <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	 <20031230045334.GA3484@in.ibm.com>
	 <1072830557.712.49.camel@ibm-c.pdx.osdl.net>
	 <20031231060956.GB3285@in.ibm.com>
	 <1073606144.1831.9.camel@ibm-c.pdx.osdl.net>
	 <20040109035510.GA3279@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-NEHzzdBIvhWJ8IUPPqjo"
Organization: 
Message-Id: <1075945198.7182.46.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Feb 2004 17:39:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NEHzzdBIvhWJ8IUPPqjo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have found (finally) the problem causing DIO reads racing with
buffered writes to see uninitialized data on ext3 file systems 
(which is what I have been testing on).

The problem is caused by the changes to __block_write_page_full()
and a race with journaling:

journal_commit_transaction() -> ll_rw_block() -> submit_bh()
	
ll_rw_block() locks the buffer, clears buffer dirty and calls
submit_bh()

A racing __block_write_full_page() (from ext3_ordered_writepage())

	would see that buffer_dirty() is not set because the i/o
        is still in flight, so it would not do a bh_submit()

	It would SetPageWriteback() and unlock_page() and then
	see that no i/o was submitted and call end_page_writeback()
	(with the i/o still in flight).

This would allow the DIO code to issue the DIO read while buffer writes
are still in flight.  The i/o can be reordered by i/o scheduling and
the DIO can complete BEFORE the writebacks complete.  Thus the DIO
sees the old uninitialized data.

Here is a quick hack that fixes it, but I am not sure if this the
proper long term fix.

Thoughts?

Daniel



--=-NEHzzdBIvhWJ8IUPPqjo
Content-Disposition: attachment; filename=2.6.2-rc3-mm1.DIO-read_race.patch
Content-Type: text/plain; name=2.6.2-rc3-mm1.DIO-read_race.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.2-rc3-mm1/fs/buffer.c	2004-02-04 17:12:43.823525259 -0800
+++ linux-2.6.2-rc3-mm1.patch/fs/buffer.c	2004-02-04 17:16:43.033252068 -0800
@@ -1810,6 +1810,7 @@ static int __block_write_full_page(struc
 
 	do {
 		get_bh(bh);
+		wait_on_buffer(bh);
 		if (buffer_mapped(bh) && buffer_dirty(bh)) {
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				lock_buffer(bh);

--=-NEHzzdBIvhWJ8IUPPqjo--

