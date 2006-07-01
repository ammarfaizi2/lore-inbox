Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWGAN2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWGAN2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 09:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGAN2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 09:28:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:28544 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751228AbWGAN2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 09:28:23 -0400
From: Neil Brown <neilb@suse.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Date: Sat, 1 Jul 2006 23:28:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17574.30829.397932.205727@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Weird RAID/SATA problem [ once was Re: 2.6.17-mm3 ]
In-Reply-To: message from Reuben Farrelly on Sunday July 2
References: <20060630105401.2dc1d3f3.akpm@osdl.org>
	<44A5C1D5.20200@reub.net>
	<17573.50871.307879.557218@cse.unsw.edu.au>
	<44A5D079.6070505@reub.net>
	<17573.55937.866300.638738@cse.unsw.edu.au>
	<44A6390E.1030608@reub.net>
	<17574.15295.828980.278323@cse.unsw.edu.au>
	<44A64BD8.90906@reub.net>
	<17574.21399.979888.127483@cse.unsw.edu.au>
	<44A65EB7.5020201@reub.net>
	<17574.25837.681984.389682@cse.unsw.edu.au>
	<44A6696A.1010506@reub.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday July 2, reuben-lkml@reub.net wrote:
> BUG: warning at drivers/md/md.c:411/super_written_barrier()
> 
> Call Trace:
>   <IRQ> [<ffffffff80422231>] super_written_barrier+0x61/0x100
>   [<ffffffff8023c000>] bio_endio+0x5a/0x6a
>   [<ffffffff8022e24f>] __end_that_request_first+0x16f/0x4c9
>   [<ffffffff8024afaa>] end_that_request_first+0xc/0xe
>   [<ffffffff8034e825>] blk_ordered_complete_seq+0x7d/0x8c
>   [<ffffffff8034e864>] post_flush_end_io+0x30/0x35
>   [<ffffffff8034e748>] end_that_request_last+0xd8/0xf4
>   [<ffffffff803d83a1>] scsi_end_request+0xb1/0xdd
>   [<ffffffff803d87cd>] scsi_io_completion+0x3cd/0x3dc

I think the key decision to return an error is happening here in
scsi_io_completion. 
Pooring over a disassembly might help show here, but sticking in a
bunch of printks is probably easier (for someone like me who has never
seen this code before anyway :-)

What does this patch produce?

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>


diff .prev/drivers/scsi/scsi_lib.c ./drivers/scsi/scsi_lib.c
--- .prev/drivers/scsi/scsi_lib.c	2006-07-01 23:22:46.000000000 +1000
+++ ./drivers/scsi/scsi_lib.c	2006-07-01 23:26:18.000000000 +1000
@@ -952,6 +952,7 @@ void scsi_io_completion(struct scsi_cmnd
 				 * and quietly refuse further access.
 				 */
 				cmd->device->changed = 1;
+				printk("Unit Attention\n");
 				scsi_end_request(cmd, 0, this_count, 1);
 				return;
 			} else {
@@ -984,6 +985,8 @@ void scsi_io_completion(struct scsi_cmnd
 				scsi_requeue_command(q, cmd);
 				return;
 			} else {
+				printk("Illegal Request %d %d %d\n",
+				       sshdr.asc, sshdr.ascq, cmd->cmnd[0]);
 				scsi_end_request(cmd, 0, this_count, 1);
 				return;
 			}
@@ -1012,6 +1015,7 @@ void scsi_io_completion(struct scsi_cmnd
 					    "Device not ready: ");
 				scsi_print_sense_hdr("", &sshdr);
 			}
+			printk("Not ready\n");
 			scsi_end_request(cmd, 0, this_count, 1);
 			return;
 		case VOLUME_OVERFLOW:
@@ -1022,6 +1026,7 @@ void scsi_io_completion(struct scsi_cmnd
 				scsi_print_sense("", cmd);
 			}
 			/* See SSC3rXX or current. */
+			printk("Volume Overflow\n");
 			scsi_end_request(cmd, 0, this_count, 1);
 			return;
 		default:
@@ -1045,6 +1050,10 @@ void scsi_io_completion(struct scsi_cmnd
 				scsi_print_sense("", cmd);
 		}
 	}
+	printk("ouch. %d %d %d   %d %d %d  %d\n",
+	       good_bytes, sense_valid, sense_deferred,
+	       sshdr.sense_key, sshdr.asc, sshdr.ascq,
+	       result);
 	scsi_end_request(cmd, 0, this_count, !result);
 }
 EXPORT_SYMBOL(scsi_io_completion);
