Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVLSTdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVLSTdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVLSTdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:33:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51258 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964893AbVLSTdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:33:38 -0500
Date: Mon, 19 Dec 2005 20:35:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <bcollins@ubuntu.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
Message-ID: <20051219193508.GL3734@suse.de>
References: <20051219153236.GA10905@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219153236.GA10905@swissdisk.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19 2005, Ben Collins wrote:
> Reference: https://bugzilla.ubuntu.com/5049
> 
> The eject command was failing for a large group of users for removable
> devices. The "eject -r" command, which uses the CDROMEJECT ioctl would not
> work, however "eject -s", which uses SG_IO did work, but required root access.
> 
> Since SG_IO was using the same mechanism as CDROMEJECT, there should be no
> difference. The main reason for getting the CDROMEJECT ioctl working was
> because it didn't need root privileges like the SG_IO commands did.
> 
> One bug was noticed, and that is CDROMEJECT was setting the blk request to a
> WRITE operation, when in fact it wasn't. The block layer did not like getting
> WRITE requests when data_len==0 and data==NULL.

False, it can't be a write request if there's no data attached. Write is
simply used there because read requests are usually more precious.

> This patch fixes the WRITE vs READ issue, and also sends the extra two
> commands. Anyone with an iPod connected via USB (not sure about firewire)
> should be able to reproduce this issue, and verify the patch.

The bug was in the SCSI layer, and James already has the fix integrated
for that. It really should make 2.6.15, James are you sending it upwards
for that?

>  		case CDROMEJECT:
> -			rq = blk_get_request(q, WRITE, __GFP_WAIT);
> -			rq->flags |= REQ_BLOCK_PC;
> -			rq->data = NULL;
> -			rq->data_len = 0;
> -			rq->timeout = BLK_DEFAULT_TIMEOUT;
> -			memset(rq->cmd, 0, sizeof(rq->cmd));
> -			rq->cmd[0] = GPCMD_START_STOP_UNIT;
> -			rq->cmd[4] = 0x02 + (close != 0);
> -			rq->cmd_len = 6;
> -			err = blk_execute_rq(q, bd_disk, rq, 0);
> -			blk_put_request(rq);
> +			err = 0;
> +
> +			err |= blk_send_allow_medium_removal(q, bd_disk);
> +			err |= blk_send_start_stop(q, bd_disk, 0x01);
> +			err |= blk_send_start_stop(q, bd_disk, 0x02);

Do this in the eject tool, if it's required for some devices.

-- 
Jens Axboe

