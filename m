Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWINHEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWINHEw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWINHEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:04:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:53768 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751377AbWINHEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:04:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LGGWL9eHribBRP6MTXm+1H1ctGdmj7os9fJtRNvGmfYbTWXgMWJlcGhwgoDbWjkXv7WvkwavKGL9vVL3NY99/T6aFn/ybdEXQK59+4w/H+X2wQyMYBGNd5mc5GkfNRXaOMgO8rYH//uRmqKk+IuXl9+Hx/DLcLzFncAOg28bRA4=
Message-ID: <4508FF2F.5020504@gmail.com>
Date: Thu, 14 Sep 2006 01:05:19 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Samuel Tardieu <sam@rfc1149.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [RFC-patch 0/3] SuperIO locks coordinator (was: watchdog: add support
 for w83697hg chip)
References: <87fyf5jnkj.fsf@willow.rfc1149.net>	<1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru>
In-Reply-To: <20060909220256.d4486a4f.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> On Sat, 09 Sep 2006 16:25:25 +0100 Alan Cox wrote:
>
>   
>> No kernel level locking anywhere in the driver. Yet you could have two
>> people accessing it at once.
>>     
>
> Actually the situation is worse.  This driver pokes at SuperIO
> configuration registers, which are shared by all logical devices of the
> SuperIO chip.  There are other drivers which touch these registers -
> e.g., drivers/hwmon/w83627hf.c handles the hardware monitor part of this
> chip; many other hwmon drivers handle other SuperIO devices.  Hardware
> monitor drivers access the SuperIO config during initialization and do
> not request that port region, therefore loading hwmon drivers when
> w83697hf_wdt is loaded can lead to conflicts.
>
> More places which seem to touch SuperIO config:
>
>   - drivers/parport/parport_pc.c
>   - drivers/net/irda/nsc-ircc.c
>   - drivers/net/irda/smsc-ircc2.c
>   - drivers/net/irda/via-ircc.h
>
> I can find at least two attempts to fix the SuperIO problem:
>
>   - a SuperIO subsystem proposed by Evgeniy Polyakov (cc'd);
>
>   - a simple SuperIO locks coordinator proposed by Jim Cromie (also
>     cc'd; http://thread.gmane.org/gmane.linux.drivers.sensors/10052 -
>     can't find actual patches).
>
>   

So, with that as motivation, Ive dusted off the old patches.

The superio_locks odule creates an array (default=3) of superio-locks
structures, and doles them out to requesting modules.

Drivers which want to coordinate their use of a SuperIO device
reserve one of those structures by specifying where they expect
to find the superio port, and the device-ids theyre looking for,
the reservation routine checks for superio-port presence,
reserves one of the structures, and returns its address.
This approach avoids arbitrary scanning for superio ports,
and put the onus on the client-driver, which must know it already.

When a 2nd module which wants to use the device makes its request,
it gets the same pointer, and thus the same lock.

Thereafter, the 2+ client modules use the lock in the structure to 
coordinate
access with other client modules using the same device.
Drivers use superio_enter/exit() to do their own locking/unlocking,
letting them trade off lock-fiddling vs locked-duration.

The module does *not* guarantee anything, it offers no protection
against rogue (existing) modules which dont use the superio-locks 
coordinator.
( is anti-rogue protection even possible ?
    Perhaps, IFF modules reserve the 2 superio addresses - semi-rogue ? )


Thanks Sergey, for cc'g, and for your off-list review that saved me some 
embarrassment,
and saved the list from a sloppy patch.


1/3   adds superio_locks, into newly created drivers/isa
    Its a bit chatty, which I presume is ok for now..
    the number of reservations is settable via modparam: max_locks

soekris:~# modprobe superio_locks
[ 8715.042408] superio: initializing with 3 reservation slots
soekris:~# rmmod superio_locks
[ 8701.149869] superio: releasing 3 superio reservation slots


2/3   adapts drivers/hwmon/pc87360 to use superio_find()
    this module needs superio port only during initialization,
    so releases it quickly.

soekris:~# modprobe pc87360
[ 8794.528967] superio: no devid e1 at 2e
[ 8794.532929] superio: no devid e8 at 2e
[ 8794.536845] superio: no devid e4 at 2e
[ 8794.540768] superio: no devid e5 at 2e
[ 8794.544688] superio: allocating slot 0, addr 2e for device e9
[ 8794.550606] superio: devid e9 found at 2e
[ 8794.554802] pc87360: Device 0x09 not activated
[ 8794.559423] superio: releasing last user of superio-port 2e


3/3   adapts drivers/char/pc8736x_gpio
    this module needs the superio-port at runtime to alter pin-configs,
    so it doesnt release its superio-port reservation until module-exit

soekris:~# modprobe pc8736x_gpio
[ 8996.498524] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver 
Initializing
[ 8996.505892] superio: no devid e1 at 2e
[ 8996.509826] superio: no devid e8 at 2e
[ 8996.513739] superio: no devid e4 at 2e
[ 8996.517669] superio: no devid e5 at 2e
[ 8996.521594] superio: allocating slot 0, addr 2e for device e9
[ 8996.527582] superio: devid e9 found at 2e
[ 8996.531819] platform pc8736x_gpio.0: GPIO ioport 6600 reserved
soekris:~#
soekris:~# rmmod pc8736x_gpio
[ 9008.702637] superio: releasing last user of superio-port 2e

soekris:~# modprobe pc8736x_gpio
[ 4595.154139] superio: initializing with 3 reservation slots
[ 4596.742521] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver 
Initializing
[ 4596.750192] superio: no devid:e1 at port:2e
[ 4596.755212] superio: no devid:e8 at port:2e
[ 4596.759702] superio: no devid:e4 at port:2e
[ 4596.764184] superio: no devid:e5 at port:2e
[ 4596.768663] superio: allocating slot 0, addr 2e for device e9
[ 4596.774698] superio: found devid:e9 port:2e
[ 4596.779419] platform pc8736x_gpio.0: GPIO ioport 6600 reserved
soekris:~#
soekris:~# modprobe pc87360
[ 4603.693727] superio: no devid:e1 at port:2e
[ 4603.698245] superio: no devid:e8 at port:2e
[ 4603.703429] superio: no devid:e4 at port:2e
[ 4603.707934] superio: no devid:e5 at port:2e
[ 4603.712950] superio: sharing port:2e dev:e9 users:2
[ 4603.718125] superio: found devid:e9 port:2e
[ 4603.722609] pc87360: Device 0x09 not activated
[ 4604.965883] pc87360 9191-6620: VLM conversion set to 1s period, 160us 
delay
soekris:~#


Ive done limited testing, using the 2 drivers for my PC-87366 chip,
to insure that I havent badly botched something, (I still may have ;)
and looked at several of the hwmon drivers that operate superio ports.
comments in code speak to those observations.


