Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTBHUI6>; Sat, 8 Feb 2003 15:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTBHUI6>; Sat, 8 Feb 2003 15:08:58 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:48912 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267083AbTBHUI4>;
	Sat, 8 Feb 2003 15:08:56 -0500
Message-ID: <3E45661A.90401@mvista.com>
Date: Sat, 08 Feb 2003 14:18:34 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
In-Reply-To: <m1isvuzjj2.fsf@frodo.biederman.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>Corey Minyard <cminyard@mvista.com> writes:
>  
>
>>Eric,
>>
>>I saw that you are working on kexec.  I'm using and have hacked on a similar
>>piece of software named bootimg (and I'll be glad when yours is done and ready
>>and we can jettison bootimg).  From the looks of the code, it looks like you
>>have seen bootimg, too.  I looked through your patch, and I noticed a few
>>things.  Hopefully it's the newest version of the patch.
>>
>>First was that you don't turn of DMA bus masters.  There seemed to be some
>>discussion of this on lkml, but I didn't see anything in the patch for it.  We
>>are actually having problems with bootimg and DMA bus master devices, so the
>>problem is real.  And turning of DMA bus mastering for everything on the PCI bus
>>didn't seem to work, Ken Sumrall tried it, and at least the device in question
>>(a bcm5700) seemed to ignore the bit.  We are looking at adding an ioctl or a
>>notifier list that will allow devices to register non-blocking calls to shut off
>>DMA.  Is anything like that under consideration, or are you thinking of using
>>the reboot notifier for this, or what?
>>    
>>
>
>The reboot notifier + device->shutdown(), are called.  As you have noted
>the problem is not as easy as clearing the bus master bit, so I leave it
>up to the device driver.  The device driver is responsible for placing
>the device into a quiescent state.
>
>Generally that code is present in the driver somewhere already, as it
>is needed for the rmmod case.   
>
>In addition going through the normal shutdown path, downing interfaces
>etc, usually helps as well.
>
>So for when kexec is not used in a panic case this is easy.
>
The panic case is actually the most interesting for us.  We are using 
bootimg with the MCL coredump to take a kernel core to memory and pick 
it up on the next boot.  You cannot call most shutdown() functions from 
a panic, since they will block.

>>The patch doesn't make sure it is running on processor zero for SMP machines.
>>You must do this on x86 machines, the kernel assumes it comes up on processor
>>zero.  I assume this is true for other machines, too.
>>    
>>
>
>I have a secondary patch.  kexec-hwfixes, that does this.  I am I need to review
>it a little closer and make certain the code is clean enough to go into
>the general purpose kernel.  But I do have the code.
>
I have code that does this for bootimg, too, if you are interested, and 
it has received extensive testing.

>>Hopefully I'm not looking at an old version of the patch, but these are
>>important things you need to handle.
>>    
>>
>
>Yep.  I am a little scatter brained on the maintenance side but I am handling
>them all.
>
>If you are after the kexec on panic case that is much, more
>interesting because it is quite possible we cannot afford to call some
>of those functions.  But I am quite willing to discuss and work with
>people on what is really going on.  
>
>For any more conversation though can we please cc linux-kernel?
>
>I like to keep things public so I don't have to answer the same
>question too many times.
>
No problem.  As you have requested, lkml is copied.

Thanks,

-Corey

