Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUAVJ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUAVJ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:58:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:62855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266172AbUAVJ6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:58:24 -0500
Date: Thu, 22 Jan 2004 01:59:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oliver Kiddle <okiddle@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure
Message-Id: <20040122015905.7c16b86a.akpm@osdl.org>
In-Reply-To: <11370.1074763788@gmcs3.local>
References: <7641.1074512162@gmcs3.local>
	<20040119193837.6369d498.akpm@osdl.org>
	<30705.1074618514@gmcs3.local>
	<20040120183556.GE23765@srv-lnx2600.matchmail.com>
	<11370.1074763788@gmcs3.local>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Kiddle <okiddle@yahoo.co.uk> wrote:
>
> st0: Block limits 1 - 16777215 bytes.
>  xfsdump: page allocation failure. order:9, mode:0xd0
>  Call Trace:
>   [<c0132d18>] __alloc_pages+0x2db/0x319
>   [<c02a5dc9>] enlarge_buffer+0xcf/0x182
>   [<c02a6cd9>] st_map_user_pages+0x37/0x88
>   [<c02a2909>] setup_buffering+0xf3/0x127
>   [<c02a3690>] st_read+0xe0/0x3d1
>   [<c0147625>] vfs_read+0xb0/0x119
>   [<c01478a0>] sys_read+0x42/0x63
>   [<c0108ab7>] syscall_call+0x7/0xb

This one's actually somewhat OK.  The tape driver is simply trying to
allocate a huge buffer and is falling back if it fails.

This will shut up the debugging code:

--- 25/drivers/scsi/osst.c~osst-warning-fix	2004-01-22 01:57:35.000000000 -0800
+++ 25-akpm/drivers/scsi/osst.c	2004-01-22 01:57:59.000000000 -0800
@@ -5106,6 +5106,8 @@ static int enlarge_buffer(OSST_buffer *S
 	if (need_dma)
 		priority |= GFP_DMA;
 
+	priority |= __GFP_NOWARN;
+
 	/* Try to allocate the first segment up to OS_DATA_SIZE and the others
 	   big enough to reach the goal (code assumes no segments in place) */
 	for (b_size = OS_DATA_SIZE, order = OSST_FIRST_ORDER; b_size >= PAGE_SIZE; order--, b_size /= 2) {

_

