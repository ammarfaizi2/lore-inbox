Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWIPRQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWIPRQp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWIPRQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:16:45 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:38712 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964842AbWIPRQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:16:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=V/TmxC4ihxC4vhvcbk5FffCl/Q1Mu1yMD7fCbBPy9yha53sYVomnt1l8dEuBFjEq22MZ7sCRB8Bqt7Mlw1M1wypReJH5iyIIMaWY7UdBqw6BPxBWv/gjEMkQOJySJeenf9x/riJQA2/Yw2L/zRB5B5tp1izjB9hr+7jlYivdQO0=
Message-ID: <450C3199.5030405@gmail.com>
Date: Sat, 16 Sep 2006 11:17:13 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: David Hubbard <david.c.hubbard@gmail.com>
CC: LM Sensors <lm-sensors@lm-sensors.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [lm-sensors] [RFC-patch 0/3] SuperIO locks coordinator
References: <87fyf5jnkj.fsf@willow.rfc1149.net>	 <1157815525.6877.43.camel@localhost.localdomain>	 <20060909220256.d4486a4f.vsu@altlinux.ru> <4508FF2F.5020504@gmail.com>	 <4509D08C.7020901@gmail.com>	 <4dfa50520609141753h34e54fdayba62f1b127d58036@mail.gmail.com>	 <450A54EB.1020305@gmail.com> <4dfa50520609151118s65a980b4td143a9fbbfeb1798@mail.gmail.com>
In-Reply-To: <4dfa50520609151118s65a980b4td143a9fbbfeb1798@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hubbard wrote:
> Hi Jim,
>
>> BTW, are the idle/activate sequences doc'd in your datasheet ?
>> I ask this cuz pc87360 has a superio-exit defined (and used), but no
>> superio-enter(),
>> and I couldnt find the idle/activate sequences docd in my datasheet.
>> With the long history of copy & modify in these drivers, its possible
>> that some cargo-cult features were inadvertently carried forward,
>> esp when drivers are written w/o actually having the hardare.
>>
>> Could you disable your superio-enter(), and see if that breaks the
>> functionality ?
>
> I'll do that and let you know how it goes. I suspect that the BIOS
> initializes the w83627ehf correctly, 
yes. very likely
> and so the superio-enter and
> -exit that are used may not be required...except during detection. 

Also likely/possible.  Some chips can be told to map their logical 
devices (LDs)
to specific ISA address ranges, then those devices can be largely or 
completely
operated using vanilla IO operations, w/o the superio-port overheads,
and the BIOS often takes care of this, and enables devices that the mobo
is designed to use.

Forex:
6600-660f : pc8736x_gpio
6620-662f : pc87360
6640-664f : pc87360

To complicate things, some LDs have features that are only controllable
via superio, pc8736x GPIO has runtime regs and configuration regs, the 
latter
are only available via superio.  These LDs are much more dependent upon
proper superio locking, vs hwmon/pc87360, which uses vanilla IO after 
detection,
and thus releases the superio-reservation once detection/initialization 
is complete.

FYI - GregKH said this on LKML, re 2.6.19
http://marc.theaimsgroup.com/?l=linux-kernel&m=115778993800623&w=2

	- The driver core was changed to allow multi-threaded device
	  probing.  This means that every device added to the system
	  gets a new kernel thread in which to do the probe sequence.
	  The PCI subsystem was modified to allow PCI drivers to do this
	  (this is made a configuration option, as it breaks numerous
	  boxes if enabled).  It does have the potential to speed up the
	  boot sequence a lot for some machines, and is even measurable
	  on single processor laptops.


This appears to increase the potential of problems related to current 
lack of superio locking,


> The
> w83627ehf is mapped into ISA I/O space (probably by the BIOS). So I'll
> test my theory and get back to you soon.
>
thanks.

> David
>
jimc
