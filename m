Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262140AbSIZCZL>; Wed, 25 Sep 2002 22:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262142AbSIZCZL>; Wed, 25 Sep 2002 22:25:11 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:34744 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S262140AbSIZCZK>; Wed, 25 Sep 2002 22:25:10 -0400
Date: Wed, 25 Sep 2002 19:30:41 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and
  usb
To: Andi Kleen <ak@suse.de>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org, greg@kroah.com, mochel@osdl.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <3D927151.7000709@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020925212955.GA32487@kroah.com.suse.lists.linux.kernel>
 <3D9250CD.7090409@pacbell.net.suse.lists.linux.kernel>
 <p73k7l9si6p.fsf@oldwotan.suse.de> <20020925174612.A13467@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>+	envp[i++] = scratch;
>>>>+	scratch += sprintf (scratch, "PCI_ID=%04X:%04X",
>>>>+			    pdev->vendor, pdev->device) + 1;
>>>
>>>And so forth.  Use "snprintf" and prevent overrunning those buffers...
>>
>>Hmm? An %04X format is perfectly bounded.

Which was my thought when I originally wrote the code which has been
widely cut'n'pasted.  Safe enough at that moment, but it's now become
dangerous to leave that around as a copy/paste coding example.

Those code fragments are now being used in contexts that aren't
as controlled as the original:  the code _using_ the buffer is no
longer in charge of allocating it.  There's no longer any way to
guarantee that adding the next parameter to the environment isn't
going to overrun the available space.

Except by using "snprintf" and tracking how much space is left.

Easy enough to do, and that's a habit that IMO _everyone_ should
be getting into whenever they program in languages that permit
such buffer overflows.


> Technically, it isn't bounded.  The field will expand if the value exceeds
> 4 digits.  
> 
> However, these values can't do that.  At least not now.
> 
> But, as a good programming practice, snprintf should be used.  Heck, PCI
> 3.0 might use 32-bit vendor and device values, instead of 8 bit.  So, if
> nothing else, do it as insurance for the future.

And to help ensure that as people continue to copy/paste code from the
core hotpluggable systems, they won't break things when they add the
parameters needed to set up their new subsystem or class, using the
/sbin/hotplug mechanism.

- Dave




