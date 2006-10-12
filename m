Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWJLPTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWJLPTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWJLPTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:19:34 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:16914 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S932582AbWJLPTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:19:30 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk>
	<1160648885.5897.6.camel@Homer.simpson.net>
	<1160662435.6177.3.camel@Homer.simpson.net>
	<20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk>
Date: Thu, 12 Oct 2006 08:19:18 -0700
In-Reply-To: <20061012122146.GS6515@kernel.dk> (message from Jens Axboe on
	Thu, 12 Oct 2006 14:21:46 +0200)
Message-ID: <87odshr289.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> Mike/Alex/Olaf, can you give this a spin? Totally untested here, but I
> think it should fix it.
>
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 69bbb62..e7513e5 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -597,7 +597,7 @@ static void cdrom_prepare_request(ide_dr
>  	struct cdrom_info *cd = drive->driver_data;
>  
>  	ide_init_drive_cmd(rq);
> -	rq->cmd_type = REQ_TYPE_BLOCK_PC;
> +	rq->cmd_type = REQ_TYPE_ATA_PC;
>  	rq->rq_disk = cd->disk;
>  }
>  
> @@ -2023,7 +2023,8 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
>  		}
>  		info->last_block = block;
>  		return action;
> -	} else if (rq->cmd_type == REQ_TYPE_SENSE) {
> +	} else if (rq->cmd_type == REQ_TYPE_SENSE ||
> +		   rq->cmd_type == REQ_TYPE_ATA_PC) {
>  		return cdrom_do_packet_command(drive);
>  	} else if (blk_pc_request(rq)) {
>  		return cdrom_do_block_pc(drive, rq);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 26f7856..d370d2c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -157,6 +157,7 @@ enum rq_cmd_type_bits {
>  	REQ_TYPE_ATA_CMD,
>  	REQ_TYPE_ATA_TASK,
>  	REQ_TYPE_ATA_TASKFILE,
> +	REQ_TYPE_ATA_PC,
>  };
>  
>  /*
>

with this patch applied, i can read dvd's now (using mplayer). thanks.
i see this in syslog as the system boots up (it wasn't there before):

Uniform CD-ROM driver Revision: 3.20
ide-cd: bad rq: dev hdc: type=d, flags=1088

sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
ide-cd: bad rq: dev hdc: type=d, flags=1088

sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data dff1fe78, len 8
ide-cd: bad rq: dev hdc: type=d, flags=1088

sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data dfe5140c, len 4
ide-cd: bad rq: dev hdc: type=d, flags=1088

sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data dfe5140c, len 20
ide-cd: bad rq: dev hdc: type=d, flags=1088

sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data dff1fea8, len 12
ide-cd: bad rq: dev hdc: type=d, flags=1088

sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data dff1fe34, len 2
ide-cd: bad rq: dev hdc: type=d, flags=1088

sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data dff1fe34, len 2

spoke too soon. if i use xine i get this oops:

kernel: sector 0, nr/cnr 0/0
kernel: bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
kernel: ide-cd: bad rq: dev hdc: type=d, flags=88
kernel: 
kernel: sector 0, nr/cnr 0/0
kernel: bio 00000000, biotail 00000000, buffer 00000000, data d4e79b44, len 8
kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
kernel:  printing eip:
kernel: c0167de9
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: PREEMPT 
kernel: Modules linked in: radeon drm binfmt_misc nfs sd_mod scsi_mod nfsd exportfs lockd sunrpc autofs4 pcmcia firmware_class joydev irtty_sir sir_dev nsc_ircc irda crc_ccitt parport_pc parport ehci_hcd uhci_hcd usbcore aes_i586 airo nls_iso8859_1 ntfs yenta_socket rsrc_nonstatic pcmcia_core
kernel: CPU:    0
kernel: EIP:    0060:[<c0167de9>]    Not tainted VLI
kernel: EFLAGS: 00010292   (2.6.19-rc1 #202)
kernel: EIP is at create_empty_buffers+0x13/0x8d
kernel: eax: 00000000   ebx: c1276fe0   ecx: 00000001   edx: 00002000
kernel: esi: 00000000   edi: 00000000   ebp: c1276fe0   esp: d4e79cf4
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process xine (pid: 3767, ti=d4e78000 task=da77ea70 task.ti=d4e78000)
kernel: Stack: c1276fe0 00000000 c146dda0 c0169b20 c035c3d4 c016c134 00000001 c146dcfc 
kernel:        00000000 c035c3d4 000201d0 00002000 c1276fe0 00000000 fffffffa c1276fe0 
kernel:        c146dda0 00000000 00000000 c0134270 c1276fe0 c1276fe0 00000000 c146dda0 
kernel: Call Trace:
kernel:  [<c0169b20>] block_read_full_page+0x4d/0x248
kernel:  [<c016c134>] blkdev_get_block+0x0/0x33
kernel:  [<c0134270>] add_to_page_cache+0x99/0xb3
kernel:  [<c01397a8>] __do_page_cache_readahead+0x1b5/0x20e
kernel:  [<c0184267>] inode2sd+0x122/0x137
kernel:  [<c01935e8>] pathrelse+0x15/0x24
kernel:  [<c0184976>] reiserfs_update_sd_size+0x236/0x23e
kernel:  [<c0139847>] blockable_page_cache_readahead+0x46/0x99
kernel:  [<c01399d9>] page_cache_readahead+0xb2/0x177
kernel:  [<c01346b7>] do_generic_mapping_read+0x14b/0x436
kernel:  [<c01364e5>] generic_file_aio_read+0x1ac/0x1f7
kernel:  [<c0133eb9>] file_read_actor+0x0/0xc1
kernel:  [<c014c8bd>] do_sync_read+0xc2/0x101
kernel:  [<c0127389>] autoremove_wake_function+0x0/0x2d
kernel:  [<c014b7c1>] do_filp_open+0x2b/0x31
kernel:  [<c014c7fb>] do_sync_read+0x0/0x101
kernel:  [<c014d015>] vfs_read+0x81/0x123
kernel:  [<c014d3c0>] sys_read+0x3c/0x63
kernel:  [<c0102cbf>] syscall_call+0x7/0xb
kernel:  [<c02f007b>] __sched_text_start+0x123/0x560
kernel:  =======================
kernel: Code: 74 0a e8 1e ff ff ff e9 68 ff ff ff 31 f6 83 c4 0c 89 f0 5b 5e 5f 5d c3 57 89 cf 56 b9 01 00 00 00 53 89 c3 e8 3b ff ff ff 89 c6 <8b> 50 04 09 38 85 d2 74 04 89 d0 eb f3 89 70 04 b8 01 00 00 00 
kernel: EIP: [<c0167de9>] create_empty_buffers+0x13/0x8d SS:ESP 0068:d4e79cf4

not sure where this came from.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
