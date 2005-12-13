Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVLMIYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVLMIYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVLMIYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:24:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:30851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932540AbVLMIYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:41 -0500
Date: Tue, 13 Dec 2005 00:23:59 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       mike.miller@hp.com, axboe@suse.de
Subject: [patch 25/26] cciss: bug fix for BIG_PASS_THRU
Message-ID: <20051213082359.GZ5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cciss-bug-fix-for-big_pass_thru.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jens Axboe <axboe@suse.de>

Applications using CCISS_BIG_PASSTHRU complained that the data written
was zeros. The problem is that the buffer is being cleared after the
user copy, unless the user copy has failed... Correct that logic.

Signed-off-by: Mike Miller <mike.miller@hp.com>
Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index e239a6c..33f8341 100644
---
 drivers/block/cciss.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.14.3.orig/drivers/block/cciss.c
+++ linux-2.6.14.3/drivers/block/cciss.c
@@ -1016,10 +1016,11 @@ static int cciss_ioctl(struct inode *ino
 				status = -ENOMEM;
 				goto cleanup1;
 			}
-			if (ioc->Request.Type.Direction == XFER_WRITE &&
-				copy_from_user(buff[sg_used], data_ptr, sz)) {
+			if (ioc->Request.Type.Direction == XFER_WRITE) {
+				if (copy_from_user(buff[sg_used], data_ptr, sz)) {
 					status = -ENOMEM;
-					goto cleanup1;			
+					goto cleanup1;
+				}
 			} else {
 				memset(buff[sg_used], 0, sz);
 			}

--
