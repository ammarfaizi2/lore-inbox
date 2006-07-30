Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWG3Slx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWG3Slx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWG3Slx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:41:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:27614 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932423AbWG3Slw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:41:52 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building external modules against objdirs
Date: Sun, 30 Jul 2006 20:37:02 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
References: <200607301846.07797.ak@suse.de> <200607301949.41165.ak@suse.de> <20060730183159.GA30278@mars.ravnborg.org>
In-Reply-To: <20060730183159.GA30278@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607302037.02559.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 20:31, Sam Ravnborg wrote:
> On Sun, Jul 30, 2006 at 07:49:41PM +0200, Andi Kleen wrote:
> > 
> > > Can you check that you really did a 'make prepare' in the relevant
> > > output directory. Previously only the make *config step was needed.
> > 
> > The output directory is a full build (configuration + make without any targets).
> > Is that not enough anymore? 
> > 
> > Anyways after a make prepare it seems to work - thanks - but I think that
> > should be really done as part of the standard build like it was in 2.6.17.
> 'make prepare' is and has always been part of the standard build.
> So I really do not see what is going on.

To reproduce (on x86-64 at least)

mkdir obj
cd obj
make -C ../linux-2.6.18-... O=$(pwd) defconfig
make 



> Can you please check that followign files exists in your output
> directory:
> .config
> include/config/auto.conf.cmd
> include/config/auto.conf
> 
> the latter should be the latest of the three.

-rw-r--r--  1 andi users 28481 2006-07-29 19:01 .config
-rw-r--r--  1 andi users  7739 2006-07-29 19:07 include/config/auto.conf
-rw-r--r--  1 andi users  6867 2006-07-29 19:07 include/config/auto.conf.cmd

 
> Also try applying following patch to reveal why we trigger this rule:
> 
> diff --git a/Makefile b/Makefile
> index 1dd58d3..4c30ed5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -453,6 +453,7 @@ include/config/auto.conf: $(KCONFIG_CONF
>  ifeq ($(KBUILD_EXTMOD),)
>  	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
>  else
> +	@echo triggered by - $? -
>  	$(error kernel configuration not valid - run 'make prepare' in $(srctree) to update it)
>  endif


The echo didn't output for some reason, but adding it to the error gives

/home/lsrc/quilt/linux/Makefile:456: *** triggered by /home/lsrc/quilt/linux/drivers/net/wireless/Kconfig /home/lsrc/quilt/linux/drivers/message/fusion/Kconfig /home/lsrc/quilt/linux/net/ieee80211/Kconfig /home/lsrc/quilt/linux/net/netfilter/Kconfig kernel configuration not valid - run 'make prepare' in /home/lsrc/quilt/linux to update it.  Stop.
 
-Andi
