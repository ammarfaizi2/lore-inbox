Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUIDXjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUIDXjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 19:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUIDXjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 19:39:14 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:17846 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264704AbUIDXjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 19:39:10 -0400
Message-ID: <9e4733910409041639457fd46b@mail.gmail.com>
Date: Sat, 4 Sep 2004 19:39:00 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: structure of /sys/class/pci_bus
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some trouble with the way sysfs is structured for multiple
PCI busses.

[jonsmirl@smirl /]$ ls sys/class/pci_bus
0000:00  0000:01  0000:02

I have three busses in my system. It is Intel i875P.

[jonsmirl@smirl /]$ ls sys/class/pci_bus/0000:00
bridge  cpuaffinity

Normal pci_bus entry

[jonsmirl@smirl /]$ ls sys/class/pci_bus/0000:00/bridge -l
lrwxrwxrwx  1 root root 0 Sep  4 13:10
sys/class/pci_bus/0000:00/bridge -> ../../../devices/pci0000:00

bridge for bus 0 is pci0000:00

[jonsmirl@smirl /]$ ls sys/class/pci_bus/0000:01/bridge -l
lrwxrwxrwx  1 root root 0 Sep  4 13:10
sys/class/pci_bus/0000:01/bridge ->
../../../devices/pci0000:00/0000:00:01.0

bridge for bus 0 is pci0000:00/0000:00:01.0

[jonsmirl@smirl /]$ ls sys/class/pci_bus/0000:02/bridge -l
lrwxrwxrwx  1 root root 0 Sep  4 13:10
sys/class/pci_bus/0000:02/bridge ->
../../../devices/pci0000:00/0000:00:1e.0

bridge for bus 2 is pci0000:00/0000:00:1e.0

[jonsmirl@smirl /]$ ls sys/class/pci_bus/0000:00/bridge
0000:00:00.0  0000:00:1d.0  0000:00:1d.2  0000:00:1d.7  0000:00:1f.0 
0000:00:1f.2  0000:00:1f.5  power
0000:00:01.0  0000:00:1d.1  0000:00:1d.3  0000:00:1e.0  0000:00:1f.1 
0000:00:1f.3  detach_state

But bridge 0 is not linked to a bridge node. It is linked to the host
device node instead. This is not symetrical with bus 1 and 2.

[jonsmirl@smirl /]$ ls sys/class/pci_bus/0000:01/bridge
0000:01:00.0  class   detach_state  irq    resource          subsystem_vendor 
0000:01:00.1  config  device        power  subsystem_device  vendor

This is what a normal bridge node looks like

[jonsmirl@smirl /]$ cat sys/class/pci_bus/0000:01/bridge/class
0x060400

Bridge is a PCI bridge

[jonsmirl@smirl /]$ ls sys/class/pci_bus/0000:00/bridge/0000:00:00.0
class  config  detach_state  device  irq  power  resource 
subsystem_device  subsystem_vendor  vendor

This is the real bridge node for bus 0.

[jonsmirl@smirl /]$ cat sys/class/pci_bus/0000:00/bridge/0000:00:00.0/class
0x060000

Class is Host bridge.  Host bridge has two nodes in sysfs, a device
node, pci0000:00, and a pci_device node, 0000:00:00.0.

[jonsmirl@smirl /]$ ls sys/devices
pci0000:00  platform  system

This shows the top level Host bridge.

Starting from here, how I am supposed to figure out that 0000:00:00.0
is the PCI device for controlling this bridge?

-- 
Jon Smirl
jonsmirl@gmail.com
