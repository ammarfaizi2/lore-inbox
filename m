Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUGNTNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUGNTNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUGNTNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:13:11 -0400
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:42489 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265229AbUGNTLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:11:35 -0400
Message-ID: <40F58438.2040904@torque.net>
Date: Wed, 14 Jul 2004 15:06:32 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se> <40F562FC.50806@pobox.com> <20040714165419.GF7308@fs.tum.de> <200407141931.12249.bzolnier@elka.pw.edu.pl> <20040714183335.GG7308@fs.tum.de>
In-Reply-To: <20040714183335.GG7308@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Jul 14, 2004 at 07:31:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
>>FYI 'inlining fix' was just merged as part of viro's sparse cleanups
>>
>>I still would like somebody to comment on idea of converting sg.c
>>to use standard inlines from <linux/time.h> ...
> 
> 
> I've already discussed this with Doug a few days ago, and he agreed.
> 
> Below is my current patch against 2.6.8-rc1-mm1.
> 
> I'm not yet 100% sure whether it's correct, so please double-check it.

Adrian,
This patch looks fine.

Doug Gilbert

> 
> [patch] kill local sg_ms_to_jif/sg_jif_to_ms functions and use
>         msecs_to_jiffies/jiffies_to_msecs instead
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> --- linux-2.6.8-rc1-mm1-full-3.4/drivers/scsi/sg.c.old	2004-07-14 20:19:09.000000000 +0200
> +++ linux-2.6.8-rc1-mm1-full-3.4/drivers/scsi/sg.c	2004-07-14 20:21:50.000000000 +0200
> @@ -205,8 +205,6 @@
>  static Sg_request *sg_add_request(Sg_fd * sfp);
>  static int sg_remove_request(Sg_fd * sfp, Sg_request * srp);
>  static int sg_res_in_use(Sg_fd * sfp);
> -static int sg_ms_to_jif(unsigned int msecs);
> -static inline unsigned sg_jif_to_ms(int jifs);
>  static int sg_allow_access(unsigned char opcode, char dev_type);
>  static int sg_build_direct(Sg_request * srp, Sg_fd * sfp, int dxfer_len);
>  static Sg_device *sg_get_dev(int dev);
> @@ -612,7 +610,7 @@
>  			return -EBUSY;	/* reserve buffer already being used */
>  		}
>  	}
> -	timeout = sg_ms_to_jif(srp->header.timeout);
> +	timeout = msecs_to_jiffies(srp->header.timeout);
>  	if ((!hp->cmdp) || (hp->cmd_len < 6) || (hp->cmd_len > sizeof (cmnd))) {
>  		sg_remove_request(sfp, srp);
>  		return -EMSGSIZE;
> @@ -929,7 +927,7 @@
>  					    srp->header.driver_status;
>  					rinfo[val].duration =
>  					    srp->done ? srp->header.duration :
> -					    sg_jif_to_ms(
> +					    jiffies_to_msecs(
>  						jiffies - srp->header.duration);
>  					rinfo[val].orphan = srp->orphan;
>  					rinfo[val].sg_io_owned = srp->sg_io_owned;
> @@ -1251,7 +1249,7 @@
>  	srp->header.resid = SCpnt->resid;
>  	/* N.B. unit of duration changes here from jiffies to millisecs */
>  	srp->header.duration =
> -	    sg_jif_to_ms(jiffies - (int) srp->header.duration);
> +	    jiffies_to_msecs(jiffies - srp->header.duration);
>  	if (0 != SRpnt->sr_result) {
>  		memcpy(srp->sense_b, SRpnt->sr_sense_buffer,
>  		       sizeof (srp->sense_b));
> @@ -2575,30 +2573,6 @@
>  	free_pages((unsigned long) buff, order);
>  }
>  
> -static int
> -sg_ms_to_jif(unsigned int msecs)
> -{
> -	if ((UINT_MAX / 2U) < msecs)
> -		return INT_MAX;	/* special case, set largest possible */
> -	else
> -		return ((int) msecs <
> -			(INT_MAX / 1000)) ? (((int) msecs * HZ) / 1000)
> -		    : (((int) msecs / 1000) * HZ);
> -}
> -
> -static inline unsigned
> -sg_jif_to_ms(int jifs)
> -{
> -	if (jifs <= 0)
> -		return 0U;
> -	else {
> -		unsigned int j = (unsigned int) jifs;
> -		return (j <
> -			(UINT_MAX / 1000)) ? ((j * 1000) / HZ) : ((j / HZ) *
> -								  1000);
> -	}
> -}
> -
>  static unsigned char allow_ops[] = { TEST_UNIT_READY, REQUEST_SENSE,
>  	INQUIRY, READ_CAPACITY, READ_BUFFER, READ_6, READ_10, READ_12,
>  	MODE_SENSE, MODE_SENSE_10, LOG_SENSE
> @@ -2961,7 +2935,7 @@
>  	for (k = 0; (fp = sg_get_nth_sfp(sdp, k)); ++k) {
>  		seq_printf(s, "   FD(%d): timeout=%dms bufflen=%d "
>  			   "(res)sgat=%d low_dma=%d\n", k + 1,
> -			   sg_jif_to_ms(fp->timeout),
> +			   jiffies_to_msecs(fp->timeout),
>  			   fp->reserve.bufflen,
>  			   (int) fp->reserve.k_use_sg,
>  			   (int) fp->low_dma);
> @@ -2997,8 +2971,8 @@
>  				seq_printf(s, " dur=%d", hp->duration);
>  			else
>  				seq_printf(s, " t_o/elap=%d/%d",
> -				  new_interface ? hp->timeout : sg_jif_to_ms(fp->timeout),
> -				  sg_jif_to_ms(hp->duration ? (jiffies - hp->duration) : 0));
> +				  new_interface ? hp->timeout : jiffies_to_msecs(fp->timeout),
> +				  jiffies_to_msecs(hp->duration ? (jiffies - hp->duration) : 0));
>  			seq_printf(s, "ms sgat=%d op=0x%02x\n", usg,
>  				   (int) srp->data.cmd_opcode);
>  		}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

