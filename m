Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVAYTPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVAYTPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVAYTOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:14:49 -0500
Received: from mailfe07.swip.net ([212.247.154.193]:7573 "EHLO
	mailfe07.swip.net") by vger.kernel.org with ESMTP id S262067AbVAYTML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:12:11 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: Kernel 2.6.11-rc1/2 goes Postal on LTP
From: Alexander Nyberg <alexn@dsv.su.se>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Bryce Harrington <bryce@osdl.org>, Chris Wright <chrisw@osdl.org>,
       dev@osdl.org, linux-kernel@vger.kernel.org,
       stp-devel@lists.sourceforge.net
In-Reply-To: <41F46B32.9070904@osdl.org>
References: <Pine.LNX.4.33.0501221125140.30167-100000@osdlab.pdx.osdl.net>
	 <41F46B32.9070904@osdl.org>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 20:12:01 +0100
Message-Id: <1106680321.705.52.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Similar for me, easy to reproduce (3 times today).
> Here's a kernel messages log, with 32 processes killed,
> mostly hotplug, but also bash (2x), runltp, & some daemons.
> 
> I could not login and do anything else, but I could/did
> SysRq-T, P, M, S, U, B to reboot.  These are also in the log.
> 
> log:
> http://developer.osdl.org/rddunlap/oom/oom_kill.txt
> 
> config:
> http://developer.osdl.org/rddunlap/oom/config-2611rc2
> 
> on P4-UP, 1 GB RAM.
> 

I saw this aswell. Appears to be the pipe leak cause it doesn't go nuts
with the patch at the bottom from Linus.


> 
> Would indicate that the new pipe code is leaking.

Duh. It's the pipe merging.

		Linus

----
--- 1.40/fs/pipe.c	2005-01-15 12:01:16 -08:00
+++ edited/fs/pipe.c	2005-01-24 14:35:09 -08:00
@@ -630,13 +630,13 @@
 	struct pipe_inode_info *info = inode->i_pipe;
 
 	inode->i_pipe = NULL;
-	if (info->tmp_page)
-		__free_page(info->tmp_page);
 	for (i = 0; i < PIPE_BUFFERS; i++) {
 		struct pipe_buffer *buf = info->bufs + i;
 		if (buf->ops)
 			buf->ops->release(info, buf);
 	}
+	if (info->tmp_page)
+		__free_page(info->tmp_page);
 	kfree(info);
 }
 


