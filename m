Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbVIPNls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbVIPNls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 09:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbVIPNls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 09:41:48 -0400
Received: from main.gmane.org ([80.91.229.2]:36811 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161089AbVIPNls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 09:41:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: aoe fails on sparc64
Date: Fri, 16 Sep 2005 09:36:51 -0400
Message-ID: <87u0glxhfw.fsf@coraid.com>
References: <3afbacad0508310630797f397d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
Cc: Jim MacBaine <jmacbaine@gmail.com>,
       "David S. Miller" <davem@davemloft.net>
X-Gmane-NNTP-Posting-Host: adsl-19-26-13.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:eT+9K5ntGz5eCG0SVT9fjgt0Gok=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Jim MacBaine <jmacbaine@gmail.com> writes:

> Hello,
>
> Using aoe on a sparc64 system gives strange results:
>
> sunny:/dev/etherd# echo >discover
> sunny:/dev/etherd# mke2fs e0.0
> mke2fs 1.37 (21-Mar-2005)
> mke2fs: File too large while trying to determine filesystem size
> sunny:/dev/etherd# blockdev --getsz e0.0
> -4503599627370496
>
> The log says:
>
> Aug 31 15:18:49 sunny kernel: devfs_mk_dir: invalid argument.<6>
> etherd/e0.0: unknown partition table
> Aug 31 15:18:49 sunny kernel: aoe: 0011d8xxxxxx e0.0 v4000 has
> 67553994410557440
> sectors
>
> The system is an Sun Ultra 5, running 2.6.12.5/sparc64 compiled with
> gcc-3.4.2.  e0.0 is exported on a x86 system using vblade-5, and has a
> size of 30 MB.

I've been working with Jim MacBaine, and he reports that the patch
below gets rid of the problem.  I don't know why.  When I test
le64_to_cpup by itself, it works as expected.


--=-=-=
Content-Disposition: inline; filename=diff

Index: linux-2.6.13/drivers/block/aoe/aoecmd.c
===================================================================
--- linux-2.6.13.orig/drivers/block/aoe/aoecmd.c	2005-08-31 17:03:52.000000000 -0400
+++ linux-2.6.13/drivers/block/aoe/aoecmd.c	2005-09-15 15:44:41.000000000 -0400
@@ -320,7 +320,8 @@
 		d->flags |= DEVFL_EXT;
 
 		/* word 100: number lba48 sectors */
-		ssize = le64_to_cpup((__le64 *) &id[100<<1]);
+		ssize = *((u64 *) &id[100<<1]);
+		ssize = le64_to_cpu(ssize);
 
 		/* set as in ide-disk.c:init_idedisk_capacity */
 		d->geo.cylinders = ssize;

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

