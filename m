Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWEPFDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWEPFDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 01:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWEPFDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 01:03:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:16368 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751290AbWEPFDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 01:03:40 -0400
Message-ID: <44695D2A.9080705@am-anger-1.de>
Date: Tue, 16 May 2006 07:03:38 +0200
From: Heiko Gerstung <heiko@am-anger-1.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060509)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug related to bonding
References: <44684B60.1070705@am-anger-1.de> <20060516045332.GN11191@w.ods.org>
In-Reply-To: <20060516045332.GN11191@w.ods.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:25672344472c4ac2bbe53bd9833f99fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning/afternoon/evening (please choose your favourtite time of
day:-))!

Willy Tarreau wrote:
> Hi,
>
> On Mon, May 15, 2006 at 11:35:28AM +0200, Heiko Gerstung wrote:
>   
>> Hi!
>>
>> I am at a total loss with this one.  My vanilla 2.4.32 crashes when I
>> try to use bonding together with my rtl8150 based (USB-Ethernet) NICs.
>> If this is a known error, I apologize for bothering the list and would
>> appreciate any pointers to a working solution/workaround.
>>
>> Reproduce:
>> # modprobe bonding mode=1 miimon=100 maxbonds=4
>> # ifconfig bond0 172.16.10.111 netmask 255.255.255.0 up
>> # ifenslave bond0 eth1 eth2
>> Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)
>> bonding: MII link monitoring set to 100 ms
>> 00:60:6E:30:07:Scheduling in interrupt
>> kernel BUG at sched.c:564!
>> invalid operand: 0000
>> CPU:     0
>> EIP:      0010:[<c011461d>]    Not tainted
>> EFLAGS:  00010282
>> ...(following the CPU registers and Call Trace)....
>>     
>
> It looks like what causes trouble is the link state monitoring. Please
> try to disable 'miimon' just to ensure that it does not crash. If it
> does not crash, a quick workaround would be to use another network
> driver/card, but a good fix would be to send us the complete oops and
> its decoding through ksymoops.
>
> In the mean time, if you absolutely need to use this card and the link
> monitoring, you might use the ARP monitoring instead. Just point it to
> a valid IP on the same segment to detect its reachability through your
> NICs.
>   

Thank you very much for the hint. I was able to track this down to the
driver which seems to crash when trying to serve a ETHTOOL_GSET ioctl
from the bonding driver. When I comment that out, it does not crash
anymore but then there is link detection available, of course.

>> Please let me know which details I have to provide from the bug message
>> (I have to type it in manually, no copy'n'paste possible:-)).
>>     
>
> If you can use a serial console, it will help you. If you don't have
> enough time to copy it by hand, boot with 'panic=180' to get 3 minutes
> before the automatic reboot. It is very important to get the other
> registers, and particularly the stack dump to know what function called
> schedule().
>   

Another nice hint, but unfortunately the device I have to deal with has
no serial ports available.
>> It is not clear to me whether this is a bug in the bonding module, in
>> the network driver or in the kernel itself.
>>     
> Possibly both. The bonding driver checks the link status regularly through
> the use of MII ioctls. It's possible that the driver does nasty things during
> this call.
>   
For me it looks like the driver (rtl8150.c) seems to always call
"copy_to_user" when it handles such a ETHTOOL_GSET call. I would assume
that this causes trouble when the bonding module uses the ioctl, because
there is no userspace memory that has to be addressed in such a case.
Mmmh, it should find out from the pointer (I get with the ETHTOOL ioctl)
if this is kernelspace or userspace and then call copy_to_user only if
applicable.

Anyone here who can tell me how to handle this (or point me to a driver
which already does that)?
>> All 2.6.x kernels I tried worked fine, but I am currently bound to a
>> 2.4.x kernel and all 2.4.x kernels I tried (2.4.20, 2.4.29) showed
>> similiar problems when activating bonding.
>>     
>
> That's interesting, I'll try to diff the bonding driver between 2.4 and
> 2.6. For info, I have multiple production machines running it on 2.4 with
> e1000 and tg3 drivers which never had a single problem during years of
> uptime.
>   
We had a number of problems with bonding and that particular driver, but
we are bound to it due to hardware design decisions. For instance, in a
2.4.20 driver the kernel crashed when we used NET-SNMP to get the
interface statistics for the bond0 interface.

Thanks again for your support,
kind regards,
Heiko


