Return-Path: <linux-kernel-owner+w=401wt.eu-S1161136AbXALXNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbXALXNV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbXALXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:13:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:16672 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161136AbXALXNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:13:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=rSEpGuJv0opkbWSSZblyMGArwVz0fWjlRx9rBCZWaIyUjtwd4JXjy9imOxTtnGi0s6BatD3OXYKnLLznlQAySrduG5Ngo8GV24co8P4iUm9ZjremRJT9JbyL6G9lJKjS3zI4ex07r5hLM0mnILrP7fXIsrgmqRHf4vJYWmHwIJE=
Date: Fri, 12 Jan 2007 23:10:15 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rui.zhang@intel.com, michal.k.k.piotrowski@gmail.com
Subject: Re: Early ACPI lockup (was Re: 2.6.20-rc4-mm1)
Message-ID: <20070112231015.GI5941@slug>
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070112102040.GD5941@slug> <200701121753.08710.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701121753.08710.lenb@kernel.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 05:53:08PM -0500, Len Brown wrote:
> On Friday 12 January 2007 05:20, Frederik Deweerdt wrote:
> > On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> > > 
> > >   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/
> > > 
> > Hi,
> > 
> > The git-acpi.patch replaces earlier "if(!handler) return -EINVAL" by
> > "BUG_ON(!handler)". This locks my machine early at boot with a message
> > along the lines of (It's hand copied):
> > Int 6: cr2: 00000000 eip: c0570e05 flags: 00010046 cs: 60
> > stack: c054ffac c011db2b c04936d0 c054ff68 c054ffc0 c054fff4 c057da2c
> > 
> > Reverting the change as follows, allows booting:
> > Any ideas to debug this further?
> 
> 
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index db0c5f6..fba018c 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -414,7 +414,9 @@ int __init acpi_table_parse(enum acpi_ta
> >  	unsigned int index;
> >  	unsigned int count = 0;
> >  
> > -	BUG_ON(!handler);
> > +	if (!handler)
> > +		return -EINVAL;
> > +	/*BUG_ON(!handler);*/
> >  
> >  	for (i = 0; i < sdt_count; i++) {
> >  		if (sdt_entry[i].id != id)
> 
> What do you see if on failure you also print out the params, like below?
> 
I'm sorry, I might not be able to try it until monday. Michal reported
a similar problem though, adding him to CC list.

Regards,
Frederik

> thanks,
> -Len
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 3fce3db..e2d08a5 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -415,7 +415,12 @@ int __init acpi_table_parse(enum acpi_table_id id, acpi_table_handler handler)
>  	unsigned int index = 0;
>  	unsigned int count = 0;
>  
> -	BUG_ON(!handler);
> +	if (!handler) {
> +		printk(KERN_WARNING PREFIX
> +			"acpi_table_parse(%d, %p) %s NULL handler!\n",
> +			id, handler, acpi_table_signatures[id]);
> +		return -EINVAL;
> +	}
>  
>  	for (i = 0; i < sdt_count; i++) {
>  		if (sdt_entry[i].id != id)
> 
> 
> 
