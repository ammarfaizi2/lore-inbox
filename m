Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292304AbSBPBPk>; Fri, 15 Feb 2002 20:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292305AbSBPBPd>; Fri, 15 Feb 2002 20:15:33 -0500
Received: from air-2.osdl.org ([65.201.151.6]:12306 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292304AbSBPBPY>;
	Fri, 15 Feb 2002 20:15:24 -0500
Date: Fri, 15 Feb 2002 17:10:48 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.4.33L2.0202151501220.11494-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0202151657230.11494-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Randy.Dunlap wrote:

| On Fri, 15 Feb 2002, Andreas Dilger wrote:
|
| | On Feb 14, 2002  08:48 -0800, Randy.Dunlap wrote:
| | > gziphdr=`binoffset $1 0x1f 0x8b 0x08 0x0`
| | > # increment by 1 since tail offsets are 1-based, not 0-based
| | > gziphdr=$((gziphdr + 1))
| | >
| | > tail -c +$gziphdr $1 | gunzip > $1.tmp
| | > strings $1.tmp | grep CONFIG_ > $1.old.config
| | > rm $1.tmp
| |
| | How about something like the below (avoids writing a multi-MB temp file):
| |
| | HDR=`binoffset $1 0x1f 0x8b 0x08 0x0`
| | dd if=$1 bs=1 skip=$HDR | zcat | strings /dev/stdin | grep CONFIG_
|
| I tried that, but I didn't know about /dev/stdin,
| so I agree with you.
| I had tried 'strings -', but strings didn't like that.  :(
|
| | Note also that it is enough to store the config options without the
| | leading CONFIG_ part, and then use 'grep "[A-Z0-9]*=[ym]$"' to get
| | the actual config strings.  You can add a final 'sed "s/^/CONFIG_/"'
| | step to return it to the original format.  So:
| |
| | dd if=$1 bs=1 skip=$HDR | zcat | strings /dev/stdin | grep "[A-Z0-9]=[ym]$" \
| | 	| sed "s/^//CONFIG_"
| | --
|
| Yes, I said that I intended to remove the leading "CONFIG_".
| I'll do that soon and package it all up and repost it.
| Oh, and make it a CONFIG option.
|
| Thanks for your help.

Interim report:  I agree with the spirit of no temp. file, but one of
zcat or strings isn't working for me when I use only pipes.  The final
output file is empty (length = 0).

Hers's the current script:

HDR=`binoffset $1 0x1f 0x8b 0x08 0x0`
dd if=$1 bs=1 skip=$HDR | zcat - | strings /dev/stdin \
  | grep "[A-Za-z_0-9]=[ym]$" | sed "s/^/CONFIG_/" > $1.old.config

with the error output:

++ binoffset bzImage 0x1f 0x8b 0x08 0x0
filesize: 1086399
number of pattern matches = 1
19268
+ HDR=19268
+ dd if=bzImage bs=1 skip=19268
+ zcat -
+ strings /dev/stdin
32769+0 records in
32768+0 records out
/home/rddunlap/bin/extract-config: line 9: 13783 Broken pipe
dd if=$1 bs=1 skip=$HDR
     13784                       | zcat -
     13785 Segmentation fault      | strings /dev/stdin >$1.strings

This one works (no surprise):

HDR=`binoffset $1 0x1f 0x8b 0x08 0x0`
dd if=$1 bs=1 skip=$HDR | zcat - > $1.vmlin.tmp
strings $1.vmlin.tmp | grep "[A-Za-z_0-9]=[ym]$" \
  | sed "s/^/CONFIG_/" > $1.old.config
  rm $1.vmlin.tmp

any ideas or suggestions about this segfault problem?

thanks,
-- 
~Randy

