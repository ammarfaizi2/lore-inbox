Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWFCBdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWFCBdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 21:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWFCBdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 21:33:53 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46209 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932590AbWFCBdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 21:33:52 -0400
Date: Fri, 2 Jun 2006 18:35:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linus Torvalds <torvalds@osdl.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH] sbp2: fix check of return value of hpsb_allocate_and_register_addrspace
Message-ID: <20060603013515.GV18769@moss.sous-sol.org>
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> I added a failure check in patch "sbp2: variable status FIFO address
> (fix login timeout)" --- alas for a wrong error value.  This is a bug
> since Linux 2.6.16.  Leads to NULL pointer dereference if the call
> failed, and bogus failure handling if call succeeded.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> ---
> applies to 2.6.17-rc5
> applies to 2.6.16.x after patch ''ohci1394, sbp2: fix "scsi_add_device
> failed" with PL-3507 based devices''
> 
> Index: linux-2.6.17-rc5/drivers/ieee1394/sbp2.c
> ===================================================================
> --- linux-2.6.17-rc5.orig/drivers/ieee1394/sbp2.c	2006-06-03 01:52:54.000000000 +0200
> +++ linux-2.6.17-rc5/drivers/ieee1394/sbp2.c	2006-06-03 01:54:23.000000000 +0200
> @@ -845,7 +845,7 @@ static struct scsi_id_instance_data *sbp
>  			&sbp2_highlevel, ud->ne->host, &sbp2_ops,
>  			sizeof(struct sbp2_status_block), sizeof(quadlet_t),
>  			0x010000000000ULL, CSR1212_ALL_SPACE_END);
> -	if (!scsi_id->status_fifo_addr) {
> +	if (scsi_id->status_fifo_addr == ~0ULL) {
>  		SBP2_ERR("failed to allocate status FIFO address range");
>  		goto failed_alloc;
>  	}
> 

Is that enough?

failed_alloc:
        sbp2_remove_device(scsi_id);

sbp2_remove_device(scsi_id)
  if (scsi_id->status_fifo_addr)
    hpsb_unregister_addrspace()

Suppose status_fifo_addr won't match any as->start.
