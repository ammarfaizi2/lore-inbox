Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUDCRK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 12:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUDCRKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 12:10:25 -0500
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:52609 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261551AbUDCRKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 12:10:15 -0500
Subject: Re: [PATCH] shrink inode when quota is disabled
From: Ray Lee <ray@madrabbit.org>
To: mpm@selenic.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1081012212.1505.71.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 03 Apr 2004 09:10:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>          struct address_space i_data; 
> +#ifdef CONFIG_QUOTA 
>          struct dquot *i_dquot[MAXQUOTAS]; 
> +#endif 
>          /* These three should probably be a union */ 
>          struct list_head i_devices; 
 
Forgive me if I'm asking a stupid question, but did this actually make a
difference in the inode size? On gcc 2.95 and 3.3, if MAXQUOTAS is zero,
gcc will silently elide that struct member. (Though it will leave a
residue of sorts behind -- it participates as far as structure field
alignment is concerned, but that isn't an issue here.) I believe
zero-length arrays are actually an ANSI C thing, but I didn't see it in
a quick perusal of my K&R.

Or, hmm... <does grep> Oh, MAXQUOTAS is set to 2 unconditionally in
include/linux/quota.h. How about putting the #ifdef's in there, and
setting it to zero if CONFIG_QUOTA is not set? That'd localize the
preprocessor noise.

Like this (compiled with CONFIG_QUOTA unset, but not booted):

Shrink struct inode by two pointers if CONFIG_QUOTA is unset.

diff -NurX ../dontdiff linus-2.6/include/linux/quota.h linus-2.6-inode-shrinkage/include/linux/quota.h
--- linus-2.6/include/linux/quota.h	2004-04-03 08:46:35.000000000 -0800
+++ linus-2.6-inode-shrinkage/include/linux/quota.h	2004-04-03 08:45:19.000000000 -0800
@@ -57,7 +57,11 @@
 #define kb2qb(x) ((x) >> (QUOTABLOCK_BITS-10))
 #define toqb(x) (((x) + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS)
 
+#ifdef CONFIG_QUOTA
 #define MAXQUOTAS 2
+#else
+#define MAXQUOTAS 0
+#endif
 
 #define USRQUOTA  0		/* element used for user quotas */
 #define GRPQUOTA  1		/* element used for group quotas */


--
Ray Lee  ~  http://madrabbit.org

