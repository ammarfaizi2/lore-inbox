Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUFQSnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUFQSnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUFQSkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:40:24 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:15833 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261712AbUFQSgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:36:52 -0400
Date: Thu, 17 Jun 2004 20:36:16 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Finn Thain <ft01@webmastery.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Matt Mackall <mpm@selenic.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: Subject: Re: make checkstack on m68k
Message-ID: <20040617183616.GC29029@wohnheim.fh-wedel.de>
References: <200406161930.VAA16618@pfultra.phil.uni-sb.de> <Pine.LNX.4.58.0406171812440.8197@bonkers.disegno.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406171812440.8197@bonkers.disegno.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 June 2004 18:43:18 +1000, Finn Thain wrote:
> To:	Geert Uytterhoeven <geert@linux-m68k.org>,
> 	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
> 	Matt Mackall <mpm@selenic.com>,
> 	Linux Kernel Development <linux-kernel@vger.kernel.org>

Who are you replying to again? ;)

> Jörn Engel wrote:
> 
> > On Wed, 16 June 2004 18:51:03 +0200, Geert Uytterhoeven wrote:
> > >
> > > @@ -40,6 +40,11 @@
> > >  	} elsif ($arch =~ /^ia64$/) {
> > >  		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
> > >  		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
> > > +	} elsif ($arch =~ /^m68k$/) {
> > > +		#2b6c:       4e56 fb70       linkw %fp,#-1168
> > > +		#$re = qr/.*linkw %fp,#-([0-9]{1,4})/o;
> > > +		#1df770:       defc ffe4       addaw #-28,%sp
> > > +		$re = qr/.*addaw #-([0-9]{1,4}),%sp/o;
> >
> > For i386 I used a really ugly hack, but this needs someone with better
> > perl skills.  Matt, can you find a nice regex?  If it adds more
> > brackets, that's fine.  We'll just add empty brackets to the other
> > regexes and use $2 instead of $1 or so.
> 
> There is no nice way to do this in perl in a single regex and have the
> result always in $1 or always in $2. So you would test for undef in one
> and use the other.  But then the other arch regexes that capture more than
> one cluster would need to be rewritten to use (?: ) syntax to get
> clustering without capturing (see man perlre) so as to leave $2 undefined.
> 
> A list of regexes for each arch would be nice. But should probably be
> left until needed. Following is probably the simplest way. The regexes
> remain understandable to mortals since they don't do fancy stuff. And the
> other archs don't need to be touched.

It's not as ugly as my hack.  Can I get a success report from m68k?
Thanks!

> --- linux-2.6.7/Makefile	2004-06-16 13:06:15.000000000 +0200
> +++ linux-m68k-2.6.7/Makefile	2004-06-16 18:27:13.000000000 +0200
> @@ -1070,7 +1070,7 @@ endif #ifeq ($(mixed-targets),1)
>  .PHONY: checkstack
>  checkstack:
>  	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
> -	$(PERL) scripts/checkstack.pl $(ARCH)
> +	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
> 
>  # FIXME Should go into a make.lib or something
>  # ===========================================================================
> --- linux-2.6.7/scripts/checkstack.pl	Thu Jun 17 18:06:18 2004
> +++ linux-m68k-2.6.7/scripts/checkstack.pl	Thu Jun 17 18:09:21 2004
> @@ -12,7 +12,7 @@
>  #	Random bits by Matt Mackall <mpm@selenic.com>
>  #
>  #	Usage:
> -#	objdump -d vmlinux | stackcheck_ppc.pl [arch]
> +#	objdump -d vmlinux | stackcheck.pl [arch]
>  #
>  #	TODO :	Port to all architectures (one regex per arch)
> 
> @@ -40,6 +40,11 @@
>  	} elsif ($arch =~ /^ia64$/) {
>  		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
>  		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
> +	} elsif ($arch =~ /^m68k$/) {
> +		#2b6c:       4e56 fb70       linkw %fp,#-1168
> +		$re = qr/.*linkw %fp,#-([0-9]{1,4})/o;
> +		#1df770:       defc ffe4       addaw #-28,%sp
> +		$re_2 = qr/.*addaw #-([0-9]{1,4}),%sp/o;
>  	} elsif ($arch =~ /^mips64$/) {
>  		#8800402c:       67bdfff0        daddiu  sp,sp,-16
>  		$re = qr/.*daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
> @@ -75,7 +80,7 @@
>  	if ($line =~ m/$funcre/) {
>  		$func = $1;
>  	}
> -	if ($line =~ m/$re/) {
> +	if ($line =~ m/$re/ or (defined($re_2) && $line =~ m/$re_2/)) {
>  		my $size = $1;
>  		$size = hex($size) if ($size =~ /^0x/);

Jörn

-- 
When in doubt, punt.  When somebody actually complains, go back and fix it...
The 90% solution is a good thing.
-- Rob Landley
