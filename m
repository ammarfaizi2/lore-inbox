Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWJJRPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWJJRPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWJJRPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:15:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:48521 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964795AbWJJRPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:32 -0400
Date: Tue, 10 Oct 2006 10:14:55 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, akpm@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, Suparna Bhattacharya <suparna@in.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/19] ext3 sequential read regression fix
Message-ID: <20061010171455.GI6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ext3-sequential-read-regression-fix.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Badari Pulavarty <pbadari@us.ibm.com>

ext3-get-blocks support caused ~20% degrade in Sequential read
performance (tiobench). Problem is with marking the buffer boundary
so IO can be submitted right away. Here is the patch to fix it.

2.6.18-rc6:
-----------
# ./iotest
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB) copied, 75.2726 seconds, 57.1 MB/s

real    1m15.285s
user    0m0.276s
sys     0m3.884s


2.6.18-rc6 + fix:
-----------------
[root@elm3a241 ~]# ./iotest
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB) copied, 62.9356 seconds, 68.2 MB/s


The boundary block check in ext3_get_blocks_handle needs to be adjusted
against the count of blocks mapped in this call, now that it can map
more than one block.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Tested-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 fs/ext3/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.13.orig/fs/ext3/inode.c
+++ linux-2.6.17.13/fs/ext3/inode.c
@@ -926,7 +926,7 @@ int ext3_get_blocks_handle(handle_t *han
 	set_buffer_new(bh_result);
 got_it:
 	map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
-	if (blocks_to_boundary == 0)
+	if (count > blocks_to_boundary)
 		set_buffer_boundary(bh_result);
 	err = count;
 	/* Clean up and exit */

--
