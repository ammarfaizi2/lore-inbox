Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVCYCDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVCYCDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 21:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVCYAsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:48:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54544 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261297AbVCYAPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:15:42 -0500
Date: Fri, 25 Mar 2005 01:15:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: urban@teststation.com
Cc: samba@samba.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/smbfs/request.c: fix NULL dereference
Message-ID: <20050325001540.GF3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found that if req was NULL because find_request 
returned NULL, this resulted in a break from the switch, but req was 
later dereferenced (look at the last line of this patch).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm2-full/fs/smbfs/request.c.old	2005-03-25 00:45:08.000000000 +0100
+++ linux-2.6.12-rc1-mm2-full/fs/smbfs/request.c	2005-03-25 00:47:14.000000000 +0100
@@ -783,20 +783,23 @@ int smb_request_recv(struct smb_sb_info 
 			break;
 		break;
 
 		/* We should never be called with any of these states */
 	case SMB_RECV_END:
 	case SMB_RECV_REQUEST:
 		server->rstate = SMB_RECV_END;
 		break;
 	}
 
+	if (!req)
+		return -ENOMEM;
+
 	if (result < 0) {
 		/* We saw an error */
 		return result;
 	}
 
 	if (server->rstate != SMB_RECV_END)
 		return 0;
 
 	result = 0;
 	if (req->rq_trans2_command && req->rq_rcls == SUCCESS)

