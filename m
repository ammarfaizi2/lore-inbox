Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272426AbTHAXXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 19:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274995AbTHAXXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 19:23:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:29929 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S272426AbTHAXXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 19:23:46 -0400
Date: Fri, 1 Aug 2003 16:27:22 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Diffie <diffie@blazebox.homeip.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030801232721.GA5249@beaverton.ibm.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Diffie <diffie@blazebox.homeip.net>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	James Bottomley <James.Bottomley@steeleye.com>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030801144455.450d8e52.akpm@osdl.org>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton [akpm@osdl.org] wrote:
> This patch should fix the oops.
> 
> As for why the proc reading code was unable to locate the HBA: dunno, but
> this is a first step.
> 
> Or maybe you don't have any adaptec controllers in the machine?
> 
> (jejb, please apply..)
> 
> 
>  25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix drivers/scsi/aic7xxx_old/aic7xxx_proc.c
> --- 25/drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix	Fri Aug  1 14:41:14 2003
> +++ 25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c	Fri Aug  1 14:41:20 2003
> @@ -92,7 +92,7 @@ aic7xxx_proc_info ( struct Scsi_Host *HB
>  
>    HBAptr = NULL;
>  
> -  for(p=first_aic7xxx; p->host != HBAptr; p=p->next)
> +  for(p=first_aic7xxx; p && p->host != HBAptr; p=p->next)
>      ;
>  
>    if (!p)

Is this really the right thing to add. The only purpose of these few lines
is a poor sanity check as down further in the code a pointer to the
structure is already present in hostdata. 

Adding the "p" is an indication that this drivers list got corrupted some
where.

I agree it may be better than an oops, but what else is invalid?

You need to have adaptec controllers in the system to get a procfs node
to read / write, but this error could be related to the node not getting
cleaned up correctly on a remove which a patch has previously been
posted.

-andmike
--
Michael Anderson
andmike@us.ibm.com

