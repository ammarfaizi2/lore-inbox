Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVCaNYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVCaNYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVCaNYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:24:49 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:61356 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261436AbVCaNYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:24:48 -0500
Message-ID: <424BFA24.6040607@clusterfs.com>
Date: Thu, 31 Mar 2005 21:24:52 +0800
From: Niu YaWei <niu@clusterfs.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] possible bug in quota format v2 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

I'm afraid that there is a bug in quota format v2 delete qentry.
(The root block shouldn't be put into free blk list even if there isn't
any entry in quota file, right?)

This one line patch may fix it.

Thanks.

- Niu

--- linux-2.6.7/fs/quota_v2.c   2005-01-21 16:47:34.000000000 +0800
+++ linux-2.6.7-quota-v2/fs/quota_v2.c  2005-03-31 21:08:30.012641840 +0800
@@ -529,7 +529,8 @@ static int remove_tree(struct dquot *dqu
                int i;
                ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(0);
                for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++);  /* Block 
got empty? */
-               if (i == V2_DQBLKSIZE) {
+               /* don't put the root block into the free block list */
+               if (i == V2_DQBLKSIZE && *blk != V2_DQTREEOFF) {
                        put_free_dqblk(filp, dquot->dq_type, buf, *blk);
                        *blk = 0;
                }

