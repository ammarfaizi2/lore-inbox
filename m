Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbSJOVkA>; Tue, 15 Oct 2002 17:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264926AbSJOVkA>; Tue, 15 Oct 2002 17:40:00 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:13818 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264927AbSJOVj5>; Tue, 15 Oct 2002 17:39:57 -0400
Message-ID: <3DAC8D23.10100@mvista.com>
Date: Tue, 15 Oct 2002 14:48:19 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <3DAC685B.9070102@metaparadigm.com> <3DAC6C7B.1080205@mvista.com> <20021015203423.GI15864@kroah.com> <3DAC7EAA.5020408@mvista.com> <20021015205402.GL15864@kroah.com> <3DAC839F.7060301@mvista.com> <20021015211651.GM15864@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Tue, Oct 15, 2002 at 02:07:43PM -0700, Steven Dake wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>On Tue, Oct 15, 2002 at 01:46:34PM -0700, Steven Dake wrote:
>>>
>>>
>>>      
>>>
>>>>The data/telecoms I've talked to require disk hotswap times of less then 
>>>>20 msec from notification of hotwap to blue led (a light used to 
>>>>indicate the device can be removed).  They would like 10 msec if it 
>>>>could be done.  This is because of how long it takes on a surprise 
>>>>extraction for the hardware to send the signal vs the user to disconnect 
>>>>the hardware.
>>>>  
>>>>
>>>>        
>>>>
>>>But what starts the "notification of hotswap"?  Is this driven by the
>>>user somehow, or is it a hardware event that happens out of the blue?
>>>
>>>
>>>      
>>>
>>In the case of Advanced TCA, an IPMI message is sent to the CPU blade 
>>indicating the hotswap button is pressed on the front panel of a disk 
>>blade.  The hotswap manager software unmaps the GA address, removes the 
>>device from the linux kernel via the scsi-hotswap-main stuff, and sends 
>>another IPMI message to the disk node telling it to light its "blue 
>>led".  The user removes the disk.  Insertion is easier.
>>    
>>
>
>So if userspace gets the event that a button was pressed, it can decide
>to light up the led after is spins the disk down, right?
>  
>
The userspace app of some sort should light up the led after its call to 
scsi hotswap remove.  I believe the correct thing to do is that the scsi 
hotswap kernel code should spin down the disk (which it doesn't do 
today) since its a function of the bus protocol to spin up/down disks.

>  
>
>>In this case, the hotswap button on the front panel is used to indicate 
>>a hotswap event.  There is talk of making the removal of the board 
>>indicate a hotswap event (surprise extraction) because the technicians 
>>don't wait for the blue led to remove the boards occasionally and the 
>>system should be able to handle this use case.
>>    
>>
>
>Hotplug PCI works much the same way.  A user could just walk up, pop the
>slot, and pull out the card without waiting for the LED to go out.  We
>don't care about that, as the user was obviously stupid in doing such a
>thing.  The spec even states something like this :)
>  
>
unforutnately those picky telecoms want exactly this type of thing to 
not cause system crashes.  Evil I say.  The bad user should just be 
smacked with a clue-by-4.

>  
>
>>>>For legacy systems such as SAFTE hotswap, polling through sg at 10 msec 
>>>>intervals would be extremely painful because of all the context 
>>>>switches.  A timer scheduled every 10 msec to send out a SCSI message 
>>>>and handle a response if there is a hotswap event is a much better course.
>>>>  
>>>>
>>>>        
>>>>
>>>What generates the hotswap event?
>>>
>>>
>>>      
>>>
>>In the case of SAFTE, a SCSI processor (ASIC) is polled by some polling 
>>interval about the state of the SAFTE (SCSI) backplane.  When the state 
>>changes, software generates a hotswap event and removes the device.
>>    
>>
>
>So polling can be done within the kernel, right?  Then notify userspace
>of the event, which can decide what to do.  Sound ok?
>  
>
This is what I planned to do with the drivers/scsi/sp.c code or perhaps 
do the hotswap directly.  This is in my work queue for sometime in 
December so I've not thought about it much yet :)

>Or do you think this should be like the pci hotplug code, in that when a
>slot is opened (or button pressed, depending on the hardware), the
>kernel should scramble as fast as possible to unload the driver, and
>shut down the power to the card?  Then when it is finished, notify
>userspace of what just happened.
>
I think if there isn't polling from userland, response times of 20msec 
can be obtained for disk devices.  In our case, the backplane only has 
serial connections so there isn't a typical driver controlling the 
interface.  They are talking about adding support for PCI Express (3gio) 
to the PICMG3 spec, so this may become an issue in which case unloading 
the driver could probably happen from userland or kernel although kernel 
would probably give better response times.  I've not thought about it 
much since PCI Express seems a long way out.

I know our PICMG 2.12 driver unloads PCI drivers controlling cPCI 
backplane devices via a userspace daemon that retrieves a hotswap event 
via a kernel event manager, turns off the interface (in the case of 
networking) and unloads the driver if there are no more devices 
controlled by it.

In the case of SAFTE there is no event-driven hotswap (hotswaps are 
driven by a poll routine) so a userland poll for hotswap removal 
wouldn't work and this is probably better serviced by a kernel 
thread/timer of some sort.  PCI is a whole nother beast which I'll leave 
to the PICMG2.12 experts and PCI hotplug experts (you) :)

Safte is a pretty old technology and I'm only working on it because some 
platforms I support have a build in SAFTE ASIC.  

>
>thanks,
>
>greg k-h
>
>
>
>  
>

