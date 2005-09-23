Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVIWOpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVIWOpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVIWOpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:45:22 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:14853 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751015AbVIWOpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:45:22 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] open: O_DIRECTORY and O_CREAT together should fail
Message-Id: <E1EIonQ-0006Ts-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Sep 2005 16:45:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for O_DIRECTORY in the O_CREAT path, and return -EINVAL.

Current behavior is inconsistent with documentation: 
open(..., O_DIRECTORY|O_CREAT) succeeds if file didn't exist, and
returned descriptor does not refer to a directory.

No other error value quite fits this case: 

  ENOTDIR - the file doesn't exist, so this is slightly misleading
  ENOENT - yes, but we asked for an O_CREAT so why wasn't it created

But EINVAL - invalid combination of flags, is quite good IMO.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-09-23 16:35:32.000000000 +0200
+++ linux/fs/namei.c	2005-09-23 16:36:19.000000000 +0200
@@ -1441,6 +1441,9 @@ int open_namei(const char * pathname, in
 			return error;
 		goto ok;
 	}
+	/* O_CREAT | O_DIRECTORY should fail */
+	if (flag & O_DIRECTORY)
+		return -EINVAL;
 
 	/*
 	 * Create - we need to know the parent.
