Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWJLR4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWJLR4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWJLR4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:56:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:60036 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1750730AbWJLR4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:56:39 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="130213312:sNHT26033063"
Date: Thu, 12 Oct 2006 10:55:36 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Judith Lebzelter <judith@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IA64 export symbols empty_zero_page, ia64_ssc
Message-ID: <20061012175536.GA8497@intel.com>
References: <617E1C2C70743745A92448908E030B2AA634B8@scsmsx411.amr.corp.intel.com> <20061012001139.1fea6ecf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012001139.1fea6ecf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 12:11:39AM -0700, Andrew Morton wrote:
> The problem is that ia64 allmodconfig now bombs out, since depmod treats
> this as a hard error.
> 
> IOW, please make allmodconfig work ;)

I tried simply swapping "tristate" for "bool":
--- a/arch/ia64/hp/sim/Kconfig	2006-10-12 10:45:18.000000000 -0700
+++ b/arch/ia64/hp/sim/Kconfig	2006-10-12 09:43:30.000000000 -0700
@@ -13,7 +13,7 @@
 	depends on HP_SIMSERIAL
 
 config HP_SIMSCSI
-	tristate "Simulated SCSI disk"
+	bool "Simulated SCSI disk"
 	depends on SCSI
 
 endmenu

... and now it fails in a new an diferent way:

  LD      .tmp_vmlinux1
arch/ia64/hp/sim/built-in.o(.init.text+0x9d2): In function `simscsi_init':
arch/ia64/hp/sim/simscsi.c:407: undefined reference to `scsi_host_alloc'
arch/ia64/hp/sim/built-in.o(.init.text+0xa02):arch/ia64/hp/sim/simscsi.c:411: undefined reference to `scsi_add_host'
arch/ia64/hp/sim/built-in.o(.init.text+0xa22):arch/ia64/hp/sim/simscsi.c:413: undefined reference to `scsi_scan_host'

presumably because we have CONFIG_HP_SIMSCSI=y but CONFIG_SCSI=m
[Which I don't understand ... HP_SIM_SCSI "depends on SCSI", so
 how did make allmodconfig come up with this combination?].


-Tony

P.S. Next layer of the onion is CONFIG_BLK_DEV_AMD74XX ... perhaps
that needs to be "depends on X86"?
