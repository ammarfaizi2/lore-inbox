Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291818AbSBTR5p>; Wed, 20 Feb 2002 12:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292133AbSBTR5g>; Wed, 20 Feb 2002 12:57:36 -0500
Received: from mail.myrio.com ([63.109.146.2]:27894 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S291818AbSBTR5T> convert rfc822-to-8bit;
	Wed, 20 Feb 2002 12:57:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 
Date: Wed, 20 Feb 2002 09:55:46 -0800
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3AF@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Index: AcG52x9pYdBoQ61SRyay+c7ToOdF3gAV/k+w
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "nimeesh" <nimeesh24@yahoo.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Feb 2002 17:56:40.0820 (UTC) FILETIME=[F322DB40:01C1BA37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nimeesh wrote:
 
> I'm new to linux.I'm trying network booting of linux
> system.System Conf.(intel 815 chipset ,PXE
> bios,3com905c-ethernet card)
> 
> In that i'm facing problem with kernel image and it's
> file system.
> 
> In that when i get the kernel image and filesystem.
> It gives me error as
> kernel panic : unable to mount root fs on 01:00
> 
> Is it necessary to use NFS or is it possible without
> that? Any special specification while creating kernel
> image and filesystem?

It sounds like you have PXE working well enough to have the 
BIOS download a PXE bootloader from a TFTP server, which 
then downloads a kernel image.  I assume you are using Peter 
Anvin's "pxelinux" boot loader?  
It is part of the "syslinux" package.

Anyway, you have at least two options for the root
file system.  You can use an NFS root, or you can use
an initial ramdisk.    I use an initial ramdisk.  My server 
has the standard ISC DHCP server, and Peter Anvin's TFTP server.

The DHCP server is configured in /etc/dhcpd.conf and
includes:

subnet 10.134.0.0 netmask 255.255.254.0
{
	# Not shown: options for DNS, router, domain name, 
	# default lease time, range, etc.

	# this is the important bit for PXE:
	filename "pxelinux.0"
}

The TFTP server contains the files:

pxelinux.0        (the pxelinux boot loader)
bzImage		(the kernel)
initrd.gz		(the initial ramdisk)
pxelinux.cfg/0A86 (the pxelinux config directory and file)

The Pxelinux.cfg configuration file I use is named "0A86" 
because the DHCP server assigns addresses "10.134.xxx.yyy", 
(10=0x0A, 134=0x86) and looks something like this:

DEFAULT MYNETBOOT
TIMEOUT 0
LABEL MYNETBOOT
  KERNEL bzImage
  APPEND initrd=initrd.gz root=/dev/ram

There is quite a bit of information on the network about how 
to create an initrd image.  Check the "HOWTO" documentation 
files that may have come with your Linux distribution.  
Also try "man initrd".

So here's how the pxe boot works from start to finish:

1. Client boots and enters PXE BIOS.
2. PXE BIOS does DHCP, gets IP address and filename option
3. PXE BIOS uses TFTP to download pxelinux.0 and boot from it
4. pxelinux.0 bootloader determines IP address, asks TFTP
   server for config file, finds "0A86" file and downloads it
5. pxelinux.0 reads config file, uses TFTP to download
   bzImage and initrd.gz
6. pxelinux boots bzImage kernel together with initrd.gz 
   ramdisk, kernel command line "root=/dev/ram" tells 
   kernel to use ramdisk as root filesystem
7. Kernel boots, mounts ramdisk, and then runs /linuxrc if it
   exists, otherwise runs /sbin/init just like booting from
   any other device.
8. linuxrc or init starts up the system or does whatever you
   want them to do.  Read the initrd man page for details.

Best wishes,

Torrey Hoffman
