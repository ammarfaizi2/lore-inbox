Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbVKDHT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVKDHT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVKDHT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:19:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:16030 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751416AbVKDHT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:19:56 -0500
Date: Thu, 3 Nov 2005 23:19:32 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: damir.perisa@solnet.ch, akpm@osdl.org
Subject: Re: 2.6.14-rc5-mm1 - ide-cs broken!
Message-ID: <20051104071932.GA6362@kroah.com>
References: <20051103220305.77620d8f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103220305.77620d8f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<apologies for the broken threading>

> [17194333.620000] cs: memory probe 0xf0000000-0xf80fffff: excluding 
> 0xf0000000-0xf87fffff
> [17194333.644000] pcmcia: Detected deprecated PCMCIA ioctl usage.
> [17194333.644000] pcmcia: This interface will soon be removed from the 
> kernel; please expect breakage unless you upgrade to new tools.
> [17194333.644000] pcmcia: see 
> http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for 
> details.
> [17194334.032000] Probing IDE interface ide2...
> [17194334.320000] hde: 1024MB Flash Card, CFA DISK drive
> [17194334.992000] ide2 at 0x4100-0x4107,0x410e on irq 3
> [17194334.992000] hde: max request size: 128KiB
> [17194334.992000] hde: 2001888 sectors (1024 MB) w/1KiB Cache, 
> CHS=1986/16/63
> [17194334.992000] hde: cache flushes not supported
> [17194334.992000]  hde: hde1
> [17194335.004000] ide-cs: hde: Vcc = 3.3, Vpp = 0.0
> [17194335.224000]  hde: hde1
> [17194335.632000]  hde: hde1
> [17194335.736000]  hde: hde1
> [17194335.744000]  hde: hde1
> ... ("hde: hde1" repeating)...
> 
> ok, now the situation is less lethal, but still no proper ide-cs working. 
> there are no unknown symbols now, but the other output in dmesg is the 
> same. especially, the loop to output "hde: hde1" is here, but if i remove 
> the card, it stops and the system is still responsible. 
> 
> i checked something i forgot to check before... is the hde device seen 
> in /sys somewhere, when the card is plugged in. the answer is yes!:
> 
> /sys/block/hde/hde1/
> 
> presents itself fully normal like other ide drives. in 
> /sys/block/hde/hde1/sample.sh 
> i found "mknod /dev/hde1 b 33 1" and tried to run it. successfully!
> the result is: in dmesg, the "hde: hde1" output loop stopped and my card 
> is working again!!! 

Heh, the poor-man's udev worked for someone :)

> so the trouble seems not only (or not at all) related to the kernel but 
> (also) to udev (i use 071), hotplug (mine is 2004_09_23), pcmciautils 
> (010) or something else.
> 
> can somebody tell me, what state of this process (discovering device, 
> loading needed modules, udev creating node under /dev) is the output 
> "hde: hde1" to dmesg and how can it be possible that it loops? 

The problem is in your udev rules.  You are running something in them
that is opening up your ide-cs device, which causes another hotplug
event to happen, which causes udev to run again, and so on.

I suggest you take this up with your distro, they are the ones
responsible for this problem.

Hint, gentoo, debian, and suse don't have this problem, so you might
want to look at their rules files for how to work around this.  Look for
this line:

# skip accessing removable ide devices, cause the ide drivers are horrible broken

and add the rules after it.

> it seems that this chain of processing is stuck somewhere and needs a 
> execution of the command to create the node under /dev by hand to finish.

I think the presence of the node causes udev to not generate another
one, which keeps the rule from being run and another hotplug event from
being generated.

Hope this helps,

greg k-h
