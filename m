Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVBBDGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVBBDGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVBBDF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:05:59 -0500
Received: from [211.58.254.17] ([211.58.254.17]:40330 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262242AbVBBC6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:58:12 -0500
Date: Wed, 2 Feb 2005 11:58:10 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 15/29] ide: flagged_taskfile() data byte order fix
Message-ID: <20050202025810.GP621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 15_ide_flagged_taskfile_data_byte_order_fix.patch
> 
> 	In flagged_taskfile(), when writing data register,
> 	taskfile->data goes to the lower byte and hobfile->data goes
> 	to the upper byte on little endian machines and the opposite
> 	happens on big endian machines.  This patch make
> 	taskfile->data always go to the lower byte regardless of
> 	endianess.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:03.518474705 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.093219204 +0900
@@ -823,7 +823,9 @@ ide_startstop_t flagged_taskfile (ide_dr
 
 	if (task->tf_out_flags.b.data) {
 		u16 data =  taskfile->data + (hobfile->data << 8);
-		hwif->OUTW(data, IDE_DATA_REG);
+		/* We want hobfile->data to go to the upper address,
+		   so the cpu_to_le16(). - tj */
+		hwif->OUTW(cpu_to_le16(data), IDE_DATA_REG);
 	}
 
 	/* (ks) send hob registers first */
