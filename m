Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWH3TE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWH3TE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWH3TE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:04:56 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:15765 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751320AbWH3TEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:04:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KqkKuusgNqAVn1O6SKra0BmUUeyfCA7FH4VbAsaWuUQWHzQyHJQpu53VgwuVemD5LUJXxDqUVScid9sk+QB9eI32UWPG6lfYOVs/f6F7FOysIX+xuTCbMBrUEfdWowby9/ceTmsIjeZ6oqwpDr5XtXJbTfqEYwWTlLVcahcxmlM=  ;
Message-ID: <20060830190454.28371.qmail@web31807.mail.mud.yahoo.com>
Date: Wed, 30 Aug 2006 12:04:54 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] aic94xx: Increase can_queue and cmds_per_lun
To: "Darrick J. Wong" <djwong@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>,
       Konrad Rzeszutek <konrad@darnok.org>
In-Reply-To: <44F3CF6E.1070000@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> Below is a patch that sets cmd_per_lun and can_queue in the aic94xx
> driver's scsi_host_template to better performing values than what's
> there currently.  The cmd_per_lun setting is stolen straight out of the
> adp94xx source, and can_queue is derived from the max_scb value that we
> calculate in asd_init_hw.  To the best of my (admittedly limited)
> knowledge, this method provides the correct values (can_queue = 443 in
> both adp94xx and aic94xx on my 9405W) but if anybody knows better,
> please enlighten me. :)

Enlightenment is the last thing one gets in mailing lists, especially
linux-scsi.

> That said, the effect of leaving these values set to 1 is terrible
> performance in the case of either

When I submitted this code last year in this mailing list, none of these
values were set to 1.  Both cmd_per_lun and can_queue were/are set to the same
value, which is computed dynamically from the capabilities of the controller.

I've no idea who set "cmd_per_lun" to 1 and when.
I've no idea who set "can_queue" to anything other than what I
initilize it in my code as submitted last year.

> Just for grins, I ran bogodisk (an O_DIRECT-enabled read speed test)
> against three different scenarios:
> 
> 1) adp94xx 1.0.8-6, pounded into 2.6.18-rc4 [green]
> 2) aic94xx 1.0.2, without this patch        [red]
> 3) aic94xx 1.0.2, with this                 [blue]
> 
> ...with these results:
> 
> http://sweaglesw.net/~djwong/programs/bogodisk/bd_graphs/bad_sas.0.png

I just did some performance testing (of the code as I maintain it)
using your "bogodisk-0.5.2" and I get identical graph as your "green"
graph (but for different disk of course).

BTW, you need to print doubles as "%f" since using "%.2f" gives
me order of _four_ magnitude error, as opposed to order of -3
magnitude error when I use six decimal digits precision.

> As you can see, the read performance is cut in half by the aic94xx
> driver not getting a chance to have multiple I/Os in flight at any given 
> time.  With the patch, the two drivers are fairly close bandwidth-wise.
> Also thanks to Mike Anderson for helping me figure this out.

This is a very well known problem in existing storage tools/stacks
dealing with (powerful SCSI) LUs who implement queuing and or RAID.

> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.h b/drivers/scsi/aic94xx/aic94xx_hwi.h
> index c7d5053..a2d8881 100644
> --- a/drivers/scsi/aic94xx/aic94xx_hwi.h
> +++ b/drivers/scsi/aic94xx/aic94xx_hwi.h
> @@ -36,6 +36,9 @@
>  #include "aic94xx.h"
>  #include "aic94xx_sas.h"
>  
> +/* Leave a few empty data buffers. */
> +#define ASD_FREE_SCBS      3
> +

This should be dynamically computed.  Maybe you should
take a look at the original code I submitted.  I'm sure
Bottomley has it.

They are not "free scbs", and the comment leaves
much to be desired.

> --- a/drivers/scsi/aic94xx/aic94xx_init.c
> +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> @@ -71,7 +72,7 @@ static struct scsi_host_template aic94xx
>  	.change_queue_type	= sas_change_queue_type,
>  	.bios_param		= sas_bios_param,
>  	.can_queue		= 1,
> -	.cmd_per_lun		= 1,
> +	.cmd_per_lun		= 2,

Why 2?  Why not 3?  If you can set this to 3, then why not 4?
But if you can set it to 4, why not 5?

This value should also be dynamically set, it should depend on
the type of LU and it shouldn't be present in the host template.
(But that's an architectural argument which leads nowhere on lsml.)

Good luck!

