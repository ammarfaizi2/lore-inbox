Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTAaWZ3>; Fri, 31 Jan 2003 17:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTAaWZ3>; Fri, 31 Jan 2003 17:25:29 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:5390 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262806AbTAaWZ2>; Fri, 31 Jan 2003 17:25:28 -0500
Date: Fri, 31 Jan 2003 23:33:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support.
In-Reply-To: <Pine.LNX.4.44.0301302351550.15587-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0301312045440.9900-100000@serv>
References: <Pine.LNX.4.44.0301302351550.15587-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 31 Jan 2003, Kai Germaschewski wrote:

> exactly great. In doing that, I already notice unresolved symbols and warn 
> about them, which I think is an improvement to the build process, missing 
> EXPORT_SYMBOL()s tend to go unnoticed quite often otherwise.

The problem here is that we use System.map, it's not that difficult to 
extract the exported symbols:
objcopy -j .kstrtab -O binary vmlinux .export.tmp
tr \\0 \\n < .export.tmp > Export.map

> Doing this postprocessing unconditionally would allow to generate the 
> alias tables at this point as well.
> 
> And while we're at it, we could add another section which specifies which 
> other modules this module depends on (a.k.a which symbols it uses), making 
> depmod kinda obsolete.

It makes sense to keep depmod close to the linker, as both need the same 
knowledge about resolving symbols, but I still don't know why that would 
be a reason to put it into the kernel.
It doesn't really matter if that information is generated during build or 
at install, it just has to be at /lib/module/`uname -r` in a way modprobe 
understands. BTW for my taste modprobe has too much knowledge about the 
module layout, which actually belongs to the linker.

I finally looked a bit closer at the module alias. The possibility of 
wildcards is certainly interesting, but besides of this it looks to me as 
if we exchange one crutch with another. The alias string is too static 
and cryptic. Adding information to it requires changes at too many places 
(let alone adding information dynamically).
What I'd really like to see is a really generic but still simple system to 
match devices and drivers, e.g. describing properties like this:

bus=usb
vendor=0x1234
product=0x4321
device=1-3,5

Forcing the matching onto modprobe doesn't look like a good idea to me, as 
IMO it takes too much away from hotplug. The alias string is not usable 
for hotplug, but above properties can be used to trigger other operations
beside module loading.

bye, Roman

