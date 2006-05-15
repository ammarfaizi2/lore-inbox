Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWEOUSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWEOUSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWEOUSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:18:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:11891 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965217AbWEOUSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:18:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QaRRG7bC1csxjCbYTPa+K2mpG6pwMuFlByEL5g7q8eJvEjUXlYpxvzCZWgMUmgm1VbTRDZ4jZ8C0TMykMpdWckIYSl6fSNK6TZgxcjQFmlMdnqAwxqK5Ai03YXEcMB6j1/Xz2i73cW6QES96vqGOwGgxWkYqCrpquaKuSfoOiaQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] fix potential NULL pointer dereference in yam
Date: Mon, 15 May 2006 22:19:36 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Frederic Rible <frible@teaser.fr>,
       Jean-Paul Roubelat <jpr@f6fbb.org>, linux-hams@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, Jesper Juhl <jesper.juhl@gmail.com>
References: <200605141512.50923.jesper.juhl@gmail.com> <20060514140946.GA23387@mipter.zuzino.mipt.ru>
In-Reply-To: <20060514140946.GA23387@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152219.37265.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 May 2006 16:09, Alexey Dobriyan wrote:
> On Sun, May 14, 2006 at 03:12:50PM +0200, Jesper Juhl wrote:
> > Testing a pointer for NULL after it has already been dereferenced is not
> > very safe.
> > Patch below to rework yam_open() so that `dev' is not dereferenced until
> > after it has been tested for NULL.
> 
> > Found by coverity checker as #787
> 
> > --- linux-2.6.17-rc4-git2-orig/drivers/net/hamradio/yam.c
> > +++ linux-2.6.17-rc4-git2/drivers/net/hamradio/yam.c
> > @@ -845,15 +845,25 @@ static struct net_device_stats *yam_get_
> >  
> >  static int yam_open(struct net_device *dev)
> >  {
> > -	struct yam_port *yp = netdev_priv(dev);
> > +	struct yam_port *yp;
> >  	enum uart u;
> >  	int i;
> > -	int ret=0;
> > +	int ret = 0;
> 
> Please, don't make unrelated changes.
> 
Sorry.


> > -	printk(KERN_INFO "Trying %s at iobase 0x%lx irq %u\n", dev->name, dev->base_addr, dev->irq);
> > +	if (!dev) {
> > +		printk(KERN_ERR "yam_open() called without device\n");
> > +		return -ENXIO;
> > +	}
> 
> How can it be NULL here? The whole array of valid net_devices was
> allocated at module init time.
> 

It cannot. You are right, I'm wrong.
I guess removing the check makes sense then ?


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

--- linux-2.6.17-rc4-mm1-orig/drivers/net/hamradio/yam.c	2006-05-13 21:28:27.000000000 +0200
+++ linux-2.6.17-rc4-mm1/drivers/net/hamradio/yam.c	2006-05-15 22:16:32.000000000 +0200
@@ -852,7 +852,7 @@ static int yam_open(struct net_device *d
 
 	printk(KERN_INFO "Trying %s at iobase 0x%lx irq %u\n", dev->name, dev->base_addr, dev->irq);
 
-	if (!dev || !yp->bitrate)
+	if (!yp->bitrate)
 		return -ENXIO;
 	if (!dev->base_addr || dev->base_addr > 0x1000 - YAM_EXTENT ||
 		dev->irq < 2 || dev->irq > 15) {


