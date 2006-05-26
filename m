Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWEZFBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWEZFBt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 01:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWEZFBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 01:01:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:11203 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030438AbWEZFBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 01:01:47 -0400
Subject: [PATCH 0/2]Define ext3 in-kernel filesystem block types and extend
	ext3 filesystem limit from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 25 May 2006 22:00:53 -0700
Message-Id: <1148619653.5855.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the in-kernel ext3 block variable type are treated as signed 4 bytes
int type, thus limited ext3 filesystem to 8TB (4kblock size based). While
trying to fix them, it seems quite confusing in the ext3 code where some
blocks are filesystem-wide blocks, some are group relative offsets that need
to be signed value (as -1 has special meaning). So it seem saner to define two
types of physical blocks: one is filesystem wide blocks, another is
group-relative blocks.  The following patches clarify these two types of
blocks in the ext3 code, and fix the type bugs which limit current 32 bit ext3
filesystem limit to 8TB.

With this series of patches and the percpu counter data type changes in the mm
tree, we are able to extend exts filesystem limit to 16TB.

This work is also a pre-request for the recent >32 bit ext3 work, and makes
the kernel to able to address 48 bit ext3 block a lot easier: Simply
redefine ext3_fsblk_t from unsigned long to sector_t and redefine the format
string for ext3 filesystem block corresponding.

Two RFC with a series patches have been posted to ext2-devel list and have
been reviewed and discussed:
http://marc.theaimsgroup.com/?l=ext2-devel&m=114722190816690&w=2

http://marc.theaimsgroup.com/?l=ext2-devel&m=114784919525942&w=2

The following patches are updated and intergreated patches from two RFC posted
previous:

[Patch 1]ext3_fsblk_t, ext3_grpblk_t and type fixes.
	defines ext3_fsblk_t and ext3_grpblk_t, and the printk format string
	for filesystem wide blocks.
	
	This patch classifies all block group relative blocks, and
	ext3_fsblk_t blocks occurs in the same function where used to
	be confusing before. Also include kernel bug fixes for filesystem
	wide in-kernel block variables. There are some fileystem wide
	blocks are treated as int/unsigned int type in the kernel currently,
	especially in ext3 block allocation and reservation code. 
	This patch fixed those bugs by converting those variables to
	ext3_fsblk_t(unsigned long) type.

[Patch 2] Convert the ext3 in-kernel filesystem blocks to ext3_fsblk_t.
	Convert the rest of all unsigned long type in-kernel filesystem
	blocks to ext3_fsblk_t, and replace the printk format string
	respondingly.

Patches are tested on both 32 bit machine and 64 bit machine, <8TB ext3 and
>8TB ext3 filesystem(with the latest to be released e2fsprogs-1.39). Tests
 includes overnight fsx, tiobench, dbench and fsstress.

Patches are appliable
to 2.6.17-rc4-mm3, also applied to 2.6.17-rc4 kernel(need to apply percpu
counter changes to support >31 bit ext3 free blocks counters. 2.6.17-rc4
version of percpu cpu counter data type change patch could be found at:

http://ext2.sourceforge.net/48bitext3/patches/patches-2.6.17-rc4-05242006/percpu_counter_longlong.patch


Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


