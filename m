Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbTJKBzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 21:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbTJKBzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 21:55:47 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:2689
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263209AbTJKBzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 21:55:44 -0400
Date: Fri, 10 Oct 2003 21:55:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Mock <kd6pag@qsl.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, bcollins@debian.org
Subject: Re: slab corruption of hpsb_packet from ohci1394 + sbp2 on 2.6.0-test7
In-Reply-To: <E1A86t4-0001rj-00@penngrove.fdns.net>
Message-ID: <Pine.LNX.4.53.0310102125580.15705@montezuma.fsmlabs.com>
References: <E1A86t4-0001rj-00@penngrove.fdns.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003, John Mock wrote:

> I've also reproduced a problem noted by Alastair Tse in 2.6.0-test5-mm3
> on a Sony R505EL laptop with 2.6.0-test7, as documented in Bugzilla at:
> 
>     http://bugzilla.kernel.org/show_bug.cgi?id=1258
> 
> For me, this has been a longstanding problem, with 2.4.19 being the only 
> kernel that i've found which with i can write data CD's.  I can make this
> happen by logging in as 'root' immediately after booting and request the
> loading of 'ohci1394'.  About 3-10 seconds later, it fails as shown below:
> 
>     tvr-vaio:~# modprobe ohci1394
>     ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
>     ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[e0205000-e02057ff]  Max
> Packet=[2048]
>     tvr-vaio:~# sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
>     scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
>     ieee1394: sbp2: Logged into SBP-2 device
>     Slab corruption: start=cd594718, expend=cd594777, problemat=cd594748
>     Last user: [<d0b7314c>](free_hpsb_packet+0x2c/0x40 [ieee1394])
>     Data: ************************************************D5 D6 D6 D6 01 00 00
> 00 ***************************************A5
>     Next: 71 F0 2C .4C 31 B7 D0 71 F0 2C .....................
>     slab error in check_poison_obj(): cache `hpsb_packet': object was modified
> after freeing

0xcd594748 - 0xcd594718 = 0x30

gdb) p ((struct hpsb_packet *)0)->state_change
Cannot access memory at address 0x30

So someone is doing a down/up on the state_change semaphore after it's 
freed...

> Details are also available via bugzilla, as noted above.  Here are quick 
> links to my attachments therein:
> 
>     dmsg:	http://bugzilla.kernel.org/attachment.cgi?id=1023
>     .config:	http://bugzilla.kernel.org/attachment.cgi?id=1024
> 
> (And yes, if you look carefully, you'll see i'm still trying to sort out
> the forking of suspend to disk. *sigh*)
> 
> Any clues on how to track this problem down would be greatly appreciated!
> (Please CC: such replies, as i'm reading via WWW rather than subscribing.)

The state change synchronization is rather weird in that driver, then 
there is the whole double semaphore acquisition business which i'm not 
quite sure of. It looks better suited to a struct completion, but that is 
the source of your problem. This would be better handled by the 
maintainer.

