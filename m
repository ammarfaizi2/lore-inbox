Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUASUhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUASUhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:37:19 -0500
Received: from quechua.inka.de ([193.197.184.2]:57732 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262687AbUASUhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:37:14 -0500
To: linux-dvb@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb] Re: Kernel oops with ttusb_dec
References: <ecartis-01182004203937.22827.1@mail.convergence2.de> <200401182002.18784.linux-dvb@giblets.org> <200401182134.12598.rafael@mondoria.de> <200401182213.37387.linux-dvb@giblets.org>
Organization: private Linux site, southern Germany
Date: Mon, 19 Jan 2004 21:34:36 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1Aig6W-0006m8-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CCd to linux-kernel and dvb lists. Context: SuSE 9.0, kernel 2.4.21,
ttusb_dec module fails]

> > Is cipcb really needed in Release 1.36? It is the only modules which gives
> > crc32 as a symbol.

> > >>EIP; dde5ba82 <[cipcb]crc32+12/30>   <=====
> > >>
> > >>eax; dea04560 <[ttusb_dec]dsp_dec2000t+0/69100>
> > >>edx; dea0455f <[ttusb_dec]dec3000s_frontend_info+bf/c0>
> > >>esi; ddcfde18 <[snd-mixer-oss].data.end+eaf2141/ec4c389>
> > >>edi; ddcfde20 <[snd-mixer-oss].data.end+eaf2149/ec4c389>
> > >>esp; ddcfcdb4 <[snd-mixer-oss].data.end+eaf10dd/ec4c389>

> No, cipcb isn't needed.  It should be using the crc32 function from the main
> kernel.  If it's trying to use the one in cipcb, which takes very different
> arguments, it's no wonder there is a problem.
>
> I'm unsure of the right way to fix this.  Suggestions anyone?

Eeek. If the OP didn't even know if he needed the cipcb module, this
should mean he didn't knowingly start the CIPE driver, and[*] thus the
cipcb module was loaded by the modprobe dependency mechanism by virtue
of it defining a symbol called "crc32".

modprobe shouldn't know of that symbol in the CIPE module at all,
because it's not meant to be exported. There are some definitions in
the module subsystem which deal with the exporting of symbols. I
suspect either CIPE or DVB (or both of them) needs a fix in this area.
Anyone here knows more?

Another data point: crc32 isn't available in 2.4.21 at all, so it's
apparently(?) not a kernel configuration problem. But shouldn't that
mean that the ttusb_dec driver wouldn't run at all under that kernel?

Ah, by the way, this could perhaps have been avoided completely if the
kernel was compiled with CONFIG_MODVERSIONS enabled (because then the
crc32 function, if properly exported, would have gotten a name which
depends on its arguments). This not being on unconditionally is one of
my pet peeves with Linux and distros, because of the many CIPE
bugreports I get which are due to just version incompatibilities.

Olaf

[*] unless SUSE has really screwed it up and started a CIPE process by
default, but this is rather implausible as it needs nontrivial
configuration, and loading the module without the ciped process just
wastes memory.

