Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVKYTIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVKYTIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVKYTIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:08:06 -0500
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:15749 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750765AbVKYTIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:08:05 -0500
Date: Fri, 25 Nov 2005 17:10:56 -0200
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] ext3: Wrong return value for EXT3_IOC_GROUP_ADD  
Message-ID: <20051125191056.GB19410@br.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: glommer@br.ibm.com (Glauber de Oliveira Costa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch corrects the return value for the EXT3_IOC_GROUP_ADD in case
it fails due to the presence of multiple resizers at the filesystem. 

The problem is a little bit more serious than a wrong return value in 
this case, since the clause err=0 in the exit_journal path will lead to
a call to update_backups which in turns causes a NULL pointer
dereference.

Signed-off-by: Glauber de Oliveira Costa <glommer@br.ibm.com> 




--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-resize-return-value

--- linux-2.6.14.2-orig/fs/ext3/resize.c	2005-11-25 15:47:41.000000000 +0000
+++ linux-2.6.14.2-orig/fs/ext3/resize-ret.c	2005-11-25 15:49:20.000000000 +0000
@@ -757,6 +757,7 @@ int ext3_group_add(struct super_block *s
 	if (input->group != EXT3_SB(sb)->s_groups_count) {
 		ext3_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!\n");
+		err = -EBUSY;
 		goto exit_journal;
 	}
 

--AhhlLboLdkugWU4S--
