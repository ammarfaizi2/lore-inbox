Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWC1KNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWC1KNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWC1KNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:13:34 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:11228 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932093AbWC1KNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:13:32 -0500
Date: Tue, 28 Mar 2006 19:12:35 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:000/004]Unify pxm_to_node id ver.3.
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060328183058.CC46.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I rewrote patches to unify mapping from pxm to node id as ver.3.

In previous patches, I moved MAX_PXM_DOMAINS into
include/acpi/acpi_numa.h to unify pxm_to_node mapping. 
Its max number was 256. 
However, ACPI spec ver.3 defines pxm's extension. So, pxm can be over 256.
256 was not enough for maximum of it, and u8 was not good for pxm's
definition.
In addition, SGI's SN2 already uses its extension in 2.6.16-git14,
and MAX_PXM_DOMAINS was defined by CONFIG_IA64_NR_NODES
in include/asm-ia64/acpi.h.
I defined CONFIG_NR_NODES for common definition.

This patches are for 2.6.16-git14.
I tested them on ia64(Tiger4) with node emulation.

And I confirmed no compile error against ....
  - x86-64
  - i386 with summit config.
  - ia64's SN2 config.

Please apply.

Thanks.

------------------------
Change log from ver.2
  - update for 2.6.16-git14.
  - definition of pxm was changed from u8 to int. Pxm can be over 256.
  - CONFIG_NR_NODES is defined to configure MAX_PXM_DOMAINS.
  - redundant call of pxm_bit_set() is removed at acpi_numa_arch_fixup()
    of ia64 like followings.  :-P
	if (pxm_bit_test(i)) {
		:
		pxm_bit_set(i);  <---------------------- !!!
		:
	}

Change log from ver.1 
  - Fix old map from HP and SGI's code by Bob Picco-san.
  - Remove MAX_PXM_DOMAINS from asm-ia64/acpi.h. It is already defined at
    include/acpi/acpi_numa.h.
  - Fix return code of setup_node() at arch/x86_64/mm/srat.c
  - Fix ACPI_NUMA config for i386 by Andy Witcroft-san.
  - Define dummy functions for i386's compile error.
  - Remove garbage nid_to_pxm_map from acpi20_parse_srat() 
    at arch/i386/kernel/srat.c

----------------------------------
Description.

This patch is to unify mapping from pxm to node id.
In current code, i386, x86-64, and ia64 have its mapping by each own code.
But PXM is defined by ACPI and node id is used generically. So,
I think there is no reason to define it on each arch's code.
This mapping should be written at drivers/acpi/numa.c as a common code.



-- 
Yasunori Goto 


