Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754073AbWKGGaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbWKGGaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbWKGGaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:30:21 -0500
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:31891 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1754073AbWKGGaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:30:20 -0500
Subject: [PATCH 0/1] mspec driver: compile error
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: jes@sgi.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 07 Nov 2006 15:30:17 +0900
Message-Id: <1162881017.13700.105.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jes,

After selecting CONFIG_MSPEC as a module I stumbled onto the compile
error below.

WARNING: "bte_copy" [drivers/char/mspec.ko] undefined!
WARNING: "physical_node_map" [drivers/char/mspec.ko] undefined!
WARNING: "uncached_free_page" [drivers/char/mspec.ko] undefined!
WARNING: "per_cpu____sn_hub_info" [drivers/char/mspec.ko] undefined!
WARNING: "uncached_alloc_page" [drivers/char/mspec.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

The problem is that the Kconfig dependencies for MSPEC are a bit too
loose. The mspec driver needs bte_copy (a sn-specific function) as well
as some functions of the uncached page allocator.

I solved the issue by making the dependencies explicit in
drivers/char/Kconfig:
--- Current Kconfig entry
config MSPEC
	tristate "Memory special operations driver"
	depends on IA64
	help
	  If you have an ia64 and you want to enable memory special
	  operations support (formerly known as fetchop), say Y here,
	  otherwise say N.
---
--- Proposed Kconfig entry
config MSPEC
        tristate "Memory special operations driver"
        depends on IA64 && (IA64_GENERIC || IA64_SGI_SN2)
        select IA64_UNCACHED_ALLOCATOR
        help
          If you have an ia64 and you want to enable memory special
          operations support (formerly known as fetchop), say Y here,
          otherwise say N.
---

I'll be replying to this message with a patch that implements this. I
would appreciate your review and comments.

Regards,

Fernando

