Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTLOSTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLOSTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:19:05 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27778 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263830AbTLOSRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:17:50 -0500
Date: Mon, 15 Dec 2003 13:20:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDDEE32.7050900@intel.com>
Message-ID: <Pine.LNX.4.53.0312151304480.14778@chaos>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca>
 <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com>
 <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos>
 <3FDDEE32.7050900@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, Vladimir Kondratiev wrote:

> Richard B. Johnson wrote:
> <discussion regarding initializers for static vars>
>
> Let's stop this discussion, it leads to nowhere. Probable, yes,
> initializer do add bytes to the data segment. But it does not make
> difference for memory image after loading, do it?
>

It definitely does. It makes the difference between having stuff
work or not in many embedded systems.

> Does this difference in executable size worth potential risk of error?
>
> Anyway, common style in kernel seems to be to do initialize static vars,
> even to 0. There are plenty of examples, including the same file, (for
> 2.4.23)
>
> arch/i386/kernel/pci-pc.c:32
> static int pci_using_acpi_prt = 0;
>

This is a BUG. This wastes space that may end up being embedded
in NVRAM, then copied to RAM. If it was not initialized, it would
never exist in NVRAM at all.

> or
>
> arch/i386/kernel/setup.c:1241
> static int tsc_disable __initdata = 0;
>

This is not a BUG because "__initdata" is defined to be in a segment
that is initialized and discarded after use.

> Finally, let's stop this thread. Let it be up to person who will be (if
> it will happen) checking this code into kernel, to decide on coding
> style. I, personally, value code clarity more then 4 bytes in executable
> size. But I will not object if more experienced kernel maintainers have
> another priority.
>
> Vladimir.
>

It's not style. It's misuse of variables and well-defined
conventions. Often data is not some simple variable, but an
aggregate type such as a structure or an array. FYI "style"
relates to naming conventions and where you put curley braces.
Even that is supposed to be controlled to some liberal extent.

static long xtable[0x100] = {0,};

MUST be in the .data segment, while...

static long xtable[0x100];

MUST be in the .bss segment, while...

static const long xtable[0x100]={0,1,2,3,4,5,6,7,8,9,.....};

MUST be in the .const segment. It's that simple. If you
violate that, your code will only work by fiat, i.e., it
was defined to work, not designed to work.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


