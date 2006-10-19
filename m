Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946162AbWJSQGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946162AbWJSQGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946173AbWJSQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:06:41 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:13299 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1946163AbWJSQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:06:38 -0400
Date: Thu, 19 Oct 2006 09:07:41 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@redhat.com>, Patrick Jefferson <henj@hp.com>,
       Kenny Graunke <kenny@whitecape.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [2.6.19 patch] drivers/ide/pci/generic.c: re-add the
 __setup("all-generic-ide",...)
Message-Id: <20061019090741.853ea100.randy.dunlap@oracle.com>
In-Reply-To: <20061019152651.GR3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061017155934.GC3502@stusta.de>
	<4534C7A7.7000607@hp.com>
	<20061018221520.GK3502@stusta.de>
	<20061018231844.GA16857@devserv.devel.redhat.com>
	<20061019152651.GR3502@stusta.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 17:26:51 +0200 Adrian Bunk wrote:

> On Wed, Oct 18, 2006 at 07:18:44PM -0400, Alan Cox wrote:
> > On Thu, Oct 19, 2006 at 12:15:20AM +0200, Adrian Bunk wrote:
> > > IOW, your patch does break existing setups since the change to 
> > > module_param() requires prefixing with the module name (the ata_generic 
> > > option with the same name is irrelevant)?
> > > 
> > > Considering that drivers/ide/ is slowly approaching a RIP status, 
> > > is such an incompatible change really required?
> > > 
> > > I'd be more inclined to revert your patch.
> > 
> > We shouldn't revert it - there is a real problem for some users whose
> > distro has it modular this fixed. We might want to honour both 
> 
> Agreed, patch below.
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> The change from __setup() to module_param_named() requires users to 
> prefix the option with "generic.".
> 
> This patch re-adds the __setup() additionally to the 
> module_param_named().
> 
> Usually it would make sense getting rid of such an obsolete __setup() at 
> some time, but considering that drivers/ide/ is slowly approaching a RIP 
> status it's already implicitely scheduled for removal.
> 
> This patch fixes kernel Bugzilla #7353.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6/drivers/ide/pci/generic.c.old	2006-10-19 16:35:15.000000000 +0200
> +++ linux-2.6/drivers/ide/pci/generic.c	2006-10-19 16:46:21.000000000 +0200
> @@ -40,6 +40,19 @@
>  
>  static int ide_generic_all;		/* Set to claim all devices */
>  
> +/*
> + * the module_param_named() was added for the modular case
> + * the __setup() is left as compatibility for existing setups
> + */
> +#ifndef MODULE
> +static int __init ide_generic_all_on(char *unused)
> +{
> +	ide_generic_all = 1;
> +	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.");
> +	return 1;
> +}
> +__setup("all-generic-ide", ide_generic_all_on);
> +#endif
>  module_param_named(all_generic_ide, ide_generic_all, bool, 0444);
>  MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE storage controllers.");

Missing update to Documentation/kernel-parameters.txt ?
(maybe it's been missing forever?)

---
~Randy
