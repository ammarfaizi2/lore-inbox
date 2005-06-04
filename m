Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVFDIWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVFDIWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 04:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFDIWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 04:22:37 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:8464 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261292AbVFDIWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 04:22:32 -0400
Date: Sat, 4 Jun 2005 16:12:29 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Jeff Moyer <jmoyer@redhat.com>, Michael Blandford <michael@kmaclub.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - bad lookup fix
Message-ID: <Pine.LNX.4.62.0506041543090.8502@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.1, required 8,
	NO_REAL_NAME, RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE,
	USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For browsable autofs maps, a mount request that arrives at the same time 
an expire is happening can fail to perform the needed mount.

This happens becuase the directory exists and so the revalidate succeeds 
when we need it to fail so that lookup is called on the same dentry to do 
the mount. Instead lookup is called on the next path component which 
should be whithin the mount, but the parent isn't mounted. 

The solution is to allow the revalidate to continue and perform the mount 
as no directory creation (at mount time) is needed for browsable mount 
entries.


diff -Nurp linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c linux-2.6.12-rc5-mm1/fs/autofs4/root.c
--- linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c	2005-05-29 14:46:30.000000000 +0800
+++ linux-2.6.12-rc5-mm1/fs/autofs4/root.c	2005-05-29 14:47:04.000000000 +0800
@@ -306,7 +306,14 @@ static int try_to_fill_dentry(struct den
 		
 		DPRINTK("expire done status=%d", status);
 		
-		return 0;
+		/*
+		 * If the directory still exists the mount request must
+		 * continue otherwise it can't be followed at the right
+		 * time during the walk.
+		 */
+		status = d_invalidate(dentry);
+		if (status != -EBUSY)
+			return 0;
 	}
 
 	DPRINTK("dentry=%p %.*s ino=%p",
