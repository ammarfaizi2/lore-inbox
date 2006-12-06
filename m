Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760239AbWLFGKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760239AbWLFGKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760243AbWLFGKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:10:53 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:42265 "HELO
	web31812.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760239AbWLFGKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:10:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=bWp/tJhxrulNGQvHXnv25v9u2NedEoVaOp2DrhgNJHIhDTXLDklkE6F4tzs0XkM04RcZ4jc+OeSHl2JwIWuGjfXMG10wxhMy6zRdWEDbu4r5p64VReHK/Q0o5jGRFv+MaJgloURcOG1vrCyVwUd+zvuc3bN1gVKFCEwbwtktuQs=;
X-YMail-OSG: GN2PRw8VM1kV0uF66o9pLyYqfx2hoZtEcQaalFZKQDy4iCuu8Wzj46B2G79k59ygFyuwFZEgk1YnSkGMgn8uxTArchNj3_aPoV9mOq.ZgFNEwecTx_VBYODZ5ke8mAkpzKbl_WHTTWH8C2jZmdKlZ7bbh6h5cw--
Date: Tue, 5 Dec 2006 22:10:47 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: Infinite retries reading the partition table
To: Andrew Morton <akpm@osdl.org>
Cc: mdr@sgi.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061205210853.e2661207.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <866416.88416.qm@web31812.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> > On Tue, 5 Dec 2006 21:00:20 -0800 (PST) Luben Tuikov <ltuikov@yahoo.com> wrote:
> > --- Michael Reed <mdr@sgi.com> wrote:
> > > Luben Tuikov wrote:
> > > ...snip...
> > > > This statement in scsi_io_completion() causes the infinite retry loop:
> > > >    if (scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
> > > >          return;
> > > 
> > > The code in 2.6.19 is "result==0", not "!!result", which is logically
> > > the same as "result!=0".  Did you mean to change the logic here?
> > > Am I missing something?
> > 
> > Hmm, I think my trees have !!result from an earlier patch I posted.
> > 
> > In this case it would appear that the second chunk of the patch
> > wouldn't be necessary, since result==0 would be false, and it
> > wouldn't retry.
> > 
> 
> I fixed things up.  The below is as-intended, yes?

Yes, thanks!

   Luben

> 
> 
> diff -puN drivers/scsi/scsi_error.c~fix-sense-key-medium-error-processing-and-retry
> drivers/scsi/scsi_error.c
> --- a/drivers/scsi/scsi_error.c~fix-sense-key-medium-error-processing-and-retry
> +++ a/drivers/scsi/scsi_error.c
> @@ -359,6 +359,11 @@ static int scsi_check_sense(struct scsi_
>  		return SUCCESS;
>  
>  	case MEDIUM_ERROR:
> +		if (sshdr.asc == 0x11 || /* UNRECOVERED READ ERR */
> +		    sshdr.asc == 0x13 || /* AMNF DATA FIELD */
> +		    sshdr.asc == 0x14) { /* RECORD NOT FOUND */
> +			return SUCCESS;
> +		}
>  		return NEEDS_RETRY;
>  
>  	case HARDWARE_ERROR:
> diff -puN drivers/scsi/scsi_lib.c~fix-sense-key-medium-error-processing-and-retry
> drivers/scsi/scsi_lib.c
> --- a/drivers/scsi/scsi_lib.c~fix-sense-key-medium-error-processing-and-retry
> +++ a/drivers/scsi/scsi_lib.c
> @@ -871,7 +871,8 @@ void scsi_io_completion(struct scsi_cmnd
>  	 * are leftovers and there is some kind of error
>  	 * (result != 0), retry the rest.
>  	 */
> -	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> +	if (good_bytes &&
> +	    scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
>  		return;
>  
>  	/* good_bytes = 0, or (inclusive) there were leftovers and
> _
> 
> 

