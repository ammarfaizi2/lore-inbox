Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbREWGJX>; Wed, 23 May 2001 02:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbREWGJN>; Wed, 23 May 2001 02:09:13 -0400
Received: from acura.Stanford.EDU ([128.12.55.25]:29362 "EHLO acura")
	by vger.kernel.org with ESMTP id <S262015AbREWGJG>;
	Wed, 23 May 2001 02:09:06 -0400
Date: Tue, 22 May 2001 23:08:35 -0700
To: ncorbic@sangoma.com, dm@sangoma.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, su.class.cs99q@nntp.stanford.edu
Subject: [PATCH] net/wanrouter/wanproc.c
Message-ID: <20010522230835.A17714@acura.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Akash Jain <aki51@acura.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I am working with Dawson Engler's meta-compillation group @ Stanford.

In net/wanrouter/wanproc.c the authors check for a bad copy_to_user and
immediately return -EFAULT.  However, it is necessary to rollback some
allocated memory.  This can leak memory over time, thus leading to
system instability and lack of resources.

Thanks!
-Akash Jain

--- net/wanrouter/wanproc.c.orig	Thu Apr 12 12:11:39 2001
+++ net/wanrouter/wanproc.c	Thu May 17 12:52:05 2001
@@ -267,8 +267,10 @@
 		offs = file->f_pos;
 		if (offs < pos) {
 			len = min(pos - offs, count);
-			if(copy_to_user(buf, (page + offs), len))
-				return -EFAULT;
+			if(copy_to_user(buf, (page + offs), len)){
+			        kfree(page);
+			        return -EFAULT;
+			}
 			file->f_pos += len;
 		}
 		else

