Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUK2P2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUK2P2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUK2P2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:28:35 -0500
Received: from smtp07.auna.com ([62.81.186.17]:62639 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261728AbUK2P2H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:28:07 -0500
Date: Thu, 25 Nov 2004 23:52:23 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.10-rc2-mm3
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20041125022405.5fc37efa.akpm@osdl.org>
	<20041125183137.GA30975@kroah.com>
In-Reply-To: <20041125183137.GA30975@kroah.com> (from greg@kroah.com on Thu
	Nov 25 19:31:37 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101426743l.7616l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.11.25, Greg KH wrote:
> > On 2004.11.22, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/
> > > 
> > 
> > Problem with /sys/bus/i2c/devices empty.
> > 
> > I am running a 2.10-rc2-mm3 kernel with a couple pathes (unrelated to
> > i2c). It shows me an empty directory in /sys/bus/i2c/devices, even
> > if I have all suitable modules loaded:
> 
> Are you sure these are the proper modules for this system?
> 

The same /etc/sysconfig/lm_sensors has been working for many 2.6 kernels ;)

> > Module                  Size  Used by
> > w83627hf               24224  0 
> > i2c_dev                 8192  0 
> > i2c_sensor              3328  1 w83627hf
> > i2c_isa                 2304  0 
> > i2c_i801                7692  0 
> > i2c_core               18560  5 w83627hf,i2c_dev,i2c_sensor,i2c_isa,i2c_i801
> > 
> > On boxes running 2.6.9, the devices are present with the same module list
> > (different adapters)
> 
> Ah, but what about 2.6.9 on this same machine?  Are you sure that the

See below. I booted again on 2.6.9-jam1 (mm1 with fixes collected from LKML).

> i2c_i801 driver is the proper one for this box?  How about the w83627hf
> driver?  Are you sure that chip is on it?
> 

I updated my sensors userspace to latest cvs to check if some kind of
de-synchronisation was the cause:

werewolf:~> sensors -v
sensors version 2.9.0-CVS with libsensors version 2.9.0-CVS

sensors-detect on 2.6.9-mm1:

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x2f (and 0x48 0x49)
    Chip `Winbond W83792D' (confidence: 8)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
# no driver for Winbond W83792D yet
modprobe smbus-arp
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

With this modules (no smbus-arp):
w83627hf               25128  0 
eeprom                  7072  0 
i2c_sensor              3456  2 w83627hf,eeprom
i2c_isa                 2304  0 
i2c_i801                7820  0 
i2c_core               19712  5 w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_i801

I can see this:

werewolf:~> ls /sys/bus/i2c/devices
0-0050@ 0-0052@ 1-0290@

Now, 2.6.10-rc2-mm3:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x2f (and 0x48 0x49)
    Chip `Winbond W83792D' (confidence: 8)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

With same modules inserted:
w83627hf               24224  0 
eeprom                  6168  0 
i2c_sensor              3328  2 w83627hf,eeprom
i2c_isa                 2304  0 
i2c_i801                7692  0 
i2c_core               18560  6 i2c_dev,w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_i801

werewolf:~# ls /sys/bus/i2c/devices 
0-0050@  0-0052@

So i see the two DIMMS but not the 0x0290 bus.
I'm going to try with the other modules I am missing, smbus-arp and it87, but
this setup works in 2.6.9...

If you need any info, just ask for.

Hope this helps. Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


