Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284147AbRL1WaW>; Fri, 28 Dec 2001 17:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284176AbRL1WaN>; Fri, 28 Dec 2001 17:30:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6670 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284147AbRL1WaF>; Fri, 28 Dec 2001 17:30:05 -0500
Date: Fri, 28 Dec 2001 14:27:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <20011228161223.A19069@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0112281417410.23445-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Eric S. Raymond wrote:
> Legacy Fishtank <garzik@havoc.gtf.org>:
> > Note I am specifically NOT talking about MAINTAINERS and CREDITS.
> > -PLEASE- don't obscure my point by mentioning them.
>
> It's the same problem, Jeff.  Same solution, too.

It's not.

We already have pre-file credits information - people can put stuff in
there for their own (C) messages etc. The MAINTAINERS file is a much
higher-level thing which is there to be human-readable.

Note that I do _not_ want to mess up source files with magic comments. I
absolutely detest those. They only detract from the real job of coding,
and do not make anybody happier.

We have a hierarchical filesystem. Most drivers already have

	driver.c
	driver.h

(in fact _very_ few drivers are single-file) and some have a subdirectory
of their own. So why not just have

	driver.conf

and be done with it. No point in messing up the C file with stuff that
doesn't add any information to either the programmer _or_ the compiler.

Then you can make the config file _truly_ readable, and make the format
something like

	define tristate
	CONFIG_SCSI_AIC7XXX: Adaptec AIC7xxx support

	  This driver supports all of Adaptec's PCI based SCSI controllers
	  (not the hardware RAID controllers though) as well as the aic7770
	  based EISA and VLB SCSI controllers (the 274x and 284x series).
	  This is an Adaptec sponsored driver written by Justin Gibbs.  It is
	  intended to replace the previous aic7xxx driver maintained by Doug
	  Ledford since Doug is no longer maintaining that driver.

		depends on CONFIG_SCSI
		depends on CONFIG_PCI
		depends on ...

	define integer
	CONFIG_AIC7XXX_CMDS_PER_DEVICE: Maximum number of TCQ commands per device

		depends on CONFIG_SCSI_AIC7XXX
		default value 253

	define integer
	CONFIG_AIC7XXX_RESET_DELAY_MS: Initial bus reset delay in milli-seconds

		depends on CONFIG_SCSI_AIC7XXX
		default value 15000

	....

and it's readable and probably trivially parseable into both the existing
format (ie some "find . -name '*.conf'" plus sed-scripts) and into cml2 or
whatever.

		Linus

