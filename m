Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266182AbUF3BaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUF3BaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 21:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUF3BaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 21:30:15 -0400
Received: from ozlabs.org ([203.10.76.45]:2001 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266182AbUF3BaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 21:30:07 -0400
Date: Wed, 30 Jun 2004 11:17:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linas@austin.ibm.com
Cc: paulus@au1.ibm.com, paulus@samba.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
Message-ID: <20040630011708.GG26251@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	linas@austin.ibm.com, paulus@au1.ibm.com, paulus@samba.org,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
References: <20040629175007.P21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629175007.P21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 05:50:07PM -0500, linas@austin.ibm.com wrote:
> 
> Paul,
> 
> Could you please apply the following path to the ameslab tree, and/or
> forward it to the main 2.6 kernel maintainers.
> 
> This patch moves the location of a lock in order to protect
> the contents of a buffer until it has been copied to its final
> destination. Prior to this, a race existed whereby the buffer
> could be filled even while it was being emptied.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>

Hmm... I note that log_error() does nothing but call ppc_md.log_error,
and I can't see anywhere that that is set to be non-NULL...

> +++ arch/ppc64/kernel/rtas.c	2004-06-29 17:14:05.000000000 -0500
> @@ -134,9 +134,10 @@ log_rtas_error(void)
> 
>  	spin_lock_irqsave(&rtas.lock, s);
>  	rc = __log_rtas_error();
> -	spin_unlock_irqrestore(&rtas.lock, s);
> -	if (rc == 0)
> +	if (rc == 0) {
>  		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
> +	}
> +	spin_unlock_irqrestore(&rtas.lock, s);
>  }
> 
>  int
> @@ -193,12 +194,13 @@ rtas_call(int token, int nargs, int nret
>  			outputs[i] = rtas_args->rets[i+1];
>  	ret = (int)((nret > 0) ? rtas_args->rets[0] : 0);
> 
> +	if (logit) {
> +		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
> +	}
> +
>  	/* Gotta do something different here, use global lock for now... */
>  	spin_unlock_irqrestore(&rtas.lock, s);
> 
> -	if (logit)
> -		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
> -
>  	return ret;
>  }
> 


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
