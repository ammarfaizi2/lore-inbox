Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291174AbSBLVLW>; Tue, 12 Feb 2002 16:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291179AbSBLVLN>; Tue, 12 Feb 2002 16:11:13 -0500
Received: from [63.231.122.81] ([63.231.122.81]:37202 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291174AbSBLVK7>;
	Tue, 12 Feb 2002 16:10:59 -0500
Date: Tue, 12 Feb 2002 14:06:24 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Padraig Brady <padraig@antefacto.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020212140624.R9826@lynx.turbolabs.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Padraig Brady <padraig@antefacto.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C695035.6040902@antefacto.com> <Pine.LNX.3.96.1020212132711.6082B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020212132711.6082B-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Feb 12, 2002 at 01:32:11PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2002  13:32 -0500, Bill Davidsen wrote:
> On Tue, 12 Feb 2002, Padraig Brady wrote:
> > I'd go for tacking it on at the end of the bzImage. Advantages would be
> > that it can be read even when the kernel isn't loaded, and also there
> > is no danger of loading a module in another kernel.
> 
> There are several problems with that:
> 1 - built into the kernel it is compressed and needs a tool to read
> 2 - the reason kernels are compressed is to make them fit in small boot
>     media, so adding something to the image is not to be done lightly.
> 3 - modules are NOT compressed, and can be read with the strings command.
> 4 - other files in the modules directory are pure text and if the config
>     was just text it could be read with `cat.'

My thought on this is to make it a tristate [y/m/n] and have it print
output via /dev/kconfig or similar.  There could be a dep_bool which
keeps it in-core, or puts it in an init function which is discarded
after boot.  If you don't want to have it at all, you turn it off.
If you want it in the kernel, but not in memory all the time, it can
be in an init function (maybe printk'ing it before startup is done?).
It can be in a module and you can get the original plain-text config
back with "cat /dev/kconfig" and if it is a module it will be auto-loaded
from wherever it is.

You can also extract it from an uncompressed kernel (vmlinux) or the
module with "strings <file> | grep '[A-Z]*=[ym]$'".  It is simple
enough to search for the gzip magic (1f 8b 08 00 at about 16-18kB)
in a zImage or bzImage, and then pipe it to gunzip and strings as above.

The reason you need all of these config options (which don't end up
making the code much more complex) is because, for example, if you
are netbooting your kernel, you do not have access to any external
data or even the original kernel image on that system.  If it is in-memory
you use 15kB of RAM (5kB in the compressed image) for a fully-configured
vendor kernel, but you have the config options for THIS kernel and not
any "maybe it is right, maybe not" external file.

If it is a module, you can "cat /dev/kconfig > .config" to get a valid
config file, as long as you are sure this is the right module (maybe
modversions would help a bit, maybe not, or you could explicitly have
the kernel version string compiled into the module and compare it).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

