Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTLNXv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 18:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTLNXv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 18:51:56 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:7689 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262788AbTLNXvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 18:51:53 -0500
Message-ID: <3FDCF78F.4020403@lunar-linux.org>
Date: Mon, 15 Dec 2003 00:51:43 +0100
From: Auke Kok <sofar@lunar-linux.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5.1) Gecko/20031201
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dev@grsecurity.net, lunar-dev@lunar-linux.org
Subject: 2x procfs bug with 2.4.23
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have encountered 2 different procfs bugs with 2.4.23, where procfs 
seems to be running a possible race, the other with ACPI subdirs being 
created in /proc instead of /proc/acpi, possibly leading to more problems.

both kernels run the official grsec patchset, so I forward them to

1) procfs sys shows alternatingly up as "file", "socket", and "directory"

root@server /proc # ls -ld sys
srwxrwxrwx   10 root     root            0 2003-12-15 00:38 sys
root@server /proc # ls -ld sys
-r--r--r--   10 root     root            0 2003-12-15 00:38 sys
root@server /proc # ls -ld sys
prw-------   10 root     root            0 2003-12-15 00:41 sys
root@server /proc # ls -ld sys
prw-------   10 root     root            0 2003-12-15 00:41 sys
root@server /proc # ls -ld sys
srwxrwxrwx   10 root     root            0 2003-12-15 00:41 sys
root@server /proc # cd sys
root@server /proc/sys # ls -ld .
srwxrwxrwx   10 root     root            0 2003-12-15 00:41 .
root@server /proc/sys # pwd
/proc/sys
root@server /proc/sys # ls
abi  debug  dev  fs  kernel  net  proc  vm

etc... very very annoying since this box needs ip_forward enabled after 
boot to function!

The other box has an unsupported ACPI core:

[from dmesg]
ACPI: Unable to locate RSDP
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xf7ec0, last bus=0
PCI: Using configuration type 1
ACPI: System description tables not found
     ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, 
AE_NOT_FOUND
     ACPI-0134: *** Error: acpi_load_tables: Could not load tables: 
AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries

it's a genuine pII-mmx, so I don't care about the ACPI. However, the 
/proc/acpi directory isn't created but the subdirs for enabled 
components are, which could result in confusion/problems:

~ # ls -dF /proc/[a-zA-Z_-]*
/proc/ac_adapter/  /proc/interrupts  /proc/partitions
/proc/battery/     /proc/iomem       /proc/pci
/proc/bus/         /proc/ioports     /proc/processor/
/proc/button/      /proc/irq/        /proc/self@
/proc/cmdline      /proc/kmsg        /proc/slabinfo
/proc/cpuinfo      /proc/ksyms       /proc/stat
/proc/crypto       /proc/loadavg     /proc/swaps
/proc/devices      /proc/locks       /proc/sys/
/proc/dma          /proc/lvm/        /proc/sysvipc/
/proc/driver/      /proc/mdstat      /proc/thermal_zone/
/proc/execdomains  /proc/meminfo     /proc/tty/
/proc/fan/         /proc/misc        /proc/uptime
/proc/filesystems  /proc/modules     /proc/version
/proc/fs/          /proc/mounts@
/proc/ide/         /proc/net/

[note the thermal_zone... it should not be there I think ;^)]


-- not subscribed, reply to sofar <at> lunar.linux <dot> org


