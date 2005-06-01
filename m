Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFAL6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFAL6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFAL6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:58:25 -0400
Received: from mail.renesas.com ([202.234.163.13]:36502 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261338AbVFAL5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:57:55 -0400
Date: Wed, 01 Jun 2005 20:57:44 +0900 (JST)
Message-Id: <20050601.205744.102571251.takata.hirokazu@renesas.com>
To: linux@dominikbrodowski.net
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-pcmcia@lists.infradead.org,
       sakugawa@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc5] m32r: Update m32r_cfc.[ch] to support
 Mappi-III platform
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050531144504.GA5783@isilmar.linta.de>
References: <20050531.221702.1044949015.takata.hirokazu@renesas.com>
	<20050531144504.GA5783@isilmar.linta.de>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Tue, 31 May 2005 16:45:04 +0200
> Hi,
> 
> > @@ -825,7 +814,7 @@ static int __init init_m32r_pcc(void)
> >  	for (i = 0 ; i < pcc_sockets ; i++) {
> >  		socket[i].socket.dev.dev = &pcc_device.dev;
> >  		socket[i].socket.ops = &pcc_operations;
> > -		socket[i].socket.resource_ops = &pccard_static_ops;
> > +		socket[i].socket.resource_ops = &pccard_nonstatic_ops;
> >  		socket[i].socket.owner = THIS_MODULE;
> >  		socket[i].number = i;
> >  		ret = pcmcia_register_socket(&socket[i].socket);
> 
> Uh, are you sure?
> 
> 	Dominik
> 

I'm now in trouble with CF device detection at boot time in case of
pccard_static_ops.

I guess it has a relationship with that CS_UNSUPPORTED_FUNCTION is 
returned by rsrc_mgr.c:pcmcia_adjust_resource_info() in !CONFIG_NONSTATIC.
But I'm not sure...

So, I will show you the driver's status as following.
I hope any comments if possible.

Thanks in advance.

-- Takata


Status of the M32R CF driver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    configuration                           : status
    --------------------------------------- + --------
    pccard_nonstatic_ops (CONFIG_NONSTATIC) : OK
    pccard_static_ops (!CONFIG_NONSTATIC)   : NG

    OK ... In NONSTATIC (CONFIG_NONSTATIC, pccard_nonstatic_ops) case,
           a CF disk/memory device can be probed and mounted normally.
  
    NG ... In STATIC (!CONFIG_NONSTATIC, pccard_static_ops) case,
           a CF disk/memory device can *not* be probed automatically now.
           But a CF device can be mounted after "pccardctl insert" command
           execution, and also a CF device insert event can be handled 
           correctly.


Config params
~~~~~~~~~~~~~
---
  :
#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y

#
# PC-card bridges
#
# CONFIG_TCIC is not set
# CONFIG_M32R_PCC is not set
CONFIG_M32R_CFC=y
CONFIG_M32R_CFC_NUM=1
  :
#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
  :
#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_IDE_ARM is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_BLK_DEV_HD is not set
  :
---
      

Test environment
~~~~~~~~~~~~~~~~~
  Platform: M3A-2170(Mappi-III)

  hotplug + pcmciautils
    - hotplug (0.0.20040329-22)
    - pcmciautils-003
      http://kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html

  Root filesystem: based on Debian GNU/Linux (sid) for m32r.
  aptline:
    deb http://debian.linux-m32r.org 04_ordovician main
    deb http://debian.linux-m32r.org unstable main


Boot log messages
~~~~~~~~~~~~~~~~~
1) NONSTATIC (CONFIG_NONSTATIC), built-in driver  ... OK

   - A CF disk device can be probed correctly.
       hda: HMS360404D5CF00, CFA DISK drive
       ide0 at 0x1000-0x1007,0x100e on irq 6
       hda: max request size: 128KiB
       hda: 7999488 sectors (4095 MB) w/128KiB Cache, CHS=7936/16/63
       hda: cache flushes supported
       /dev/ide/host0/bus0/target0/lun0: p1
       ide-cs: hda: Vcc = 3.3, Vpp = 0.0

--- boot log ---
g00ff version -36.2 (M32R)
        Copyright 2004-2005  Free Software Initiative of Japan
eth: MAC Address: 08 00 70 25 6A 02, Ethernet initialization done.
DHCP success.
DNS resolved.
Address resolution (IP -> Ether MAC) success.
!
Loading kernel from network: ...........................
Uncompressing Linux... Ok, booting the kernel.
Linux version 2.6.12-rc5-mm1 (takata@pcepx10) (gcc version 3.4.4 20050203 (prerelease) (Debian 3.4.3-9.1)) #16 SMP Wed Jun 1 18:21:41 JST 2005
user-defined physical RAM map:
Built 2 zonelists
Initializing CPU#0
Kernel command line: console=ttyS0,115200n8 root=/dev/nfs nfsroot=/project/m32r-linux/export/rootfs2.6_04.unstable,rsize=1024,wsize=1024 ip=:::::eth0:dhcp mem=128M
PID hash table entries: 1024 (order: 10, 16384 bytes)
Timer start : latch = 3906
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128072k/131592k available (1592k kernel code, 3424k reserved, 291k data, 96k init)
Mount-cache hash table entries: 512
M32R-mp information
  On-chip CPUs : 2
  CPU model : M32R-MP 012U2/CHAOS(Ver.)
CPU present map : 3
Booting processor 1/1
Waiting for send to finish...
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
+After Startup.
Before Callout 1.
After Callout 1.
OK.
Boot done.
Brought up 2 CPUs
CPU#0 : CPU clock 200.00MHz, Bus clock 50.00MHz, loops_per_jiffy[794624]
CPU#1 : CPU clock 200.00MHz, Bus clock 50.00MHz, loops_per_jiffy[794624]
Before bogomips.
Total of 2 processors activated (317.84 BogoMIPS).
Before bogocount - setting activated=1.
NET: Registered protocol family 16
inotify device minor=63
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
cn_fork is registered
Serial: M32R SIO driver $Revision: 1.11 $ ttyS0 at I/O 0xefd000 (irq = 48) is a M32RSIO
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C11xFD (rev 1) at a0000300 IRQ 1
eth0: Ethernet addr: 08:00:70:25:6a:02
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
CF: Card is detected at socket 0 : stat = 0x00000001
  m32r_cfc pcc at 0x00000000
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 8Kbytes
TCP established hash table entries: 8192 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 98304 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
eth0: link down
Sending DHCP requests .<6>eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
., OK
IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.105
IP-Config: Complete:
      device=eth0, addr=192.168.0.105, mask=255.255.255.0, gw=255.255.255.255,
     host=mappi005, domain=, nis-domain=(none),
     bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
VFS: Mounted root (nfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 96k freed
INIT: version 2.86 booting
Creating extra device nodes...done.  
Started device management daemon v1.3.25 for /dev
Activating swap.
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
System time was Thu Apr 17 00:01:05 UTC 2003.
Setting the System Clock using the Hardware Clock as reference...
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
System Clock set. System local time is now Thu Apr 17 09:01:06 JST 2003.
Cleaning up ifupdown...done.
Calculating module dependencies... done.
Loading modules...
All modules loaded.
Checking all file systems...
fsck 1.35 (28-Feb-2004)
Setting kernel variables ...
... done.
Mounting local filesystems...
mount: mount point /proc/bus/usb does not exist
Cleaning /tmp /var/run /var/lock.
/dev/shm/network/...Initializing: /etc/network/ifstate.
Starting hotplug subsystem:
   pci     
   pci      [success]
   usb     
   usb      [success]
   isapnp  
   isapnp   [success]
   ide     
   ide      [success]
   input   
   input    [success]
   pcmcia  
   pcmcia   [success]
   pcmcia_socket
   pcmcia_socket [success]
   scsi    
   scsi     [success]
done.
hda: HMS360404D5CF00, CFA DISK drive
Configuring network interfaces...ide0 at 0x1000-0x1007,0x100e on irq 6
hda: max request size: 128KiB
hda: 7999488 sectors (4095 MB) w/128KiB Cache, CHS=7936/16/63
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1
ide-cs: hda: Vcc = 3.3, Vpp = 0.0
done.
Starting portmap daemon: portmap.
Starting portmapper...Mounting remote filesystems...

Setting the System Clock using the Hardware Clock as reference...
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
System Clock set. Local time: Thu Apr 17 09:01:32 JST 2003

Initializing random number generator...done.
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
INIT: Entering runlevel: 2
Starting portmap daemon: portmap.
Starting internet superserver: inetd.
Starting OpenBSD Secure Shell server: sshd.

Debian GNU/Linux 3.1 mappi001 ttyS0

mappi001 login: 
---
The hda device is detected correctly.


2) STATIC (!CONFIG_NONSTATIC), built-in driver  ... NG

  - A CF disk/memory device is not recognized automatically at boot time.
  - However, after boot, "pccardctl insert" works normally, and 
    a CF disk/memory device can be mounted, and CF device insertion
    events can be handled correctly.

--- boot log ---
 :
Starting hotplug subsystem:
   pci     
   pci      [success]
   usb     
   usb      [success]
   isapnp  
   isapnp   [success]
   ide     
   ide      [success]
   input   
   input    [success]
   pcmcia  
   pcmcia   [success]
   pcmcia_socket
   pcmcia_socket [success]
   scsi    
   scsi     [success]
done.
Configuring network interfaces...done.
Starting portmap daemon: portmap.
Starting portmapper...Mounting remote filesystems...
 :
---
No CF device is recognized at boot time.
