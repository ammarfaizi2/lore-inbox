Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWH3Njd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWH3Njd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWH3Njd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:39:33 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:51133 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751034AbWH3Njc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:39:32 -0400
Subject: Re: [PATCH 3/3] stex: use block layer tagging
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Ed Lin <ed.lin@promise.com>
Cc: Jens Axboe <axboe@suse.de>, linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       promise_linux <promise_linux@promise.com>, jeff <jeff@garzik.org>
In-Reply-To: <NONAMEBfxRydC3hSsxL00000e3e@nonameb.ptu.promise.com>
References: <NONAMEBfxRydC3hSsxL00000e3e@nonameb.ptu.promise.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 09:39:17 -0400
Message-Id: <1156945158.3735.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 17:30 +0800, Ed Lin wrote:
> +stex_slave_alloc(struct scsi_device *sdev)
> +{
> +       struct st_hba *hba = (struct st_hba *) sdev->host->hostdata;
> +       unsigned long flags;
> +
> +       /*
> +        * this should be done in slave_configure routine. but we need
> +        * tagging ever since the first command. we can't wait...
> +        */
> +       spin_lock_irqsave(hba->host->host_lock, flags);
> +       if (hba->devnum++ == 0) {
> +               if (blk_queue_init_tags(sdev->request_queue,
> +                               hba->host->can_queue, NULL) == 0) {
> +                       hba->ref = 1;
> +                       hba->shared_queue = sdev->request_queue;
> +               }
> +       } else if (hba->ref) {
> +               blk_queue_init_tags(sdev->request_queue,
> +                       hba->host->can_queue,
> hba->shared_queue->queue_tags);
> +               hba->ref++;
> +       }
> +
> +       if (hba->ref) {
> +               sdev->tagged_supported = 1;
> +               scsi_set_tag_type(sdev, MSG_SIMPLE_TAG);
> +               scsi_adjust_queue_depth(sdev,
> +                       scsi_get_tag_type(sdev),
> hba->host->can_queue);
> +       } else
> +               sdev->tagged_supported = 0;
> +       spin_unlock_irqrestore(hba->host->host_lock, flags);

OK, this is indicating an inherent problem in using the shared tag maps.
I talked a bit with Jens and we think there's a way to eliminate most of
this and collapse it down to a simple SCSI helper.  I'll post the two
patches separately, but basically when its done your slave alloc should
become a simple scsi_activate_tcq().

James


