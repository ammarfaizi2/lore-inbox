Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268212AbTALDgk>; Sat, 11 Jan 2003 22:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268214AbTALDgk>; Sat, 11 Jan 2003 22:36:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47265 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268212AbTALDgj>; Sat, 11 Jan 2003 22:36:39 -0500
Date: Sat, 11 Jan 2003 22:45:26 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301120345.h0C3jQl12220@devserv.devel.redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sd.c
In-Reply-To: <mailman.1042337402.13365.linux-kernel2news@redhat.com>
References: <mailman.1042337402.13365.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -809,9 +809,22 @@
>  		if (media_not_present(sdkp, SRpnt))
>  			return;
>  
> -		/* Look for devices that return NOT_READY.
> -		 * Issue command to spin up drive for these cases. */
> -		if (the_result && SRpnt->sr_sense_buffer[2] == NOT_READY) {
> +		if (the_result == 0)
> +			break;		/* all is well now */
> +
> +		/*
> +		 * If manual intervention is required, or this is an
> +		 * absent USB storage device, a spinup is meaningless.
> +		 */
> +		if (SRpnt->sr_sense_buffer[2] == NOT_READY &&
> +		    SRpnt->sr_sense_buffer[12] == 4 /* not ready */ &&
> +		    SRpnt->sr_sense_buffer[13] == 3)

Why is this not inside media_not_present?

> +/*
> + * sd_read_cache_type - called only from sd_init_onedisk()

Was it necessary to move and change sd_read_cache_type
simultaneously? Makes a joke of the diff.

> +	/* without media there is no reason to ask;
> +	   moreover, some devices react badly if we do */
> +	if (sdkp->media_present)
> +		sd_read_cache_type(sdkp, disk->disk_name, SRpnt, buffer);

Hmm... cautiously ok.

-- Pete
