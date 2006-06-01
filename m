Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWFAWh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWFAWh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWFAWh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:37:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbWFAWh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:37:59 -0400
Date: Thu, 1 Jun 2006 15:40:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601154052.4dc2ac77.akpm@osdl.org>
In-Reply-To: <986ed62e0606011525g7e742c78s5358255dded7be0e@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
	<986ed62e0606011525g7e742c78s5358255dded7be0e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> wrote:
>
> On 6/1/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > Got a few build warnings with this one :
> 
> On the topic of build warnings, I got these (it's still building, and
> some of the earlier build output has gone past screen's scrollback
> buffer, so this might not be everything):
> 
> drivers/scsi/libsrp.c: In function 'srp_cmd_perform':
> drivers/scsi/libsrp.c:434: warning: implicit declaration of function
> 'scsi_host_get_command'
> drivers/scsi/libsrp.c:434: warning: assignment makes pointer from
> integer without a cast

Yes, I managed to lose a fix-up-the-rejects patch.  I wonder why it
compiled for me..

--- 25/include/scsi/scsi_cmnd.h~git-scsi-target-fixup	Thu Jun  1 15:38:27 2006
+++ 25-akpm/include/scsi/scsi_cmnd.h	Thu Jun  1 15:39:04 2006
@@ -150,11 +150,16 @@ struct scsi_cmnd {
 #define SCSI_STATE_MLQUEUE         0x100b
 
 
+extern struct scsi_cmnd *scsi_host_get_command(struct Scsi_Host *,
+					       enum dma_data_direction, gfp_t);
 extern struct scsi_cmnd *scsi_get_command(struct scsi_device *, gfp_t);
+extern void scsi_host_put_command(struct Scsi_Host *, struct scsi_cmnd *);
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
 extern void scsi_req_abort_cmd(struct scsi_cmnd *cmd);
+extern struct scatterlist *scsi_alloc_sgtable(struct scsi_cmnd *, gfp_t);
+extern void scsi_free_sgtable(struct scatterlist *, int);
 
 extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
 				 size_t *offset, size_t *len);
_


> ipc/msg.c: In function 'sys_msgctl':
> ipc/msg.c:338: warning: 'setbuf.qbytes' may be used uninitialized in
> this function
> ipc/msg.c:338: warning: 'setbuf.uid' may be used uninitialized in this function
> ipc/msg.c:338: warning: 'setbuf.gid' may be used uninitialized in this function
> ipc/msg.c:338: warning: 'setbuf.mode' may be used uninitialized in this function


Various false positives from gcc-4.
