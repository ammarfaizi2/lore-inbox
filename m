Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUKBWHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUKBWHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKBWDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:03:18 -0500
Received: from mid-2.inet.it ([213.92.5.19]:56787 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S261616AbUKBV62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:58:28 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Test patch for ub and double registration
Date: Tue, 2 Nov 2004 22:57:24 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, cs@tequila.co.jp
References: <20041101164432.3fa72b81@lembas.zaitcev.lan>
In-Reply-To: <20041101164432.3fa72b81@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411022257.24752.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 01:44, martedì 02 novembre 2004, Pete Zaitcev ha scritto:
> Hello,
>
> here's a patch to fix the double kobject registration problem with the ub.
> One little problem here is that I do not have a device which fails this
> way, so I would like owners of such devices to give it a try.
>
> The latest victim of this is Fabio Coatti. It should be noted that this
> fix only (supposed to) prevents oopses on deregistration. If the device
> doesn't work generally (for example, requires START STOP UNIT), it won't
> help that.

I've tried (under 2.6.10-rc1-mm1, that was the kernel that showed me problems) 
and in fact I can plug/unplug without problems usb flash drive, but there is 
a difference with previous behaviour (apart from crash, of course :) )
here the log from patched version of ub.c:

=================================================
Nov  2 22:44:20 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov  2 22:44:20 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov  2 22:44:21 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov  2 22:44:21 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  2 22:44:21 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  2 22:44:21 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 6
Nov  2 22:44:21 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  2 22:44:21 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  2 22:44:21 kefk kernel: usb 5-3: ep0 maxpacket = 64
Nov  2 22:44:21 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov  2 22:44:21 kefk kernel: usb 5-3: default language 0x0409
Nov  2 22:44:21 kefk kernel: usb 5-3: Product: Mass storage
Nov  2 22:44:21 kefk kernel: usb 5-3: Manufacturer: USB
Nov  2 22:44:21 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov  2 22:44:21 kefk kernel: usb 5-3: hotplug
Nov  2 22:44:21 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov  2 22:44:21 kefk kernel: usb 5-3:1.0: hotplug
Nov  2 22:44:21 kefk kernel: ub 5-3:1.0: usb_probe_interface
Nov  2 22:44:21 kefk kernel: ub 5-3:1.0: usb_probe_interface - got id
Nov  2 22:44:21 kefk kernel: uba: device 6 capacity nsec 50 bsize 512
(nothing more)
=================================================

but at this point no device is created in /dev, while previous behaviour was 
different:
(snip)
Oct 28 00:32:22 kefk kernel: ub 5-3:1.0: usb_probe_interface
Oct 28 00:32:22 kefk kernel: ub 5-3:1.0: usb_probe_interface - got id
Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 50 bsize 512
Oct 28 00:32:22 kefk kernel: uba: made changed
Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 1024000 bsize 512
Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 1024000 bsize 512
Oct 28 00:32:22 kefk kernel:  uba: uba1
Oct 28 00:32:22 kefk kernel:  uba: uba1
Oct 28 00:32:22 kefk kernel: kobject_register failed for uba1 (-17)
Oct 28 00:32:22 kefk kernel:  [<c01f1fd7>] kobject_register+0x51/0x5f
Oct 28 00:32:22 kefk kernel:  [<c0184720>] add_partition+0xbb/0xf0
(snip)

i.e. no lines like

uba: device 4 capacity nsec 1024000 bsize 512
uba: uba1


Apart that, removal of the usb device causes no harm to the system, log here:
Nov  2 22:55:47 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov  2 22:55:47 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov  2 22:55:47 kefk kernel: usb 5-3: USB disconnect, address 6
Nov  2 22:55:47 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Nov  2 22:55:47 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Nov  2 22:55:47 kefk kernel: usb 5-3:1.0: hotplug
Nov  2 22:55:47 kefk kernel: usb 5-3: unregistering device
Nov  2 22:55:47 kefk kernel: usb 5-3: hotplug
Nov  2 22:55:47 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x100


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
