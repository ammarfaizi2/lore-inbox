Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWDMQQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWDMQQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWDMQQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:16:10 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:51602 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751053AbWDMQQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:16:09 -0400
Message-ID: <443E79AD.50505@keyaccess.nl>
Date: Thu, 13 Apr 2006 18:17:49 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       ALSA devel <alsa-devel@alsa-project.org>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl> <20060413145756.GA29959@flint.arm.linux.org.uk>
In-Reply-To: <20060413145756.GA29959@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> On Thu, Apr 13, 2006 at 04:05:33PM +0200, Rene Herman wrote:

>> Not honouring/passing up probe() method error returns, not even -ENODEV, 
>> makes some sense for discoverable busses such as PCI where you at least 
>> have a driver independent bus_id sitting in /sys/devices/pci* that you 
>> can later echo into /sys/bus/pci/drivers/*/bind to make the driver bind 
>> to a device, but not much sense for the platform bus. Platform devices 
>> only "exist" (in /sys/devices/platform) due to the driver creating them 
>> itself and keeping them after failing a probe means that directory 
>> becomes an enumeration of the drivers we loaded, rather than a view of 
>> what's present in the system.
> 
> Incorrect.  In some circumstances, they may be created by architecture
> support code, and might be created and destroyed dynamically by
> architecture support code.

Okay, thanks, that's relevant information. Please explain though what's 
incorrect about the fact that for these ISA devices on the plain old PC, 
with nothing other than the driver available to probe for them, just 
keeping them registered after failing a probe turns 
/sys/devices/platform into a view of "what drivers did we load".

>> The driver model crowd did not seem exceedingly interested in the 
>> problem though:
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=114417829014332&w=2
> 
> Incorrect summary.  The ALSA use model of the driver model doesn't fit
> with the driver model use model.  It's not that we're not interested
> in it - it's that it's perverted to the way driver model folk intend
> the subsystem to work, and the way that platform devices are used on
> some architectures.

And I take it that interest is reflected in getting a grand total of 0 
comments from anyone on my own feeble attempts to suggest things in that 
thread such as the settable flag that would make the driver model pass 
up the error return from probe when set, or having an additional 
.discover method, or ..

M'kay. I believe there's one clean way out of this. We could add an "isa 
bus", where the _user_ would first need to setup the hardware from 
userspace by echoing values into sysfs. Say, something like:

echo -n foo		>/sys/devices/isa0/new
echo -n "io 0x220"	>/sys/devices/isa0/foo/resources
echo -n "irq 5"		>/sys/devices/isa0/foo/resources
echo -n "dma 1"		>/sys/devices/isa0/foo/resources

and so on. The type of resources would be modelled after ISA-PnP (and to 
make them more equal, you could do multiple device id's per bus id, card 
id's, in PNP lingo, but this principle at least)

The driver would them request id "foo" as an agreed upon ID (snd-sb8 
would request "sb8", say) or we could pass in the id as a module parameter.

I actually think this would be Great. Comments? Pitchforks?

 From the driver's standpoint, there would not be a difference with 
ISA-PnP anymore other than ISA-PnP also providing for the possibilty to 
change them -- something which ALSA also uses, but which it should 
probably not; has annoyed me for some time. We could then in fact also 
integrate this into ISA-PnP itself, using PnP-like device IDs and all, 
so that from the driver's standpoint, it _is_ always speaking to an 
ISA-PnP device.

Rene.
