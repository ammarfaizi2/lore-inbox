Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVB1RLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVB1RLq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVB1RLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:11:46 -0500
Received: from ext-nj2gw-6.online-age.net ([64.14.56.42]:65170 "EHLO
	ext-nj2gw-6.online-age.net") by vger.kernel.org with ESMTP
	id S261689AbVB1RLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:11:43 -0500
From: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
To: Valdis.Kletnieks@vt.edu
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Date: Mon, 28 Feb 2005 18:11:27 +0100
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Message-ID: <20050228171127.GA27153@wszip-kinigka.euro.med.ge.com>
References: <cv5hv3$ana$1@gatekeeper.tmr.com> <200502190023.j1J0NBDi023090@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502190023.j1J0NBDi023090@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 01:23:10AM +0100, Valdis.Kletnieks@vt.edu wrote:
> 
>    On Fri, 18 Feb 2005 15:23:44 EST, Bill Davidsen said:
> 
>    > I'll try to build a truth table for this, I'm now working with some
>    > non-iso data sets, so I'm a bit more interested. I would expect read()
>    > to only try to read one sector, so I'll just do a quick and dirty to get
>    > the size from the command line, seek and read.
>    >
>    > I haven't had a problem using dd to date, as long as I know how long the
>    > data set was, but I'll try to have results tonight.
> 
>    The problem is that often you don't know exactly how long the data set is
>    (think "backup burned to CD/RW") - there's a *lot* of code that does stuff
>    like
> 
>            while (actual=read(fd,buffer,65536) > 0) {
>                    ...
>            }
> 
>    with the realistic expectation that the last read might return less than
>    64k,
>    in which case 'actual' will tell us how much was read.  Instead, we just get
>    an error on the read.
> 
>    Note that 'dd' does this - that's why you get messages like '12343+1 blocks
>    read'.
>    We *really* want to get to a point where 'dd' will work *without* having to
>    tell it a 'bs=' and 'count=' to get the size right....
>    )

my point was that even specifying the exact byte count was not sufficient.
e.g

strace sdd if=/dev/zero bs=32k of=/dev/null ivsize=41234    gives:
......
munmap(0x46a000, 4096)                  = 0
_llseek(3, 0, [0], SEEK_SET)            = 0
_llseek(4, 0, [0], SEEK_SET)            = 0
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = 32768
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = 32768
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8466) = 8466
write(2, "sdd: Done with input volume # 1."..., 33sdd: Done with input volume # 1.
) = 33
write(2, "Do you want to continue with inp"..., 53Do you want to continue with input volume # 2 (y/n): ) = 53

that is, it requests exactly ivsize bytes (for iso cd's this can be got from isosize).

even this was not good enough....

Karl

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
