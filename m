Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSLROHa>; Wed, 18 Dec 2002 09:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267248AbSLROHa>; Wed, 18 Dec 2002 09:07:30 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:36281 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265096AbSLROH3>; Wed, 18 Dec 2002 09:07:29 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 18 Dec 2002 06:14:48 -0800
Message-Id: <200212181414.GAA02717@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: 2.5.51 ide module problem
Cc: andre@linux-ide.org, axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-12-13, Alan Cox wrote:
>On Fri, 2002-12-13 at 07:59, Adam J. Richter wrote:

>> --- linux-2.5.51/drivers/pci/pci.c	2002-12-09 18:45:52.000000000 -0800
>> +++ linux/drivers/pci/pci.c	2002-12-09 19:03:18.000000000 -0800
[...]
>> diff -r -u linux-2.5.51/drivers/ide/Kconfig linux/drivers/ide/Kconfig
>> --- linux-2.5.51/drivers/ide/Kconfig	2002-12-09 18:45:56.000000000 -0800
>> +++ linux/drivers/ide/Kconfig	2002-11-27 18:23:46.000000000 -0800
>> @@ -199,7 +199,7 @@
>>  	depends on BLK_DEV_IDE
>>  
>>  config BLK_DEV_CMD640
>> -	bool "CMD640 chipset bugfix/support"
>> +	tristate "CMD640 chipset bugfix/support"

>Please don't do this. You can't "load" the workaround meaningfully for
>this device


	I'd appreciate some clarification on what trouble the generic
IDE driver can get into when the cmd640 code is not present.
linux-2.5.52/Documentation/ide.txt says:

|  For the CMD640, linux disables "IRQ unmasking" (hdparm -u1) on any
|  drive for which the "prefetch" mode of the CMD640 is turned on.
|  If "prefetch" is disabled (hdparm -p8), then "IRQ unmasking" can be
|  used again.
|
|  For the CMD640, linux disables "32bit I/O" (hdparm -c1) on any drive
|  for which the "prefetch" mode of the CMD640 is turned off.
|  If "prefetch" is enabled (hdparm -p9), then "32bit I/O" can be
|  used again.
|
|  The CMD640 is also used on some Vesa Local Bus (VLB) cards, and is *NOT*
|  automatically detected by Linux.  For safe, reliable operation with such
|  interfaces, one *MUST* use the "ide0=cmd640_vlb" kernel option.
|
|  Use of the "serialize" option is no longer necessary.

	As I understand it, both IRQ unmasking and 32 bit I/O are off
by default.  So, while a system could get into trouble by enabling
those options on a cmd640 system before the cmd640 module is loaded,
it sounds like it should be feasible to have IDE initially come up
without the cmd640 workarounds at a stage where the user level code
knows not to enable DMA or 32-bit PIO (for example, a boot floppy or
initial ramdisk), and then later loads the cmd640 workaround and other
PCI drivers (when a directory tree with a wider selection of modules
has been mounted).

	I wouldn't mind submitting the other IDE modularization
changes first sorting out cmd640 modularization later, but doing so
would involve a couple of inelegant Makefile changes that would have
to be reversed if cmd640 could later be a separate module, because it
would inolvolve linking d a .o from a subdirectory to build a module
(ide-probe.o, ide.o, ..., pci/cmd640.o).  So, I'd like to try to
understand now if this is really necessary.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

`h
