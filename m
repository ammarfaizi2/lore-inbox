Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbVKIKhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbVKIKhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVKIKhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:37:05 -0500
Received: from poup.poupinou.org ([195.101.94.96]:19750 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1030491AbVKIKhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:37:03 -0500
Date: Wed, 9 Nov 2005 11:37:01 +0100
To: linux-kernel@vger.kernel.org
Cc: Bruno Ducrot <ducrot@poupinou.org>
Subject: [AMD64] Possible bug in fs/read_write.c::rw_verify_area
Message-ID: <20051109103701.GA8491@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Bruno Ducrot <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

fs/read_write.c::rw_verify_area check if the count for a read/write is
valid.  Unfortunately, this check assume that a size_t is an int, which
is wrong at least on AMD64 architecture.

This fix is not correct also in general: it is wrong to assume
that size_t is a long int.  A correct fix would be to introduce
a new constant (say SSIZE_MAX) for each supported architecture
and to use that contstant instead.  I'm not an expert on this and
it is why I don't do it (sorry).  But at least the following patch
is ok for more achitecture, I believe.

Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>

--- linux-2.6.14/fs/read_write.c	2005/11/09 10:19:04	1.1
+++ linux-2.6.14/fs/read_write.c	2005/11/09 10:19:40
@@ -188,7 +188,7 @@ int rw_verify_area(int read_write, struc
 	struct inode *inode;
 	loff_t pos;
 
-	if (unlikely(count > INT_MAX))
+	if (unlikely(count > LONG_MAX))
 		goto Einval;
 	pos = *ppos;
 	if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
