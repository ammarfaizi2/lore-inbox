Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWILU7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWILU7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWILU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:59:00 -0400
Received: from mail.tmr.com ([64.65.253.246]:7300 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1030201AbWILU67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:58:59 -0400
Message-ID: <45072138.5040207@tmr.com>
Date: Tue, 12 Sep 2006 17:06:00 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
References: <20060908031422.GA4549@lists.us.dell.com> <20060908155639.GJ28592@redhat.com> <20060908161817.GA12642@lists.us.dell.com> <1157734517.30730.103.camel@laptopd505.fenrus.org> <4505BAA6.20002@tmr.com> <20060912030848.GA18381@lists.us.dell.com>
In-Reply-To: <20060912030848.GA18381@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:

>On Mon, Sep 11, 2006 at 03:36:06PM -0400, Bill Davidsen wrote:
>  
>
>>Arjan van de Ven wrote:
>>    
>>
>>>Maybe the kernel's initial ordering should do a numeric sort by mac
>>>address or something.. (or userspace should)
>>>
>>>      
>>>
>>That wouldn't match any existing setup, and would be subject to mid-list 
>>insertions if a NIC were added/replaced. And that is fragile.
>>
>>I was looking for an easy way to do PCI slot to MAC, and from there MAC 
>>to IP, so any NIC plugged into a given slot could be called eth0 (for 
>>instance) and given the "right" IP address, but that's not easy. Can be 
>>done with some searching in /sys, but it's non-trivial.
>>    
>>
>
>So, I did almost this in
>userspace. http://linux.dell.com/files/name_eths/.  It uses the PCI
>IRQ Routing table to determine if a PCI device is embedded on the
>motherboard, or is in an add-in slot, and if so, which slot.  It
>orders the list of thereby possible PCI NICs with all the embeddeds
>first, in ascending PCI breadth-first order, then orders all the
>add-in NICs in PCI slot number ascending order, subsort PCI
>breadth-first for those nifty multiport cards.  It rewrites
>modprobe.conf to load network drivers 'proper' order and outputs an
>/etc/mactab file that can be used by the second half of the script to
>write HWADDR lines into Red Hat-style ifcfg-eth* files, and into
>openSuSE udev ethernet rules file.
>  
>
I am not (generally) concerned with the embedded NICs, it's the slots I 
have had bite me. I do see what you're doing, although I didn't do it 
quite the same way.

>This works great, until you add another NIC into an add-in slot
>somewhere in the middle (e.g. you have 2 embedded NICs eth0 and eth1,
>and a NIC card in PCI slot 4 eth2, then at some later point you add a
>NIC card into PCI slot 2).  You either have to manually configure a
>name for the new card, or run name_eths again and expect the NIC in
>PCI slot 2 to become eth2, and the one in slot4 to become eth3.
>  
>
And this is why I want to do a slot to name translation, which may 
result in gaps in the names. That doesn't seem to matter. Then I can put 
a label over the slot, like "public" or "private" and know that adding 
another NIC, or replacing a failed NIC will leave my labels intact.

>The pure C udev helper I'm working on behaves similarly, though would
>negate the need to edit config files, as it assigns a name "on the
>fly" at device discovery time.
>
>For the relatively rare cases of adding a NIC, I'm OK with this.  I
>don't have a better way to handle it, but am open to ideas.
>  
>
You have mine. I tried putting labels on the NIC, but the machine go to 
live timezones away and repairs are done by whoever has the service 
contract.

>We could assign names like eth-embedded-1, eth-embedded-2,
>eth-slot2-1, eth-slot4-1 if we wanted to change how people think of
>ethernet names (and this would be similar to how large network
>switches work: blade N, port M.  We've got 15 usable chars in the name
>after all...
>
Opens the door for change, for sure. Since I have had to use multi-drop 
NICs and nameset like e_slot1_jack2 is an interesting concept. Or 
perhaps just append the jack index no matter how many connections it 
has. So eth2-0 would be a NIC and socket. Then when I run out of slots 
and have to go to a two or four post card, the primary name wouldn't change.

Your idea has just enough usefulness to be dangerous ;-) Thanks.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

