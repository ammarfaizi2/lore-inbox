Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbULGHu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbULGHu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 02:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbULGHu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 02:50:58 -0500
Received: from main.gmane.org ([80.91.229.2]:17618 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261779AbULGHu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 02:50:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: 2.6.10-rc[2|3] protection fault on /proc/devices
Date: Tue, 07 Dec 2004 08:50:15 +0100
Message-ID: <41B560B7.9080300@gmx.net>
References: <41B4E70F.8040306@gmx.net> <20041206234044.51667e94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81.223.124.22
User-Agent: Mozilla Thunderbird 0.9 (X11/20041128)
X-Accept-Language: en-us, en
In-Reply-To: <20041206234044.51667e94.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Georg Schild <dangertools@gmx.net> wrote:
> 
>>Since 2.6.10-rc2 I am having problems accessing /proc/devices. On 
>>startup some init-skripts access this node and print out a protection 
>>fault. i am having this on pcmcia and swap startup. My system is an 
>>amd64 @3000+ in an Acer Aspire 1501Lmi at 64bit mode running gentoo. 
>>.config is the same as on 2.6.10-rc1 which works good. cat on 
>>/proc/devices gives the same problems. The kernel has just a patch for 
>>wbsd (builtin mmc-cardreader) from Pierre Ossman in use, everything else 
>>is vanilla. Does anyone know of this issue and perhaps on how to solve this?
>>
>>Regards
>>
>>Georg Schild
>>
>>
> 
> 
> How odd.  All I can think is that something has registered a zillion
> devices and get_blkdev_list() has run off the /proc page.  But then, it
> should have oopsed in sprintf()..
> 
> Still.  Please send a copy of your /proc/devices from 2.6.10-rc1 and also
> apply this:
> 
> --- 25/drivers/block/genhd.c~a	2004-12-06 23:31:13.677476528 -0800
> +++ 25-akpm/drivers/block/genhd.c	2004-12-06 23:31:30.539913048 -0800
> @@ -48,9 +48,11 @@ int get_blkdev_list(char *p)
>  
>  	down_read(&block_subsys.rwsem);
>  	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
> -		for (n = major_names[i]; n; n = n->next)
> -			len += sprintf(p+len, "%3d %s\n",
> +		for (n = major_names[i]; n; n = n->next) {
> +			if (len < PAGE_SIZE / 2)
> +				len += sprintf(p+len, "%3d %s\n",
>  				       n->major, n->name);
> +		}
>  	}
>  	up_read(&block_subsys.rwsem);
>  
> _
> 
> to 2.6.10-rc3 and see if that fixes it.  If so, please send the
> /proc/devices content from this kernel.
> 
> Beyond that, perhaps something scribbled on the data structures in there. 
> Setting CONFIG_SLAB_DEBUG and/or CONFIG_DEBUG_PAGEALLOC might turn
> something up.

Okay, here the output of /proc/devices on 2.6.10-rc1. I will apply the 
patch and see if it works.

regards

Georg Schild

> Character devices:
>   1 mem
>   2 pty
>   3 ttyp
>   4 /dev/vc/0
>   4 tty
>   4 ttyS
>   5 /dev/tty
>   5 /dev/console
>   5 /dev/ptmx
>   6 lp
>   7 vcs
>  10 misc
>  13 input
>  14 sound
>  21 sg
>  29 fb
>  81 video4linux
>  89 i2c
> 116 alsa
> 128 ptm
> 136 pts
> 161 ircomm
> 162 raw
> 171 ieee1394
> 180 usb
> 202 cpu/msr
> 203 cpu/cpuid
> 216 rfcomm
> 253 devfs
> 254 pcmcia
> 
> Block devices:
>   2 fd
>   3 ide0
>   7 loop
>   8 sd
>  11 sr
>  22 ide1
>  43 nbd
>  65 sd
>  66 sd
>  67 sd
>  68 sd
>  69 sd
>  70 sd
>  71 sd
>  80 i2o_block
> 125 ub
> 128 sd
> 129 sd
> 130 sd
> 131 sd
> 132 sd
> 133 sd
> 134 sd
> 135 sd
> 254 mmc

