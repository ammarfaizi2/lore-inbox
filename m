Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSBOW4v>; Fri, 15 Feb 2002 17:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292253AbSBOW4b>; Fri, 15 Feb 2002 17:56:31 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:3311 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S284970AbSBOW4a>;
	Fri, 15 Feb 2002 17:56:30 -0500
Date: Fri, 15 Feb 2002 15:51:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020215155143.I14054@lynx.adilger.int>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Ben Greear <greearb@candelatech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213180951.12448L-100000@gatekeeper.tmr.com> <Pine.LNX.4.33L2.0202140836210.1530-300000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0202140836210.1530-300000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Thu, Feb 14, 2002 at 08:48:55AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 14, 2002  08:48 -0800, Randy.Dunlap wrote:
> gziphdr=`binoffset $1 0x1f 0x8b 0x08 0x0`
> # increment by 1 since tail offsets are 1-based, not 0-based
> gziphdr=$((gziphdr + 1))
> 
> tail -c +$gziphdr $1 | gunzip > $1.tmp
> strings $1.tmp | grep CONFIG_ > $1.old.config
> rm $1.tmp

How about something like the below (avoids writing a multi-MB temp file):

HDR=`binoffset $1 0x1f 0x8b 0x08 0x0`
dd if=$1 bs=1 skip=$HDR | zcat | strings /dev/stdin | grep CONFIG_

Note also that it is enough to store the config options without the
leading CONFIG_ part, and then use 'grep "[A-Z0-9]*=[ym]$"' to get
the actual config strings.  You can add a final 'sed "s/^/CONFIG_/"'
step to return it to the original format.  So:

dd if=$1 bs=1 skip=$HDR | zcat | strings /dev/stdin | grep "[A-Z0-9]=[ym]$" \
	| sed "s/^//CONFIG_"

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

