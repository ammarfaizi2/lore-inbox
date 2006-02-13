Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWBMXNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWBMXNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWBMXNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:13:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030263AbWBMXNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:13:07 -0500
Date: Mon, 13 Feb 2006 15:12:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: jmoyer@redhat.com
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [patch] fix BUG: in fw_realloc_buffer
Message-Id: <20060213151205.3fe681ae.akpm@osdl.org>
In-Reply-To: <17393.3962.489843.651537@segfault.boston.redhat.com>
References: <17393.2242.720631.636489@segfault.boston.redhat.com>
	<20060213145231.0e8863e8.akpm@osdl.org>
	<17393.3962.489843.651537@segfault.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> wrote:
>
> akpm> A little bit neater this way, I think?
> 
> > --- devel/drivers/base/firmware_class.c~firmware-fix-bug-in-fw_realloc_buffer	2006-02-13 14:45:52.000000000 -0800
> > +++ devel-akpm/drivers/base/firmware_class.c	2006-02-13 14:52:05.000000000 -0800
> > @@ -211,18 +211,20 @@ static int
> >  fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
> >  {
> >  	u8 *new_data;
> > +	int new_size = fw_priv->alloc_size;
> 
> >  	if (min_size <= fw_priv->alloc_size)
> >  		return 0;
> 
> > -	new_data = vmalloc(fw_priv->alloc_size + PAGE_SIZE);
> > +	new_size = ALIGN(min_size, PAGE_SIZE);
> > +	new_data = vmalloc(new_size);
> >  	if (!new_data) {
> >  		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
> >  		/* Make sure that we don't keep incomplete data */
> >  		fw_load_abort(fw_priv);
> >  		return -ENOMEM;
> >  	}
> > -	fw_priv->alloc_size += PAGE_SIZE;
> > +	fw_priv->alloc_size = new_size;
> >  	if (fw_priv->fw->data) {
> >  		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
> >  		vfree(fw_priv->fw->data);
> > _
> 
> Well, I wasn't sure that you would only need to increase by a PAGE.  If you
> only need to account for page_size + alignment, then yes, this is better.
> It simply wasn't clear to me that this is how we are called.  If I'm not
> mistaken, this is the write routine for a file in sysfs.  If that is the
> case, why should we assume that writes are broken up into PAGE_SIZE chunks?
> 

hm?  The code's equivanent, I think.  ->alloc_size is always a multiple of
PAGE_SIZE and the ALIGN makes new_size the next multiple of PAGE_SIZE which
is >= min_size.

