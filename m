Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSL2T7h>; Sun, 29 Dec 2002 14:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSL2T7h>; Sun, 29 Dec 2002 14:59:37 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30982 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261495AbSL2T7f>;
	Sun, 29 Dec 2002 14:59:35 -0500
Date: Sun, 29 Dec 2002 21:07:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Kernel configuration in kernel, kernel 2.5.53
Message-ID: <20021229200751.GA1302@mars.ravnborg.org>
Mail-Followup-To: Paul Rolland <rol@as2917.net>,
	linux-kernel@vger.kernel.org
References: <200212291837.09152.rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212291837.09152.rol@as2917.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 06:37:09PM +0100, Paul Rolland wrote:
> Hello,
> 
> Here is the 2.5.53 version of the patch I just sent to the list for 2.4.20
> Main differences are in the Makefile and Kconfig.

Some comments to the Makefile + a little more.

	Sam

> +MODULE_AUTHOR("Paul Rolland");
> +MODULE_DESCRIPTION("Driver for accessing kernel configuration");
> +MODULE_LICENSE("GPL");
> +
> +EXPORT_NO_SYMBOLS;
EXPORT_NO_SYMBOLS in a noop in 2.5. Please remove

> +  printf("\n");
> +  printf("#define CONFIG_SIZE %d\n\n", size);
The CONFIG_ prefix indicates a value from kconfig, which CONFIG_SIZE is not.


> +++ linux-2.5.53/drivers/char/Makefile  2002-12-29 17:43:53.000000000 +0100
> +$(obj)/config.h: $(obj)/config.txt.gz
> +       cc -o $(obj)/dotHmaker $(obj)/dotHmaker.c
> +       $(obj)/./dotHmaker < $(obj)/config.txt.gz > $(obj)/config.h
> +
> +$(obj)/config.txt.gz::
> +       cp .config $(obj)/config.txt
> +       gzip -f $(obj)/config.txt
> +
Replace the above with something like this:

host-progs	:= dotHmaker
EXTRA_TARGETS	:= config.txt.gz

$(obj)/config.h: $(obj)/config.txt.gz $(obj)/dotHmaker
	$(obj)/dotHmaker < $< > $@

$(obj)/config.txt.gz: .config
	$(call if_changed,gzip)

That is more in line with general kbuild practice.
Please note that gzip will be called with -9 in the above case.
I do not expect it to have any influence.
