Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbUCJOow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUCJOov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:44:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262624AbUCJOot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:44:49 -0500
Date: Wed, 10 Mar 2004 15:44:38 +0100
From: Heinz Mauelshagen <hjm@redhat.com>
To: marcelo.tosatti@cyclades.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][BUGFIX] : LVM1 Snapshots
Message-ID: <20040310144438.GE3065@redhat.com>
Reply-To: hjm@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

this patch fixes an LVM1 snapshot sector calculation causing a larger number
of pages in the call to expand_kiobuf() than needed, which causes snapshot
creates to fail on large memory systems and on ia64.

Please apply.

Regards,
Heinz    -- The LVM Guy --


--- linux-2.4.26-pre2/drivers/md/lvm-snap.c	2004-03-03 17:36:50.000000000 +0100
+++ linux-2.4.26-pre2/drivers/md/lvm-snap.c.orig	2004-03-03 17:36:02.000000000 +0100
@@ -554,15 +554,17 @@
 
 int lvm_snapshot_alloc(lv_t * lv_snap)
 {
-	int ret;
+	int ret, max_sectors;
 
 	/* allocate kiovec to do chunk io */
 	ret = alloc_kiovec(1, &lv_snap->lv_iobuf);
 	if (ret)
 		goto out;
 
-	ret = lvm_snapshot_alloc_iobuf_pages(lv_snap->lv_iobuf,
-					     KIO_MAX_SECTORS);
+	max_sectors = KIO_MAX_SECTORS << (PAGE_SHIFT - 9);
+
+	ret =
+	    lvm_snapshot_alloc_iobuf_pages(lv_snap->lv_iobuf, max_sectors);
 	if (ret)
 		goto out_free_kiovec;
 

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
