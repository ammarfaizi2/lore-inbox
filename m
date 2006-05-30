Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWE3VRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWE3VRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWE3VRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:17:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:52391 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932481AbWE3VRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:17:03 -0400
X-Authenticated: #704063
Subject: [Patch] NULL pointer dereference in
	drivers/message/i2o/i2o_config.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: markus.lidel@shadowconnect.com
Content-Type: text/plain
Date: Tue, 30 May 2006 23:17:02 +0200
Message-Id: <1149023822.30594.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i am not sure if there is some black magic which prevents this
from happening, it is spotted by coverity id #265

499  		for (p = open_files; p; p = p->next)
500  			if (p->q_id == (ulong) fp->private_data)
501  				break;
502  	
503  		if (!p->q_len)
504  			return -ENOENT

if we cant find a p with a p->q_id which matches fp->private data,
we dereference it.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.17-rc4-git2/drivers/message/i2o/i2o_config.c.orig	2006-05-30 23:12:13.000000000 +0200
+++ linux-2.6.17-rc4-git2/drivers/message/i2o/i2o_config.c	2006-05-30 23:13:30.000000000 +0200
@@ -500,7 +500,7 @@ static int i2o_cfg_evt_get(unsigned long
 		if (p->q_id == (ulong) fp->private_data)
 			break;
 
-	if (!p->q_len)
+	if (!p || !p->q_len)
 		return -ENOENT;
 
 	memcpy(&kget.info, &p->event_q[p->q_out], sizeof(struct i2o_evt_info));


