Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293105AbSBWHCw>; Sat, 23 Feb 2002 02:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293108AbSBWHCp>; Sat, 23 Feb 2002 02:02:45 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:37388 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293105AbSBWHC1>; Sat, 23 Feb 2002 02:02:27 -0500
Date: Sat, 23 Feb 2002 08:02:24 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020223080223.A32501@devcon.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020216015834.D28176@devcon.net> <Pine.LNX.4.33L2.0202221150420.2938-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0202221150420.2938-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Fri, Feb 22, 2002 at 11:56:31AM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 11:56:31AM -0800, Randy.Dunlap wrote:
> 
> | Note that you also need some way to keep the config symbols which are
> | set to "n" and commented out in the .config. Otherwise you will have
> | to answer a lot of questions on "make oldconfig" ("yes n | make
> | oldconfig" isn't an option, as this doesn't tell you which config
> | symbols have been added).
> Will
>   yes n | make oldconfig
> build a kernel with the current y/m options still intact,
> but any new or missing options set to 'n'?

Yes. "make oldconfig" will only ask for options not contained in the old
 .config, and options it doesn't ask for don't take any input ;-)

> | I have actually done my own patch to include the .config into the
[...]
> I looked.  It does nicely if that's where you want to store and find
> the .config.  I'd rather have it associated with a kernel image file
> and accessible even if the kernel isn't running.

You can extract it. One possibility is to disable compression for
/proc/config and apply your "strings" magic.

The other way works if the config is GZIP compressed. Find the GZIP
magic in the vmlinuz, decompress the compressed part of the image (up
here it is like your "strings" variant), then search for GZIP magic
again and decompress.

Quick&dirty script for the latter (using your "binoffset" tool):

---------- snip ----------
#!/bin/sh
set -e
tmp=/tmp/$$
gziphdr=`binoffset $1 0x1f 0x8b 0x08 2>/dev/null`
dd if=$1 bs=1 skip=$gziphdr 2>/dev/null | gunzip > $tmp
gziphdr=`binoffset $tmp 0x1f 0x8b 0x08 2>/dev/null`
dd if=$tmp bs=1 skip=$gziphdr 2>/dev/null | gunzip
rm -f $tmp
---------- snip ----------

At the moment I'm just writing a tool which does all parts in one turn
(using zlib), to make it faster and more robust (the script above may
fail for example if the kernel image has more than one block of gzip
compressed data embedded). (It's actually working already, but the
code needs some heavy cleanup before it can be released to the public
;-) Come back in a few days for news...

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
