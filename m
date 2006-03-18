Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWCRWnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWCRWnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWCRWnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:43:35 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:27274 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750753AbWCRWnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:43:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l6nzDHC/P3sKQ9rGIQWX7CLqgQGI1IQfvneDHny7SNgevOtM9M3zqSXl2glwVbLoYS0jAxvARn8w46fVjO/kHTb3MXjq1RD1LPvXQQgLzu1aTEOny4koQo+o6QYCwKpSmxLRpIegjuPtHhCcjCbq5tpWLTv6crKWsrID4OUnDXc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] OSS: Fix leak in awe_wave, also remove pointless cast.
Date: Sat, 18 Mar 2006 23:43:11 +0100
User-Agent: KMail/1.9.1
Cc: Takashi Iwai <tiwai@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182343.11349.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix resource leak and remove pointless cast of kmalloc return value.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/awe_wave.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc6-orig/sound/oss/awe_wave.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc6/sound/oss/awe_wave.c	2006-03-18 23:39:19.000000000 +0100
@@ -2944,7 +2944,7 @@ alloc_new_info(void)
 {
 	awe_voice_list *newlist;
 	
-	newlist = (awe_voice_list *)kmalloc(sizeof(*newlist), GFP_KERNEL);
+	newlist = kmalloc(sizeof(*newlist), GFP_KERNEL);
 	if (newlist == NULL) {
 		printk(KERN_ERR "AWE32: can't alloc info table\n");
 		return NULL;
@@ -3547,8 +3547,10 @@ awe_load_guspatch(const char __user *add
 	smp->checksum_flag = 0;
 	smp->checksum = 0;
 
-	if ((rc = awe_write_wave_data(addr, sizeof_patch, smprec, -1)) < 0)
+	if ((rc = awe_write_wave_data(addr, sizeof_patch, smprec, -1)) < 0) {
+		kfree(vrec);
 		return rc;
+	}
 	sf->mem_ptr += rc;
 	add_sf_sample(sf, smprec);
 



