Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVCaJdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVCaJdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVCaJa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:30:57 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9476 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261262AbVCaJ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:27:34 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>, Yum Rayan <yum.rayan@gmail.com>
Subject: Re: [PATCH] Reduce stack usage in time.c
Date: Thu, 31 Mar 2005 12:26:58 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <df35dfeb05033023463a986df4@mail.gmail.com> <424BB443.1070508@pobox.com>
In-Reply-To: <424BB443.1070508@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311226.58037.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 11:26, Jeff Garzik wrote:
> Yum Rayan wrote:
> > Attempt to reduce stack usage in time.c (linux-2.6.12-rc1-mm3). Stack
> > usage was noted using checkstack.pl. Specifically:
> > 
> > Before patch
> > ------------
> > sys_adjtimex - 128
> > 
> > After patch
> > -----------
> > sys_adjtimex - none (register usage only)
> > 
> > Signed-off-by: Yum Rayan <yum.rayan@gmail.com>
> > 
> > --- a/kernel/time.c	2005-03-25 22:11:06.000000000 -0800
> > +++ b/kernel/time.c	2005-03-30 16:59:51.000000000 -0800
> > @@ -413,17 +413,27 @@
> >  
> >  asmlinkage long sys_adjtimex(struct timex __user *txc_p)
> >  {
> > -	struct timex txc;		/* Local copy of parameter */
> > -	int ret;
> > +	struct timex *txc;		/* Local copy of parameter */
> > +	int retval;
> > +
> > +	txc = kmalloc(sizeof(struct timex), GFP_KERNEL);
> > +	if (!txc)
> > +		return -ENOMEM;
> >  
> >  	/* Copy the user data space into the kernel copy
> >  	 * structure. But bear in mind that the structures
> >  	 * may change
> >  	 */
> > -	if(copy_from_user(&txc, txc_p, sizeof(struct timex)))
> > -		return -EFAULT;
> > -	ret = do_adjtimex(&txc);
> > -	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
> > +	if(copy_from_user(txc, txc_p, sizeof(struct timex))) {
> > +		retval = -EFAULT;
> > +		goto free_txc;
> > +	}
> > +	retval = do_adjtimex(txc);
> > +	if (copy_to_user(txc_p, txc, sizeof(struct timex)))
> > +		retval = -EFAULT;
> > +free_txc:

Is this a syscall?
Is it ever called from some deeply nested kernel function?
--
vda

