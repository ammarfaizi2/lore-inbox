Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUFBNq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUFBNq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUFBNqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:46:32 -0400
Received: from havoc.gtf.org ([216.162.42.101]:64460 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262902AbUFBNqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:46:08 -0400
Date: Wed, 2 Jun 2004 09:46:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
Message-ID: <20040602134603.GA8589@havoc.gtf.org>
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com> <40BD95EB.40506@shadowconnect.com> <40BDD4C9.5070602@pobox.com> <40BDDAD9.5070809@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BDDAD9.5070809@shadowconnect.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 03:49:13PM +0200, Markus Lidel wrote:
> Hello,
> 
> Jeff Garzik wrote:
> >>>My preferred approach would be:  consider that the hardware does not 
> >>>need the entire 0x8000000-byte area mapped.  Plain and simple.
> >>>This is a "don't do that" situation, and that renders the other 
> >>>questions moot :)  You should only be mapping what you need to map.
> >>Okay, i'll let try it out with only 64MB.
> >Why do you need 64MB, even?  :)
> 
> I don't know how much space i need :-D But why does the device set the 
> size to 128MB then?

Devices often export things you don't care about, such as direct access
to internal chip RAM.

Look through the driver that figure out the maximum value that the
driver actually _uses_.  There is no need to guess.


> Also now both controllers where found, but the kernel crashes. It could 
> be because the driver was never used with 2 controllers, but to be sure 
>  i didn't make something wrong with the ioremap here is my patch.
> 
> --- a/drivers/message/i2o/i2o_core.c	2004-05-25 00:51:48.822275000 +0200
> +++ b/drivers/message/i2o/i2o_core.c	2004-06-01 22:17:55.562844312 +0200
> @@ -3664,6 +3664,8 @@
>  	}
>  	
>  	size = dev->resource[i].end-dev->resource[i].start+1;	

You should be using pci_resource_start() and pci_resource_len()
to obtain this information.


> +	if(size>67108864)
> +		size = 67108864;

It's nicer if you use hex numbers, when they are powers of two.

	Jeff



