Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbTGDL5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbTGDL5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:57:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48371 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266018AbTGDL5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:57:06 -0400
Date: Fri, 4 Jul 2003 14:11:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030704121124.GB12633@fs.tum.de>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com> <20030703025343.GC282@fs.tum.de> <20030703190304.GA17707@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703190304.GA17707@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 07:03:04PM +0000, Adam Belay wrote:
> On Thu, Jul 03, 2003 at 04:53:43AM +0200, Adrian Bunk wrote:
> > I don't know whether it's related, but with 2.5.73 + your patch and
> > 2.5.74 my soundcard stopped working (driver compiled statically into
> > the kernel, no options given).
> >
> > >From dmesg:
> > 
> > 2.5.74:
> > 
> > <--  snip  -->
> > 
> > Advanced Linux Sound Architecture DriverVersion 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
> > specify port
> > pnp: the driver 'ad1816a' has been registered
> > pnp: match found with the PnP device '01:01.00'and the driver 'ad1816a'
> > pnp: match found with the PnP device '01:01.01'and the driver 'ad1816a'
> > ad1816a: AUDIO the requested resources areinvalid, using auto config
> > pnp: Unable to assign resources to device 01:01.00
> > ALSA device list:
> >   No soundcards found.
> > 
> > <--  snip  -->
> > 
> > 
> > 2.5.72 (soundcard works):
> > 
> > 
> > <--  snip  -->
> > 
> > Advanced Linux Sound Architecture DriverVersion 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
> > specify port
> > pnp: the driver 'ad1816a' has been registered
> > pnp: match found with the PnP device '01:01.00'and the driver 'ad1816a'Jul  3 04:37:42 r063144 kernel: pnp: match found with the PnP device '01:01.01'and the driver 'ad1816a'
> > pnp: res: the device '01:01.00' has been activated.
> > pnp: res: the device '01:01.01' has been activated.
> > ALSA device list:
> >   #0: ADI SoundPort AD1816A soundcard, SS at0x530, irq 5, dma 1&3
> >
> > <--  snip  -->
> 
> Hi,

Hi Adam,

> Some of my recent patches may correct this issue.  If not, it may be
> an unresolvable resource conflict.  Try catting

the dmesg output looks better, but it still doesn't work:

<--  snip  -->

Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16specify port
pnp: the driver 'ad1816a' has been registered
pnp: match found with the PnP device '01:01.00' and the driver 'ad1816a'
pnp: match found with the PnP device '01:01.01' and the driver 'ad1816a'
pnp: Device 01:01.00 activated.
pnp: Device 01:01.01 activated.
ALSA device list:
  No soundcards found.

<--  snip  -->

This problem is hopefully not unresolvable, the card works fine 
with ISAPNP with both kernel 2.4 and kernel 2.5 <= 2.5.72 .

> /sys/bus/pnp1/devices/01:01.00/options and see if any of the needed
> irqs are available, most importantly irq 5.

<--  snip  -->

# cat /sys/bus/pnp/devices/01\:01.01/options 
Dependent: 01 - Priority preferred
   port 0x330-0x330, align 0xf, size 0x2, 16-bit address decoding
   irq 2/9 High-Edge
Dependent: 02 - Priority acceptable
   port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
   irq 2/9 High-Edge
Dependent: 03 - Priority functional
   port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
   irq 2/9,10,11,15 High-Edge
# cat /proc/interrupts 
           CPU0       
  0:     305721          XT-PIC  timer
  1:       3302          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
 10:       2035          XT-PIC  eth0
 12:       5530          XT-PIC  i8042
 14:       7828          XT-PIC  ide0
 15:         25          XT-PIC  ide1
NMI:          0 
ERR:          0
# 

<--  snip  -->

> Also the 'resources' file can be used to configure the device.
> try...
> #"clear" > resources
> #"activate" > resources
> 
> A printk will display if it was successful.

<--  snip  -->

# cat /sys/bus/pnp/devices/01\:01.01/resources 
state = active
io 0x330-0x331
irq 9
# echo "clear" > /sys/bus/pnp/devices/01\:01.01/resources 
# cat /sys/bus/pnp/devices/01\:01.01/resources 
state = active
io 0x330-0x331
irq 9
# 

<--  snip  -->

> Let me know if this works.

Unfortunately not.  :-(

> Thanks,
> Adam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

