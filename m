Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274964AbTHAV5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274982AbTHAV5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:57:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:8404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274975AbTHAV4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:56:53 -0400
Date: Fri, 1 Aug 2003 14:44:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Diffie <diffie@blazebox.homeip.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-Id: <20030801144455.450d8e52.akpm@osdl.org>
In-Reply-To: <20030801182207.GA3759@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diffie <diffie@blazebox.homeip.net> wrote:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000120
> printing eip:
> c02a8cae
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c02a8cae>]    Not tainted VLI
> EFLAGS: 00210286
> EIP is at aic7xxx_proc_info+0x2e/0xc80
> eax: c1bb25b0   ebx: c1bb2400   ecx: c038bb20   edx: 00000000
> esi: 00000400   edi: f1715000   ebp: 412de000   esp: f620fecc
> ds: 007b   es: 007b   ss: 0068
> Process nautilus (pid: 3555, threadinfo=f620e000 task=f6216720)
> Stack: 000001f7 00000000 00000000 c013c612 c0379eb0 00000000 00000000 f6613340
>        00000000 00000000 c0379eb0 00000400 00000400 f1715000 412de000 c02956fc
>        c1bb2400 f1715000 f620ff60 00000000 00000400 00000000 c02956c0 c018bc91
> Call Trace:
> [<c013c612>] __alloc_pages+0x92/0x320
> [<c02956fc>] proc_scsi_read+0x3c/0x60
> [<c02956c0>] proc_scsi_read+0x0/0x60

This patch should fix the oops.

As for why the proc reading code was unable to locate the HBA: dunno, but
this is a first step.

Or maybe you don't have any adaptec controllers in the machine?

(jejb, please apply..)


 25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix drivers/scsi/aic7xxx_old/aic7xxx_proc.c
--- 25/drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix	Fri Aug  1 14:41:14 2003
+++ 25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c	Fri Aug  1 14:41:20 2003
@@ -92,7 +92,7 @@ aic7xxx_proc_info ( struct Scsi_Host *HB
 
   HBAptr = NULL;
 
-  for(p=first_aic7xxx; p->host != HBAptr; p=p->next)
+  for(p=first_aic7xxx; p && p->host != HBAptr; p=p->next)
     ;
 
   if (!p)

_

