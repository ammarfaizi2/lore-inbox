Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310560AbSCVAFT>; Thu, 21 Mar 2002 19:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310538AbSCVAFK>; Thu, 21 Mar 2002 19:05:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:45355 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S310546AbSCVAE6>; Thu, 21 Mar 2002 19:04:58 -0500
Date: Thu, 21 Mar 2002 19:04:51 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2 questions about SCSI initialization
Message-ID: <20020321190451.A1054@devserv.devel.redhat.com>
In-Reply-To: <20020321000553.A6704@devserv.devel.redhat.com> <20020321142635.A6555@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 21 Mar 2002 14:26:35 -0800
> From: Patrick Mansfield <patmans@us.ibm.com>

> > #2: What does  if (GET_USE_COUNT(tpnt->module) != 0)  do in
> > scsi_unregister_device? The circomstances are truly bizzare:
> > a) the error code is NEVER used
> > b) it can be called either from module unload.
> > I would like to kill that check.

>[...]
> If the count is really non zero, the function should not be called
> (rmmod won't call into it if the module is in use; if calling via
> scsi_register_device_module on failure, it should be impossible
> to increment count - it should be impossible to call sd_open or
> sg_open).

The last line of reasoning is faulty, because sys_init_module()
does  atomic_set(&mod->uc.usecount,1); before calling init_sg()
or init_sd(). Thus, it's not only possible, but it is guaranteed
that the counter is non-zero when control gets
to scsi_register_device_module, and to the failure path.

> --- scsi.c.orig	Thu Mar 21 13:51:27 2002
> +++ scsi.c	Thu Mar 21 13:52:54 2002
> @@ -2331,8 +2331,8 @@
>  	/*
>  	 * If we are busy, this is not going to fly.
>  	 */
> -	if (GET_USE_COUNT(tpnt->module) != 0)
> -		goto error_out;
> +	if (tpnt->module && (GET_USE_COUNT(tpnt->module) != 0))
> +		BUG();

Guaranteed to trigger BUG() is out_of_memory gets set.

I still think we better kill this check altogether.
Any more objections?

-- Pete
