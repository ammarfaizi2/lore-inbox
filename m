Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVARWoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVARWoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVARWoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:44:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31430 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261459AbVARWo3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:44:29 -0500
Subject: Re: [PATCH 1/1] tpm: fix cause of SMP stack traces
From: Kylene Hall <kjhall@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       Emily Ratliff <emilyr@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20050118143705.F469@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
	 <29495f1d041221085144b08901@mail.gmail.com>
	 <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
	 <20050118143705.F469@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1106088256.2324.14.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 18 Jan 2005 16:44:16 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 16:37, Chris Wright wrote:
> * Kylene Hall (kjhall@us.ibm.com) wrote:
> > There were misplaced spinlock acquires and releases in the probe, open, 
> > close and release paths which were causing might_sleep and schedule while 
> > atomic error messages accompanied by stack traces when the kernel was 
> > compiled with SMP support. Bug reported by Reben Jenster 
> > <ruben@hotheads.de>
> > 
> > Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> > ---
> > diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
> > --- linux-2.6.10/drivers/char/tpm/tpm.c	2005-01-18 16:42:17.000000000 -0600
> > +++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-01-18 12:52:53.000000000 -0600
> > @@ -373,8 +372,9 @@ int tpm_open(struct inode *inode, struct
> >  {
> >  	int rc = 0, minor = iminor(inode);
> >  	struct tpm_chip *chip = NULL, *pos;
> > +	unsigned long flags;
> >  
> > -	spin_lock(&driver_lock);
> > +	spin_lock_irqsave(&driver_lock, flags);
> 
> Hmm, unless I'm missing something, this is only worse (for might sleep
> warnings).  Now you've disabled irq's too.

I actually had to move the location of some of the locks to remove the
might sleep warnings.  Since I didn't know much about the might sleep
warnings before, my first course of action was to try using the disable
irq mechanism and I went ahead and just left them in once it was working
with the new lock placements.  I assume you believe they shouldn't be
necessary at all?

Thanks,
Kylie   

> 
> thanks,
> -chris

