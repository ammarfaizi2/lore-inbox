Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSJXUgv>; Thu, 24 Oct 2002 16:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSJXUgv>; Thu, 24 Oct 2002 16:36:51 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:54255 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S265636AbSJXUgl>; Thu, 24 Oct 2002 16:36:41 -0400
Message-ID: <3DB85BFC.2080009@mvista.com>
Date: Thu, 24 Oct 2002 13:45:48 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
References: <200210242002.g9OK27W03864@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James
Some responses below:

James Bottomley wrote:

>sdake@mvista.com said:
>  
>
>>I plan to produce a now patch that dumps the filesystem interface and
>>replaces it with driverfs files in /sys/bus/scsi.  These things take
>>time, but I hope to be  finished by October 25th. 
>>    
>>
>
>OK, that's good, thanks.
>
>  
>
>>The current remove interface is unmaintained, doesn't contain locking,
>> and requires laborious string processing resulting in slow results.
>>    
>>
>
>It is maintained (well, I was planning on looking after it).  The locking can 
>be added (the 1st part of your patch).  It does two in kernel strncmps.  
>That's not really slow by most definitions.
>  
>
The locking most definately needs to be added to the kernel.  I'm 
surprised the original
patch didn't contain any locking, but then again, my first patch didn't 
either :)

>  
>
>>Further there is  no usage information (which means the usage must
>>come by looking at  drivers/scsi/scsi.c which is beyond most typical
>>users).
>>    
>>
>
>I don't really think it's the job of the kernel to conatin usage information.  
>That's the job of the user level documentation.
>  
>
I've gotten mixed feedback on this.  I'll add you to the list that 
doesn't like this.

perhaps it should be removed (even though it takes up minimal memory).

>  
>
>>Imagine scanning each disk in driverfs looking at its WWN attribute
>>(if  it has one) until a match is found.  Assume there are 16 FC
>>devices.  That is  several hundred syscalls just to complete one
>>hotswap operation. 
>>    
>>
>
>Why is speed so important?
>  
>
Telecoms and Datacoms have told me in numerous conversations that a hotswap
operation should occur in 20msec.  I've arbitrarily set 10msec as my 
target to
ensure that I meet the worse-case bus-is-loaded responses during scans, etc.

I can't mention the names of the telecoms, but several with 10000+ employees
have mentioned it.

>  
>
>>This requires the adaptor to maintain a mapping of WWNs to SCSI IDs,
>>however, this is already required by most FibreChannel firmware I've
>>seen (and hence is available  in the driver database already). 
>>    
>>
>
>There will be a point where for a large number of drivers, a linear scan even 
>in the kernel will be slower than a good DB lookup in userspace.
>  
>
This may be true, but most systems will only have at most 4-5 devices. 
 Theres only
so much room on PCI for FC devices :)

>  
>
>>Hotplugs on FibreChannel don't trigger "events".  What they can do is
>>LIP (loop initialization procedure) if the device has been configured
>>in it's SCSI code pages to  do such a thing.  Since this is device
>>specific I'd hate to rely on it for hotswap. 
>>    
>>
>
>They don't now, but they should.  The LIP protocol makes the FC driver aware 
>of the gain or loss of devices.  This should be communicated to the mid-layer 
>and then trigger a hotplug event.  Someone needs to write this, I was just 
>wondering if you might.
>  
>
I like the idea and it was something I was considering for early next 
year.  Its driver
dependent and until a FC driver is in the kernel, theres not much point 
yet :)

Keep in mind also that a LIP is not always generated on an insertion and 
isn't generated
on a removal at all.  This makes insertion easy but removal still 
requires user intervention.

In Advanced TCA (what spawned this work) a button is pressed to indicate 
hotswap removal
which makes for easy detection of hotswap events.  This is why there are 
kernel interfaces
for removal and insertion (so a kernel driver can be written to detect 
the button press
and remove the devices from the os data structures and then light a blue 
led indicating
safe for removal).

>  
>
>>I think this would be too slow.  10 msec for my entire hotswap is
>>available.  If you calculate 2msec for the actual hotswap disk
>>operation, that leaves 8 msec for the rest of the mess.  Scanning
>>through tables or scanning tens or hundreds of files through hundreds
>>of  syscalls may betoo slow. 
>>    
>>
>
>Where does the 10ms figure come from?
>  
>
See above

Thanks James for reading the code and giving comments!

>James
>
>
>
>
>  
>

