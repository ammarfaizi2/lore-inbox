Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWHAPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWHAPxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWHAPxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:53:42 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:22198 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751651AbWHAPxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:53:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GcJPsbGPytN7sP9gohu4GjRraBrvK678KY7qy3nbhpG9iHTTWGkjJTrj7xg1cvcYyoRNW0fozJv66L+DqpmBvumci2WfkUl1mTjy50E+HwzjvgX2ONOyFFLmVH4lFsymzeSHqhKnUEnhwVoTkmKRFxoot3EHDkwu7DK9p32/Kjo=
Message-ID: <44CF7914.8000705@gmail.com>
Date: Tue, 01 Aug 2006 09:53:56 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Ben Dooks <ben@fluff.org>
CC: Robert Schwebel <r.schwebel@pengutronix.de>, Chris Boot <bootc@bootc.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <20060730220200.GB8907@home.fluff.org>
In-Reply-To: <20060730220200.GB8907@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> On Sun, Jul 30, 2006 at 03:08:11PM +0200, Robert Schwebel wrote:
>   
>> Chris,
>>
>> On Fri, Jul 28, 2006 at 09:44:40PM +0100, Chris Boot wrote:
>>     
>>> I propose to develop a common way of registering and accessing GPIO pins on 
>>> various devices.
>>>       
>> I've attached the gpio framework we have developed a while ago; it is
>> not ready for upstream, only tested on pxa and has probably several
>> other drawbacks, but may be a start for your activities. One of the
>> problems we've recently seen is that for example on PowerPCs you don't
>> have such a clear "this is gpio pin x" nomenclature, so the question
>> would be how to do the mapping here.
>>     
>
> Right, my $0.02 worth:
>   

$2.00 at least.
I have a patch which adds a sysfs interface much as youve described below.
an old version of patch is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115324483926147&w=2
Its far from complete, but I think it belongs in this discussion !

> 1) The system does not currently allow for other GPIO sources
>    than the CPU. There are a variety of GPIOs, that could come
>    from expansion chips, on board CPLDs, etc.
>
>   
Im not sure what you mean here -
the above patch manages to add a sysfs-gpio interface to 2 drivers: 
scx200_gpio, and pc8736x_gpio.

ISTM that you've described a limitation of Robert Schwebel's patch,
since his examples use a single path in sysfs.

+	  Or to stop the motor again:
+	   $ echo 1 > /sys/class/gpio/gpio63/level


Heres my sysfs-gpio interface, which obviously covers both drivers:

soekris:/sys/devices/platform# ls *.0/bit_0.0_*
pc8736x_gpio.0/bit_0.0_current_output  scx200_gpio.0/bit_0.0_current_output
pc8736x_gpio.0/bit_0.0_debounced       scx200_gpio.0/bit_0.0_debounced
pc8736x_gpio.0/bit_0.0_locked          scx200_gpio.0/bit_0.0_locked
pc8736x_gpio.0/bit_0.0_output_enabled  scx200_gpio.0/bit_0.0_output_enabled
pc8736x_gpio.0/bit_0.0_pullup_enabled  scx200_gpio.0/bit_0.0_pullup_enabled
pc8736x_gpio.0/bit_0.0_status          scx200_gpio.0/bit_0.0_status
pc8736x_gpio.0/bit_0.0_totem           scx200_gpio.0/bit_0.0_totem
pc8736x_gpio.0/bit_0.0_value           scx200_gpio.0/bit_0.0_value
soekris:/sys/devices/platform#


Robert, sysfs seems to populate lots of symlinks underneath /sys,
do any of them give a device-centric organization that lets you address 
separate devices ?




> 2) The GPIO configuration from my last thought experiment have the
>    following properties for each pin:
>
>    input:
> 	- input
> 	- inverted input
>
>    output:
> 	- normal output
> 	- inverted output
> 	- tristatable output
> 	- open collector (can only pull to zero)
> 	- open emmitor (can only pull to high)
>
>    The allowance of inverted outputs, is very useful to allow
>    drivers to assume either '0' or '1' is an active signal, allowing
>    per-board fixups when the designer suddely decides the best way
>    of connecting device A to B is via a spare inverter...
>
>    The other way would be to allow the mapping of '0' and '1' states
>    to either of the states:
>
> 	- output 1
> 	- output 0
> 	- tri-state
>
>    The classing of tri-state as a seperate from input, is in case the
>    hardware does not see input as a valid state, or that input and
>    output are somehow different. 
>   
>    pull resistor:
> 	- tristate (no resistor)
> 	- pull low
> 	- pull high
>
>    The input and output are seperate, assuming that there is the
>    possiblity the system can read back the line even if the GPIO
>    is set as an output.
>
>   
heres how Im doing it..

struct gpio_attributes {
        struct sensor_device_attribute_2 value;
        struct sensor_device_attribute_2 curr;
        struct sensor_device_attribute_2 output_enabled;
        struct sensor_device_attribute_2 totem_pole;
        struct sensor_device_attribute_2 pullup_enabled;
        struct sensor_device_attribute_2 debounced;
        struct sensor_device_attribute_2 locked;
        struct sensor_device_attribute_2 status;
};



> 3) The sysfs interface should be configurable, as systems
>    with lots of GPIO would end up with large numbers of
>    files and directories in sysfs.
>
>   
static int nobits = 0;
module_param(nobits, int, 0);
MODULE_PARM_DESC(nobits, "nobits=1 to suppress sysfs bits interface");

static int noports = 0;
module_param(noports, int, 0);
MODULE_PARM_DESC(noports, "noports=1 to supress sysfs ports interface");


> 4) you probably want to ensure pull-up resistors are off if the
>    output is being driven. 
>
>   

Sounds smart.  Is there any reason to make it overrideable ?


thanks
-jimc
