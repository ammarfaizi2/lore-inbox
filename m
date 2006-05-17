Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWEQWRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWEQWRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEQWQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:16:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6272 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751243AbWEQWQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:16:44 -0400
Message-Id: <20060517221359.723871000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/22] [PATCH] scx200_acb: Fix resource name use after free
Content-Disposition: inline; filename=scx200_acb-fix-resource-name-use-after-free.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

We can't pass a string on the stack to request_region. As soon as we
leave the function that stack is gone and the string is lost. Let's
use the same string we identify the i2c_adapter with instead, it's
more simple, more consistent, and just works.

This is the second half of fix to bug #6445.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/i2c/busses/scx200_acb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.16.16.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.16.16/drivers/i2c/busses/scx200_acb.c
@@ -440,7 +440,6 @@ static int  __init scx200_acb_create(int
 	struct scx200_acb_iface *iface;
 	struct i2c_adapter *adapter;
 	int rc = 0;
-	char description[64];
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 	if (!iface) {
@@ -459,8 +458,7 @@ static int  __init scx200_acb_create(int
 
 	init_MUTEX(&iface->sem);
 
-	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
-	if (request_region(base, 8, description) == 0) {
+	if (!request_region(base, 8, adapter->name)) {
 		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
 		rc = -EBUSY;

--
