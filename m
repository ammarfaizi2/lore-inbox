Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUGNXgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUGNXgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUGNXgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:36:50 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:14989 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265102AbUGNXgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:36:48 -0400
Date: Thu, 15 Jul 2004 01:36:46 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: check_mnt() breaks namespaces
Message-ID: <20040714233646.GA25298@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew!

the check_mnt() in do_add_mount() breaks namespaces
in that way, that it forbids mounting single sb 
filesystems (like procfs) to be mounted in different
namespaces ...

I guess this is unintentional, but who knows ...
(this was introduced in 2.6.8-rc1, 2.6.7-bk20 works
as expected) 


something like this (untested) fixes? it ...

diff -NurpP --minimal linux-2.6.8-rc1/fs/namei.c linux-2.6.8-rc1-fix/fs/namei.c
--- linux-2.6.8-rc1/fs/namei.c  2004-07-12 14:47:08.000000000 +0200
+++ linux-2.6.8-rc1-fix/fs/namei.c        2004-07-12 14:59:08.000000000 +0200
@@ -794,7 +819,5 @@ int do_add_mount(struct vfsmount *newmnt
                ;
-       err = -EINVAL;
-       if (!check_mnt(nd->mnt))
-               goto unlock;

        /* Refuse the same filesystem on the same mount point */
        err = -EBUSY;

best,
Herbert

