Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTIDNbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbTIDNbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:31:21 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:55053 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264997AbTIDNbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:31:11 -0400
Date: Thu, 4 Sep 2003 10:30:56 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       campbell@torque.net, linux-scsi@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5: SCSI imm driver doesn't compile
Message-ID: <20030904133056.GA2411@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, campbell@torque.net,
	linux-scsi@vger.kernel.org
References: <20030902231812.03fae13f.akpm@osdl.org> <20030903170256.GA18025@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903170256.GA18025@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 03, 2003 at 07:02:56PM +0200, Adrian Bunk escreveu:
> The following compile error (tested with gcc 2.95) seems to come from 
> Linus' tree:
> 
> <--  snip  -->
> 
> ...
>   CC [M]  drivers/scsi/imm.o
> In file included from drivers/scsi/imm.c:55:
> drivers/scsi/imm.h:105: duplicate array index in initializer
> drivers/scsi/imm.h:105: (near initialization for `IMM_MODE_STRING')
> make[2]: *** [drivers/scsi/imm.o] Error 1
> 
> <--  snip  -->
> 
> The problem is the following code in imm.h (with 
> CONFIG_SCSI_IZIP_EPP16 enabled):
> 
> <--  snip  -->
> 
> ...
> static char *IMM_MODE_STRING[] =
> {
>         [IMM_AUTODETECT] = "Autodetect",
>         [IMM_NIBBLE]     = "SPP",
>         [IMM_PS2]        = "PS/2",
>         [IMM_EPP_8]      = "EPP 8 bit",
>         [IMM_EPP_16]     = "EPP 16 bit",
> #ifdef CONFIG_SCSI_IZIP_EPP16
>         [IMM_EPP_16]     = "EPP 16 bit",
> #else
>         [IMM_EPP_32]     = "EPP 32 bit",
> #endif
>         [IMM_UNKNOWN]    = "Unknown",
> };
> ...
> 
> <--  snip  -->

Original code was:

 static char *IMM_MODE_STRING[] =
 {
    "Autodetect",
    "SPP",
    "PS/2",
    "EPP 8 bit",
    "EPP 16 bit",
 #ifdef CONFIG_SCSI_IZIP_EPP16
    "EPP 16 bit",
 #else
    "EPP 32 bit",
 #endif
    "Unknown"};

I just converted it to the more safe c99 init style, but haven't noticed
the original bug, that is "EPP 16 bit" was duplicated... But this is already
fixed by Andrew Morton on current Linus bk tree.

Thanks Andrew for fixing, Adrian for noticing.

- Arnaldo
