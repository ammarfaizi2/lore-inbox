Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWAZPtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWAZPtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWAZPtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:49:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41702 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932347AbWAZPtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:49:09 -0500
Date: Thu, 26 Jan 2006 07:48:46 -0800
From: Paul Jackson <pj@sgi.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-ia64@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com,
       ak@suse.de, len.brown@intel.com, discuss@x86-64.org
Subject: Re: [RFT/PATCH]Unify mapping from pxm to node id (take 2).
Message-Id: <20060126074846.1a6dd300.pj@sgi.com>
In-Reply-To: <20060123165644.C147.Y-GOTO@jp.fujitsu.com>
References: <20060120195733.1263.Y-GOTO@jp.fujitsu.com>
	<20060123165644.C147.Y-GOTO@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't work for arch/ia64/sn (probably not for ia64/hp either).

The final link fails:
---------------------
arch/ia64/sn/built-in.o(.init.text+0x1c90): In function `sn_setup':
arch/ia64/sn/kernel/setup.c:151: undefined reference to `nid_to_pxm_map'
arch/ia64/sn/built-in.o(.init.text+0x1c91):arch/ia64/sn/kernel/setup.c:155: undefined reference to `pxm_to_nid_map'
arch/ia64/sn/built-in.o(.init.text+0x1ca0):arch/ia64/sn/kernel/setup.c:151: undefined reference to `nid_to_pxm_map'
arch/ia64/sn/built-in.o(.init.text+0x1cb0):arch/ia64/sn/kernel/setup.c:155: undefined reference to `pxm_to_nid_map'

It looks like you removed the definitions of pxm_to_nid_map and nid_to_pxm_map,
but did not remove all the uses.  I recommend when removing global kernel
symbols that one grep all the kernel files for other uses.

A grep of the kernel (in Andrew's 2.6.16-rc1-mm3 quilt stack, just
after this patch and its first fix are applied) shows:

$ grep -rEIw pxm_to_nid_map\|nid_to_pxm_map * | grep -vE patches\|System.map
arch/i386/kernel/srat.c:        u8 nid_to_pxm_map[MAX_NUMNODES];/* logical node ID to _PXM map */
arch/ia64/hp/common/sba_iommu.c:        node = pxm_to_nid_map[pxm];
arch/ia64/sn/kernel/setup.c:    nid = pxm_to_nid_map[pxm];
arch/ia64/sn/kernel/setup.c:            nasid = pxm_to_nasid(nid_to_pxm_map[node]);
include/asm-ia64/acpi.h:extern int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
include/asm-ia64/acpi.h:extern int __initdata nid_to_pxm_map[MAX_NUMNODES];

>From the above, I presume that arch/ia64/hp is broken, along with
arch/ia64/sn.  And it looks like the nid_to_pxm_map[] in srat.c
is a waste of stack space, and the two remaining externs in
asm-ia64/acpi.h should be removed.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
