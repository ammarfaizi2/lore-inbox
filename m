Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVARWnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVARWnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVARWnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:43:39 -0500
Received: from av7-1-sn4.m-sp.skanova.net ([81.228.10.110]:2713 "EHLO
	av7-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261456AbVARWnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:43:31 -0500
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix verify_command to allow burning more than 1 DVD
References: <41EC214D.6060607@stud.feec.vutbr.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Jan 2005 23:43:25 +0100
In-Reply-To: <41EC214D.6060607@stud.feec.vutbr.cz>
Message-ID: <m3k6qafjea.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt <xschmi00@stud.feec.vutbr.cz> writes:

> I use K3B with growisofs to burn DVDs. After boot I can burn a DVD as
> a normal user. But only the first one. When I want to burn another
> one, K3B complains that it is unable to prevent media removal. Then
> only root can burn DVDs.
> The bug is in the kernel in the function verify_command.
> When a process opens the DVD recorder with O_RDONLY and issues a
> command which is marked safe_for_write, this function is supposed to
> just return -EPERM and do nothing more. However, there is a bug that
> causes the command to be marked as CMD_WARNED. From now on no
> non-privileged process is able to issue this command even if it
> correctly opens the device with O_RDWR - because the command is no
> longer marked as CMD_WRITE_SAFE.
> A patch is attached.
> 
> Michal
> --- linux-2.6.11-mm1/drivers/block/scsi_ioctl.c.orig	2005-01-17 20:42:40.000000000 +0100
> +++ linux-2.6.11-mm1/drivers/block/scsi_ioctl.c	2005-01-17 20:43:14.000000000 +0100
> @@ -197,9 +197,7 @@ static int verify_command(struct file *f
>  	if (type & CMD_WRITE_SAFE) {
>  		if (file->f_mode & FMODE_WRITE)
>  			return 0;
> -	}
> -
> -	if (!(type & CMD_WARNED)) {
> +	} else if (!(type & CMD_WARNED)) {
>  		cmd_type[cmd[0]] = CMD_WARNED;
>  		printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
>  	}

That patch will not write the warning message in some cases. I think
this patch is better:

---

 linux-petero/drivers/block/scsi_ioctl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/scsi_ioctl.c~scsi-filter drivers/block/scsi_ioctl.c
--- linux/drivers/block/scsi_ioctl.c~scsi-filter	2005-01-18 23:38:37.966026728 +0100
+++ linux-petero/drivers/block/scsi_ioctl.c	2005-01-18 23:38:37.970026120 +0100
@@ -200,7 +200,7 @@ static int verify_command(struct file *f
 	}
 
 	if (!(type & CMD_WARNED)) {
-		cmd_type[cmd[0]] = CMD_WARNED;
+		cmd_type[cmd[0]] |= CMD_WARNED;
 		printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
 	}
 
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
