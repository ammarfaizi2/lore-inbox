Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUKMViw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUKMViw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKMViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:38:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:2254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261180AbUKMVio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:38:44 -0500
Date: Sat, 13 Nov 2004 13:38:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-Id: <20041113133832.101db8d9.akpm@osdl.org>
In-Reply-To: <41967669.3070707@aknet.ru>
References: <41967669.3070707@aknet.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> Hi.
> 
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/
> Here are the few new problems that
> I've got:
> 
> 1. Local APIC stopped working. I know
> ...
> 2. Radeon DRM driver stopped working.
> ...
> like an Oops in kprobes:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0411.1/0895.html

OK, I've passed these over to people who might be able to fix them.

> (there is also a test-case)
> and the memory corruption in smbfs:
> http://marc.free.net.ph/message/20041027.000343.74f4a932.html
> 

Here's a random hack for smbfs.  Does it help?

diff -puN fs/smbfs/request.c~smbfs-hack fs/smbfs/request.c
--- 25/fs/smbfs/request.c~smbfs-hack	2004-11-13 13:36:28.158722944 -0800
+++ 25-akpm/fs/smbfs/request.c	2004-11-13 13:37:20.721732152 -0800
@@ -279,6 +279,7 @@ int smb_add_request(struct smb_request *
 	long timeleft;
 	struct smb_sb_info *server = req->rq_server;
 	int result = 0;
+	int need_put = 0;
 
 	smb_setup_request(req);
 	if (req->rq_trans2_command) {
@@ -343,7 +344,7 @@ int smb_add_request(struct smb_request *
 		smb_lock_server(server);
 		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
 			list_del_init(&req->rq_queue);
-			smb_rput(req);
+			need_put = 1;
 		}
 		smb_unlock_server(server);
 	}
@@ -372,6 +373,8 @@ int smb_add_request(struct smb_request *
 		req->rq_errno = smb_errno(req);
 	if (signal_pending(current))
 		req->rq_errno = -ERESTARTSYS;
+	if (need_put)
+		smb_rput(req);
 	return req->rq_errno;
 }
 
_

