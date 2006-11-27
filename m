Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933676AbWK0V23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676AbWK0V23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933709AbWK0V23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:28:29 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:53972 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S933691AbWK0V22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:28:28 -0500
Date: Mon, 27 Nov 2006 23:28:18 +0200
From: Dan Aloni <da-x@monatomic.org>
To: linux-kernel@vger.kernel.org
Subject: aic94xx breaks with SATA drives that have medium errors
Message-ID: <20061127212818.GA8252@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-PopBeforeSMTPSenders: da-x@monatomic.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm currently testing the aic94xx driver from the latest git version of
Linux 2.6.19-rc generic x86_64 port merged with the aic94xx-sas-2.6 git,
on a Supermicro X7DB3 board.

It seems that the driver breaks badly when my SATA drives have medium
errors.

I deliberatly cause medium errors in order to test the error handling of
the driver coupled with the contoller.

Everything works okay until I perform a read I/O to the media-error-causing
location. Immediately I get:

aic94xx: escb_tasklet_complete: phy2: REQ_TASK_ABORT

But the I/O only returns to the SCSI layer after its full designated
timeout, instead of returning quickly with MEDIUM_ERROR.

After that particular I/O fails, every I/O to the driver will immediately
return as aborted. Unloading and loading the driver reverses the problem
but may crash the kernel not long after printing this:

Nov 28 02:13:58 pro210 kernel: aic94xx: Uh-oh! Pending is not empty!
Nov 28 02:13:58 pro210 kernel: aic94xx: freeing from pending
Nov 28 02:13:58 pro210 kernel: aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2 unloaded
Nov 28 02:14:01 pro210 kernel:
Nov 28 02:14:01 pro210 kernel: Call Trace:
Nov 28 02:14:01 pro210 kernel:  [<ffffffff80271313>] dump_trace+0xb3/0x450
Nov 28 02:14:01 pro210 kernel:  [<ffffffff802716f3>] show_trace+0x43/0x60
Nov 28 02:14:01 pro210 kernel:  [<ffffffff80271725>] dump_stack+0x15/0x20
Nov 28 02:14:01 pro210 kernel:  [<ffffffff802c5327>] kmem_cache_destroy+0xa7/0x110
Nov 28 02:14:01 pro210 kernel:  [<ffffffff8804f500>] :libsas:sas_class_exit+0x10/0x12
Nov 28 02:14:01 pro210 kernel:  [<ffffffff802a96a0>] sys_delete_module+0x220/0x280
Nov 28 02:14:01 pro210 kernel:  [<ffffffff8026411e>] system_call+0x7e/0x83
Nov 28 02:14:01 pro210 kernel:  [<00002b82def05959>]
Nov 28 02:14:01 pro210 kernel:
Nov 28 02:14:05 pro210 kernel: kmem_cache_create: duplicate cache sas_task
Nov 28 02:14:05 pro210 kernel:
Nov 28 02:14:05 pro210 kernel: Call Trace:
Nov 28 02:14:05 pro210 kernel:  [<ffffffff80271313>] dump_trace+0xb3/0x450
Nov 28 02:14:05 pro210 kernel:  [<ffffffff802716f3>] show_trace+0x43/0x60
Nov 28 02:14:05 pro210 kernel:  [<ffffffff80271725>] dump_stack+0x15/0x20
Nov 28 02:14:05 pro210 kernel:  [<ffffffff8023acf8>] kmem_cache_create+0x578/0x5c0
Nov 28 02:14:05 pro210 kernel:  [<ffffffff8803d022>] :libsas:sas_class_init+0x22/0x34
Nov 28 02:14:05 pro210 kernel:  [<ffffffff802ab7d6>] sys_init_module+0x1956/0x1ba0
Nov 28 02:14:05 pro210 kernel:  [<ffffffff8026411e>] system_call+0x7e/0x83
Nov 28 02:14:05 pro210 kernel:  [<00002aaabe27ea4c>]
Nov 28 02:14:05 pro210 kernel:


         - Dan
