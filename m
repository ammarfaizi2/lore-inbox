Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDCWEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDCWEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWDCWEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:04:07 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:25834 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750722AbWDCWEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:04:06 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 011 of 16] knfsd: svcrpc: WARN() instead of returning an error from svc_take_page
Date: Tue, 4 Apr 2006 00:02:21 +0200
User-Agent: KMail/1.9.1
References: <20060403151452.1567.patches@notabene> <1060403051901.1857@suse.de>
In-Reply-To: <1060403051901.1857@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604040002.22544.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 3. April 2006 07:19, you wrote:
> diff ./include/linux/sunrpc/svc.h~current~ ./include/linux/sunrpc/svc.h
> --- ./include/linux/sunrpc/svc.h~current~	2006-04-03 15:12:15.000000000 +1000
> +++ ./include/linux/sunrpc/svc.h	2006-04-03 15:12:15.000000000 +1000
> @@ -197,15 +197,13 @@ svc_take_res_page(struct svc_rqst *rqstp
>  	return rqstp->rq_respages[rqstp->rq_resused++];
>  }
>  
> -static inline int svc_take_page(struct svc_rqst *rqstp)
> +static inline void svc_take_page(struct svc_rqst *rqstp)
>  {
> -	if (rqstp->rq_arghi <= rqstp->rq_argused)
> -		return -ENOMEM;
> +	WARN_ON(rqstp->rq_arghi <= rqstp->rq_argused);
>  	rqstp->rq_arghi--;
>  	rqstp->rq_respages[rqstp->rq_resused] =
>  		rqstp->rq_argpages[rqstp->rq_arghi];
>  	rqstp->rq_resused++;
> -	return 0;
>  }

What will prevent underflow of ->rq_arghi and overflow of ->rq_resused here?

Before that change, this code would return without 
modifying both members here on error.

Now this code makes the error worse with each call.

Just ignore me, if this is ok :-)


Regards

Ingo Oeser
