Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWHBUsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWHBUsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWHBUsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:48:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:62751 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751345AbWHBUsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:48:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oeERECqU4fw8eMy+ZZXhm8P30mixSsSzdmY6VDu6dmoj7N+uM7+uHSRZhV6CVxfG+ZLgRWwFB9C+zCnI71vJPzkJZ05661XpTfw+TJmBMr3RU8SjFspvavAaf8XqmoS7x24U7ZA8Stp7fwQk8ACmYv0EBkxHbjFE/b3ILEDpNx8=
Message-ID: <44D10FA1.2010206@gmail.com>
Date: Wed, 02 Aug 2006 14:48:33 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Robert Schwebel <r.schwebel@pengutronix.de>, Chris Boot <bootc@bootc.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <44CFC6CC.8020106@gmail.com> <20060802175834.GA13641@csclub.uwaterloo.ca>
In-Reply-To: <20060802175834.GA13641@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Tue, Aug 01, 2006 at 03:25:32PM -0600, Jim Cromie wrote:
>   
>> this is cool to see.  Using a class-driver is very different from the 
>> vtable-approach
>> that I used (struct nsc_gpio_ops) in pc8736x_gpio and scx200_gpio.
>>
>> Are any of the limitation youve cited above related to the 
>> /sys/class/gpio paths below ?
>>
>> +	  To set pin 63 to low (to start the motor) do a:
>> +	   $ echo 0 > /sys/class/gpio/gpio63/level
>> +	  Or to stop the motor again:
>> +	   $ echo 1 > /sys/class/gpio/gpio63/level
>> +	  To get the level of the key (pin 8) do:
>> +	   $ cat /sys/class/gpio/gpio8/level
>> +	  The result will be 1 or 0.
>> +
>> +	  To add new GPIO pins at runtime (lets say pin 88 should be an 
>> input)
>> +	  you can do a:
>> +	   $ echo 88:in > /sys/class/gpio/map_gpio
>> +	  The same with a new GPIO pin 95, it should be an output and at 
>> high level:
>> +	   $ echo 95:out:hi > /sys/class/gpio/map_gpio
>> +
>>     
>
> How do you deal with having multiple places that provide GPIOs then? 

pc8736x_gpio and scx200_gpio appear here:

soekris:/sys/devices/platform# ls pc8736x_gpio.0/
Display all 292 possibilities? (y or n)

soekris:/sys/devices/platform# ls scx200_gpio.0/
Display all 532 possibilities? (y or n)


soekris:/sys/devices/platform# ls scx200_gpio.0/bit_0.0_*
scx200_gpio.0/bit_0.0_current_output  scx200_gpio.0/bit_0.0_pullup_enabled
scx200_gpio.0/bit_0.0_debounced       scx200_gpio.0/bit_0.0_status
scx200_gpio.0/bit_0.0_locked          scx200_gpio.0/bit_0.0_totem
scx200_gpio.0/bit_0.0_output_enabled  scx200_gpio.0/bit_0.0_value


Did you mean to ask that question of Robert ?

I'll rephrase my Q here.

/sys/class/gpio/gpio63/

this suggests that either
- only 1 GPIO device can register (bad)
- reservations might be taken in module-load order, and assigned 
numerically (bad-subtle)

Using another path (like /sys/devices/platform/scx200_gpio.%d/ )
which names the driver (or some other structural info) seems much more
stable in the face of combinations of GPIO hardware.

FWIW, I didnt add the .0 to the directories, I think that was added for 
me by the device-core,
(warmfuzzy) so Id expect it to handle .1,2,3 etc..


>  I
> may have 8 pins on a PCI UART chip, 22 on my super io chip, 16 on my
> cpu, etc.  How would this be mapped if you only have one map_gpio
> method?  It is much simpler to code for knowing pin 0 to 7 of device
> uartgpio is where my UART pins are, and some other device has 22 pins
> for the super io chip.  If they all ended up in one place with
> consequative numbers it would be a real pain.  
>
> Sometimes it is also nice to be able to control multiple pins as a block,
> which only a few gpio interfaces seem to provide (they all seem to think
> they should only be moved one pin at a time, which makes for a lot more
> system calls to get things done).
>   
Both GPIO chips Ive touched have port-wide read and write.
I consider it an essential minimum feature in the driver, for hardware 
that supports it.
Other pin features (OE, etc) are only controllable per-pin.
If we synthesize port-wide from per-pin, then we get a bit/port agnostic 
interface.
( driver users must still be cognizant of the limitations of synthetic 
OutputEnable,
where tri-stating would take many bus cycles )

> Right now I am working on adding some stuff to the jsm driver to use an
> Exar uart along with using the gpios, and so far I added gpio access
> similar to how scx200_gpio does things, using minors 0 to 7 for the 8
> pins on the first uart, 8 to 15 for the second, and so on.  What to name
> the /dev entries is a different issue.  I can identify which device to
> look for based on the /sys info for which pci slot the uart is connected
> to.  I am not sure how this would tie into a generic gpio design.
>
> Does your gpio design 
I want to separate my answers -

- pc8736x_gpio , scx200_gpio went thru mm into mainline-rc - they 
support the legacy gpio-bit
access via char-device-file.  They expose port-wide read/write inside 
the kernel, via struct nsc_gpio_ops,
but it seems a bad idea to expose them as device-files. ;-)

- This thread is about a new interface, I think we're all tacitly 
agreeing on :
    a sysfs based GPIO-attr representation
    some of us want/demand a port-interface where hardware has portwide 
read/write
    a reservation scheme.

- Im working on a patch, which rendered the ls output I pasted above.
    bits_ and ports_ agnostic
    interfaces are nearly identical - its 0/1 vs 0xFF (hw dependent width)
    no reservations yet :-/


> deal with all the things gpios often do:
>   
char-dev interfaces in scx200_gpio 18-rc are compatible with legacy, 
pc87360 is new (and same).
my sysfs-gpio patch actually has a half-baked compatibly hack on the 
_status attr,
platform# more scx200_gpio.0/bit_0.0_status
io00: 0x0044 TS OD PUE  EDGE LO DEBOUNCE        io:1/1

> input/output/tristate
> high/low
>   
not yet on these:  patches/clues welcome.
> generate interrupt
> edge/level trigger
> high or low level/leading or trailing edge trigger
>
> --
> Len Sorensen
>
>   

thanks for the input
Jim Cromie
