Return-Path: <linux-kernel-owner+w=401wt.eu-S1752647AbWLWKDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLWKDz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 05:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbWLWKDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 05:03:55 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:50284 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbWLWKDy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 05:03:54 -0500
From: Martin Williges <kernel@zut.de>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH 1/1] usblp.c - add Kyocera Mita FS 820 to list of "quirky" printers
Date: Sat, 23 Dec 2006 11:03:45 +0100
User-Agent: KMail/1.9.5
References: <200612221227.18870.kernel@zut.de> <458BD945.5020604@gentoo.org>
In-Reply-To: <458BD945.5020604@gentoo.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612231103.45702.kernel@zut.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:0e8a1abe8b7b166fb6ca785a477f557f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. Dezember 2006 14:10 schrieben Sie:

> Your mailer has mangled tabs into whitespace. Also, your patch needs to
> be applicable with -p1 from the root kernel dir.

I think, it was more the copy and paste from the shell; should have included 
the file instead.

> Given the description of the problem it is probably more worthwhile to
> provide logs with USB debugging enabled, and usbmon logs, so that the
> real problem can be found.

I´ll gladly do that best I can, but might need some help what to do. In the 
following is what I found so far.

Two straces of the usb backend. First one that worked ok (some seconds after 
pluuging the printer in):

[...]
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
open("/dev/usblp0", O_RDWR|O_EXCL|O_LARGEFILE) = -1 ENOENT (No such file or 
directory)
open("/dev/usb/lp0", O_RDWR|O_EXCL|O_LARGEFILE) = 3
ioctl(0x3, 0x84005001, 0xbfd67cd1)      = 0
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 2), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0xb7fd4000
write(1, "direct usb://Kyocera/FS-820 \"Kyo"..., 161direct 
usb://Kyocera/FS-820 "Kyocera FS-820" "Kyocera FS-820 USB 
#1" "ID:FS-820;MFG:Kyocera;CMD:PCLXL,PCL5E,PJL;MDL:FS-820;CLS:PRINTER;DES:Kyocera 
Mita FS-820;"
) = 161
close(3)                                = 0
open("/dev/usblp1", O_RDWR|O_EXCL|O_LARGEFILE) = -1 ENOENT (No such file or 
directory)
[...]

the ususal case (does not work):

[...]
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
open("/dev/usblp0", O_RDWR|O_EXCL|O_LARGEFILE) = -1 ENOENT (No such file or 
directory)
open("/dev/usb/lp0", O_RDWR|O_EXCL|O_LARGEFILE) = 3
ioctl(0x3, 0x84005001, 0xbfc397b1)      = -1 (errno 5)
close(3)                                = 0
open("/dev/usblp1", O_RDWR|O_EXCL|O_LARGEFILE) = -1 ENOENT (No such file or 
directory)
[...]

Here a piece of the kernel messages with CONFIG_USB_DEBUG=y (started the usb 
backend two times, reading printer ID does not work):

[...]
Dec 21 18:48:17 heinrich usb 3-5.4: usb timed out on ep0in len=0/1023
Dec 21 18:48:37 heinrich usb 3-5.4: usb timed out on ep0in len=0/1023
[...]

yes, that´s all with CONFIG_USB_DEBUG.

Then, there are syslog messages with "#define DEBUG" in usblp.c:

After plugging in the printer:
[...]
Dec 21 19:56:12 heinrich usb 1-5.4: new full speed USB device using ehci_hcd 
and address 6
Dec 21 19:56:12 heinrich usb 1-5.4: configuration #1 chosen from 1 choice
Dec 21 19:56:12 heinrich drivers/usb/class/usblp.c: usblp0 set protocol 2
Dec 21 19:56:12 heinrich drivers/usb/class/usblp.c: usblp_control_msg: rq: 
0x00 dir: 1 recip: 1 value: 0 idx:
 0 len: 0x3ff result: 91
Dec 21 19:56:12 heinrich drivers/usb/class/usblp.c: usblp0 Device ID string 
[len=91]="ID:FS-820;MFG:Kyocera;C
MD:PCLXL,PCL5E,PJL;MDL:FS-820;CLS:PRINTER;DES:Kyocera Mita FS-820;"
Dec 21 19:56:12 heinrich drivers/usb/class/usblp.c: usblp_control_msg: rq: 
0x01 dir: 1 recip: 1 value: 0 idx:
 0 len: 0x1 result: 1
Dec 21 19:56:12 heinrich drivers/usb/class/usblp.c: usblp0: USB Bidirectional 
printer dev 6 if 0 alt 0 proto
2 vid 0x0482 pid 0x0010
Dec 21 19:56:15 heinrich drivers/usb/class/usblp.c: usblp_ioctl: 
cmd=0x84005001 (P nr=1 len=1024 dir=2)
Dec 21 19:56:15 heinrich drivers/usb/class/usblp.c: usblp_control_msg: rq: 
0x00 dir: 1 recip: 1 value: 0 idx:
 0 len: 0x3ff result: 91
Dec 21 19:56:15 heinrich drivers/usb/class/usblp.c: usblp0 Device ID string 
[len=91]="ID:FS-820;MFG:Kyocera;C
MD:PCLXL,PCL5E,PJL;MDL:FS-820;CLS:PRINTER;DES:Kyocera Mita FS-820;"

[So far, so good. I then call the usb backend to read the printer ID]:

Dec 21 19:56:18 heinrich drivers/usb/class/usblp.c: usblp_ioctl: 
cmd=0x84005001 (P nr=1 len=1024 dir=2)
Dec 21 19:56:23 heinrich drivers/usb/class/usblp.c: usblp_control_msg: rq: 
0x00 dir: 1 recip: 1 value: 0 idx:
 0 len: 0x3ff result: -110
Dec 21 19:56:23 heinrich drivers/usb/class/usblp.c: usblp0: error = -110 
reading IEEE-1284 Device ID string
[...]

This is what I know until know. What can I do next? Learning about usbmon?

Thanks for hints.

	Martin
