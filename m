Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbTHSTXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTHSTW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:22:26 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:4106 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261318AbTHSTUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:20:38 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Date: Tue, 19 Aug 2003 23:19:01 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307152214.38825.arvidjaar@mail.ru> <200308161938.47935.arvidjaar@mail.ru> <20030816165016.GE9735@kroah.com>
In-Reply-To: <20030816165016.GE9735@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308192319.01895.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 10:00:51PM +0400, Andrey Borzenkov wrote:
> Assuming this patch (or variant thereof) is accepted I can then
> produce libsensors patch that will easily reuse current sensors.conf.
> I have already done it for gkrellm and as Mandrake is going to
> include 2.6 in next release sensors support becomes more of an issue.

There are more issues than just type_name.

In libsensors only one file need to be touched - proc.c (file that deals with 
kernel interface). Unfortunately, not all information expected by libsensors 
is currently available is sysfs. Here is output of first stab:

{pts/1}% LD_LIBRARY_PATH=$PWD/lib ./prog/sensors/sensors
as99127f-i2c-0-2d
Adapter: DUMMY
Algorithm: DUMMY
VCore 1:   +1.70 V  (min =  +1.49 V, max =  +1.81 V)
+3.3V:     +3.47 V  (min =  +2.98 V, max =  +3.63 V)
+5V:       +5.00 V  (min =  +4.52 V, max =  +5.48 V)
+12V:     +11.37 V  (min = +10.82 V, max = +13.13 V)
-12V:     -11.51 V  (min = -12.33 V, max = -15.07 V)       ALARM
-5V:       -5.03 V  (min =  -4.50 V, max =  -5.49 V)
CPU:      4753 RPM  (min = 3000 RPM, div = 2)
Front:    2909 RPM  (min = 3000 RPM, div = 2)              ALARM
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm enabled

So we have following problems:

1. I do not know where to get information on adapters (called busses actually 
in libsensors) and algorithms. I.e. the information corresponding to 2.4:

{pts/2}% cat ~/tmp/i2c-bus
i2c-0   smbus           SMBus I801 adapter at e800              Non-I2C SMBus 
adapter

2. I do not know - and sysfs does not provide any information - how to 
identify chips-of-interest as opposed to generic i2c devices. I.e. w83781d 
has both clients and subclients (2.4 again):

{pts/2}% cat ~/tmp/i2c-0-bus
2d      AS99127F chip                           W83781D sensor driver
48      AS99127F subclient                      W83781D sensor driver
49      AS99127F subclient                      W83781D sensor driver

and we are interested in clients only. In 2.4 we get this information from 
kernel as result of sysctl :))

{pts/2}% cat ~/tmp/i2c-sysctl-chips
256     as99127f-i2c-0-2d

while in 2.6 we see in sysfs all three devices:

pts/2}% l /sys/bus/i2c/devices
0-002d@  0-0048@  0-0049@

without any obvious way to know which one(s) to use.

3. libsensors asks for hysteresis value. This one does not exist in sysfs (so 
all temp readings fail). Is it emulated by kernel or read off chip?

4. I do not have the slightest idea how ISA adapters look like in sysfs and 
where they are located. Anyone can give me example?

So the patch to ibsensors is actually trivial enough. Main issue is contents 
of sysfs
