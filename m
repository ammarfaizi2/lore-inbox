Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267110AbUBFAjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267111AbUBFAjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:39:43 -0500
Received: from ns.suse.de ([195.135.220.2]:4497 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267110AbUBFAjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:39:32 -0500
Subject: Bug in "select" dependency checking?
From: Andreas Gruenbacher <agruen@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1076027838.2223.95.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 06 Feb 2004 01:37:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think the dependency check in scripts/kconfig/symbol.c has a bug
related to "select", but possibly it's only a misunderstanding what
select is supposed to do. I have the following symbols and dependencies
(simplified):


  config NFS_ACL_SUPPORT
	tristate

  config NFSD
	tristate "..."
	select NFS_ACL_SUPPORT if NFSD_ACL	

  config NFSD_V3
	bool "..."
	depends on NFSD

  config NFSD_ACL
	bool "..."
	depends on NFSD_V3

  config NFS_FS
	tristate "..."
	select NFS_ACL_SUPPORT if NFS_ACL

  config NFS_V3
	bool "..."
	depends on NFS_FS

  config NFS_ACL
	bool "..."
	depends on NFS_V3


The intention of this is as follows: NFS_ACL_SUPPORT is a symbol without
menu entry. It activates an object which is either a module or linked
into the kernel. It is needed if NFSD_ACL is y or NFS_ACL is y. When it
is needed, it should have max(NFSD,NFS_FS).

With this configuration, menuconf gives me this message (among others):

  Warning! Found recursive dependency: NFSD_V3 NFSD_ACL NFSD NFSD_V3

In my understanding, the select statement does not cause a dependency of
NFSD on NFSD_ACL. I can write the same thing without selects as follows:

  config NFS_ACL_SUPPORT
        tristate
        default y if (NFSD=y || NFS_FS=y) && (NFSD_ACL || NFS_ACL)
        default m if (NFSD!=y && NFS_FS!=y) && (NFSD=m || NFS_FS=m) &&
		     (NFSD_ACL || NFS_ACL)

Any thoughts?


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

