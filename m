Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTH3Ho7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 03:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbTH3Ho7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 03:44:59 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:6392 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261664AbTH3Ho5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 03:44:57 -0400
Subject: Re: 2.6.0-test4-mm3
From: Martin Schlemmer <azarah@gentoo.org>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1062168946.19599.114.camel@workshop.saharacpt.lan>
References: <3F4F22D3.9080104@freemail.hu>
	 <200308291300.h7TD049n022785@turing-police.cc.vt.edu>
	 <1062168946.19599.114.camel@workshop.saharacpt.lan>
Content-Type: text/plain
Message-Id: <1062228935.30172.17.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Aug 2003 09:35:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 16:55, Martin Schlemmer wrote:
> On Fri, 2003-08-29 at 15:00, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 29 Aug 2003 11:54:27 +0200, Boszormenyi Zoltan <zboszor@freemail.hu>  said:
> > 
> > > I tried to "make modules_install" on the compiled tree.
> > > It says:
> > > 
> > > # make modules_install
> > > Install a current version of module-init-tools
> > > See http://www.codemonkey.org.uk/post-halloween-2.5.txt
> > > make: *** [_modinst_] Error 1
> > 
> > Whoops... My fault. ;)
> > 
> > It was mostly a proof of concept - if there's a *known*
> > better test I'm all ears. ;)
> 
> Cannot think of one that is known.  An quick solution
> your (and not RH) side, might be something like below.
> I am though not 100% sure if this will work (does the RH
> patches check for modules present before calling bins
> from module-init-tools, or do they just yield if they
> detect a newer kernel?), so if somebody on a RH box could
> test it ...
> 
> The basic concept is that modprobe from modutils start
> an error message with 'modprobe:' and the one from
> module-init-tools starts with 'FATAL:'.
> 
> Another issue you may want to consider, is that modprobe
> from module-init-tools use the 'create_module' syscall
> to determine the kernel version, and I think that the RH
> patches does as well .... what are you going to do if its
> a 2.4 kernel running, but module-init-tools are installed?
> In this case even my patch are going to fail.  I guess thus
> that you will have to try and get Boszormenyi's changes
> applied RH side ...
> 
> ---------------
> iff -puN Makefile~old-module-tools-warning Makefile
> --- 25/Makefile~old-module-tools-warning	Thu Aug 28 14:24:35 2003
> +++ 25-akpm/Makefile	Thu Aug 28 14:24:35 2003
> @@ -606,6 +606,11 @@ modules_install: _modinst_ _modinst_post
>  
>  .PHONY: _modinst_
>  _modinst_:
> +	@if [ -z "`modprobe -n foobar 2>&1 | egrep '^FATAL:'`" ]; then \
> +		echo "Install a current version of module-init-tools"; \
> +		echo "See http://www.codemonkey.org.uk/post-halloween-2.5.txt";\
> +		/bin/false; \
> +	fi
>  	@rm -rf $(MODLIB)/kernel
>  	@rm -f $(MODLIB)/build
>  	@mkdir -p $(MODLIB)/kernel
> 
----------------------

Seems like above never made it out.  Anyhow, adding anything
like this that fails is no good, except maybe if it checks
current kernel, and if depmod then do not return a version
consistent with module-init-tools if we are using a 2.5/6 kernel,
fail.  Reason for this, is that even with the '-V' switch,
depmod.old will be called and the incorrect version supplied if
we are currently on a 2.4 kernel ....


Regards,

-- 
Martin Schlemmer


