Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTHSTsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbTHSTrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:47:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:49285 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261305AbTHSTqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:46:25 -0400
Date: Tue, 19 Aug 2003 12:45:33 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Message-ID: <20030819194533.GA5738@kroah.com>
References: <200307152214.38825.arvidjaar@mail.ru> <200308161938.47935.arvidjaar@mail.ru> <20030816165016.GE9735@kroah.com> <200308192319.01895.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308192319.01895.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 11:19:01PM +0400, Andrey Borzenkov wrote:
> On Sat, Jul 26, 2003 at 10:00:51PM +0400, Andrey Borzenkov wrote:
> > Assuming this patch (or variant thereof) is accepted I can then
> > produce libsensors patch that will easily reuse current sensors.conf.
> > I have already done it for gkrellm and as Mandrake is going to
> > include 2.6 in next release sensors support becomes more of an issue.
> 
> There are more issues than just type_name.

Hey, one thing at a time :)

> In libsensors only one file need to be touched - proc.c (file that deals with 
> kernel interface). Unfortunately, not all information expected by libsensors 
> is currently available is sysfs. Here is output of first stab:
> 
> {pts/1}% LD_LIBRARY_PATH=$PWD/lib ./prog/sensors/sensors
> as99127f-i2c-0-2d
> Adapter: DUMMY
> Algorithm: DUMMY
> VCore 1:   +1.70 V  (min =  +1.49 V, max =  +1.81 V)
> +3.3V:     +3.47 V  (min =  +2.98 V, max =  +3.63 V)
> +5V:       +5.00 V  (min =  +4.52 V, max =  +5.48 V)
> +12V:     +11.37 V  (min = +10.82 V, max = +13.13 V)
> -12V:     -11.51 V  (min = -12.33 V, max = -15.07 V)       ALARM
> -5V:       -5.03 V  (min =  -4.50 V, max =  -5.49 V)
> CPU:      4753 RPM  (min = 3000 RPM, div = 2)
> Front:    2909 RPM  (min = 3000 RPM, div = 2)              ALARM
> ERROR: Can't get TEMP1 data!
> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!
> vid:      +1.650 V
> alarms:
> beep_enable:
>           Sound alarm enabled
> 
> So we have following problems:
> 
> 1. I do not know where to get information on adapters (called busses actually 
> in libsensors) and algorithms. I.e. the information corresponding to 2.4:
> 
> {pts/2}% cat ~/tmp/i2c-bus
> i2c-0   smbus           SMBus I801 adapter at e800              Non-I2C SMBus adapter

Look in /sys/class/i2c-adapter/  It shows all of the i2c adapters in the
system, and points to where they are in the device tree.  For example,
on my desktop:

$ tree ../class/i2c-adapter/
../class/i2c-adapter/
|-- i2c-0
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0
|   `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
`-- i2c-1
    |-- device -> ../../../devices/legacy/i2c-1
    `-- driver -> ../../../bus/i2c/drivers/i2c_adapter

Then look at the device directory for the i2c-0 adapter:

$ ls /sys/class/i2c-adapter/i2c-0/device/
0-0048/  0-0049/  0-0053/  detach_state  name  power/

Hm, a name file:
$ cat /sys/class/i2c-adapter/i2c-0/device/name 
SMBus I801 adapter at 8000

Ah, the same info as you showed for 2.4 :)

> 2. I do not know - and sysfs does not provide any information - how to 
> identify chips-of-interest as opposed to generic i2c devices. I.e. w83781d 
> has both clients and subclients (2.4 again):
> 
> {pts/2}% cat ~/tmp/i2c-0-bus
> 2d      AS99127F chip                           W83781D sensor driver
> 48      AS99127F subclient                      W83781D sensor driver
> 49      AS99127F subclient                      W83781D sensor driver
> 
> and we are interested in clients only. In 2.4 we get this information from 
> kernel as result of sysctl :))
> 
> {pts/2}% cat ~/tmp/i2c-sysctl-chips
> 256     as99127f-i2c-0-2d
> 
> while in 2.6 we see in sysfs all three devices:
> 
> pts/2}% l /sys/bus/i2c/devices
> 0-002d@  0-0048@  0-0049@
> 
> without any obvious way to know which one(s) to use.

That's what you are going to have to set the name file to in the
i2c_client structure, much like your patch did.  Then look at the
different name files in each device directory to see what kind of device
it is (chip, subclient, etc.)

> 3. libsensors asks for hysteresis value. This one does not exist in sysfs (so 
> all temp readings fail). Is it emulated by kernel or read off chip?

The kernel is exporting all of the info that it knows about through
sysfs.  If we missed a value somewhere, please let us know.  I'm pretty
sure they are all present:

$ ls /sys/class/i2c-adapter/i2c-0/device/0-0048/
detach_state  name  power/  temp_input  temp_max  temp_min

> 4. I do not have the slightest idea how ISA adapters look like in sysfs and 
> where they are located. Anyone can give me example?

They show up on the legacy bus:

$ tree /sys/class/i2c-adapter/i2c-1/
/sys/class/i2c-adapter/i2c-1/
|-- device -> ../../../devices/legacy/i2c-1
`-- driver -> ../../../bus/i2c/drivers/i2c_adapter

$ ls /sys/class/i2c-adapter/i2c-1/device/
detach_state  name  power

I don't have any drivers loaded that are attached to this adapter right
now, but I think you get the idea (it's the same as for pci devices.)

> So the patch to ibsensors is actually trivial enough. Main issue is contents 
> of sysfs

You might want to take a look at libsysfs, it makes finding all of the
devices and attributes in the sysfs tree a whole lot easer.

Hope this helps,

greg k-h
