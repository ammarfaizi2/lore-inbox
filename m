Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936294AbWLFQAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936294AbWLFQAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936279AbWLFQAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:00:00 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:35012 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936202AbWLFP76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:59:58 -0500
Subject: Re: Infinite retries reading the partition table
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ltuikov@yahoo.com, mdr@sgi.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061205210853.e2661207.akpm@osdl.org>
References: <4575D951.3010705@sgi.com>
	 <794609.32071.qm@web31811.mail.mud.yahoo.com>
	 <20061205210853.e2661207.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 09:59:47 -0600
Message-Id: <1165420788.2810.13.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 21:08 -0800, Andrew Morton wrote:
>  	case MEDIUM_ERROR:
> +		if (sshdr.asc == 0x11 || /* UNRECOVERED READ ERR */
> +		    sshdr.asc == 0x13 || /* AMNF DATA FIELD */
> +		    sshdr.asc == 0x14) { /* RECORD NOT FOUND */
> +			return SUCCESS;
> +		}
>  		return NEEDS_RETRY;

If the complaint is true; i.e. infinite retries, this is just a bandaid
not a fix.  What it's doing is marking the unrecoverable medium errors
for no retry.  However, what we really need to know is why NEEDS_RETRY
isn't terminating after its allotted number of retries.  Can we please
have a trace of this?
 
> -	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> +	if (good_bytes &&
> +	    scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
>  		return;

What exactly is this supposed to be doing?  its result is identical to
the code it's replacing (because of the way scsi_end_request() processes
its second argument), so it can't have any effect on the stated problem.

James


