Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbTFBSht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264845AbTFBSht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:37:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264839AbTFBSgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:36:03 -0400
Subject: Re: Request for help
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederman@lnxi.com>
Cc: ganesh_borse <ganesh_borse@indiatimes.com>, agnew@missl.cs.umd.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <m3fzmsjroy.fsf@maxwell.lnxi.com>
References: <200305290413.JAA23492@WS0005.indiatimes.com>
	 <m3fzmsjroy.fsf@maxwell.lnxi.com>
Content-Type: multipart/mixed; boundary="=-nb44skVVMckWgS2hC7si"
Organization: 
Message-Id: <1054579727.1208.20.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 11:48:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nb44skVVMckWgS2hC7si
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-06-02 at 10:49, Eric W. Biederman wrote:
> "ganesh_borse" <ganesh_borse@indiatimes.com> writes:
...
> > I am trying to develop a device drive code for listing the devices connected to
> > a ide controller at the time of kernel booting.
...
> > Is there any way to get which channels on ide controller has got devices and
> > which devices? 
> 
> Yes.  But it is baroque.
> 
> > This I am trying to get even before the normal ide device driver
> > has been setup. Are there ide controller commands to get this info?

If you can wait until *after* the system has booted, there are lots of
ways to derive what is out there.  Grab the sources for "hdparm" and
have a look at it for examples of hardcore access methods.

A simple way to derive some information can be found by walking the
sysfs hierarchy.

Here's a dirt-simple script I use that somewhat-pretty-prints items
hanging off busses in the sysfs hierarchy.  Sysfs must be mounted for
the script to work.

Sample output:
% lsbus
ide:
  pci0/00:1f.1/ide1/1.0 [ IDE Drive ]
  pci0/00:1f.1/ide0/0.1 [ IDE Drive ]
  pci0/00:1f.1/ide0/0.0 [ IDE Drive ]

ide-scsi:

pci:
  pci0/00:1e.0/04:04.0 [ Intel Corp. 82557/8/9 [Ethernet  ]
  pci0/00:02.0/02:1f.0/03:00.0 [ Intel Corp. 82806AA PCI64 Hub Ad ]
  pci0/00:02.0/02:1f.0 [ Intel Corp. 82806AA PCI64 Hub PC ]
  pci0/00:01.0/01:00.0 [ Matrox Graphics, Inc MGA G400 AGP ]
  pci0/00:1f.5 [ Intel Corp. 82801BA/BAM AC'97 Au ]
  pci0/00:1f.3 [ Intel Corp. 82801BA/BAM SMBus ]
  pci0/00:1f.2 [ Intel Corp. 82801BA/BAM USB (Hub ]
  pci0/00:1f.1 [ Intel Corp. 82801BA IDE U100 ]
  pci0/00:1f.0 [ Intel Corp. 82801BA ISA Bridge ( ]
  pci0/00:1e.0 [ Intel Corp. 82801BA/CA/DB PCI Br ]
  pci0/00:02.0 [ Intel Corp. 82860 860 (Wombat) C ]
  pci0/00:01.0 [ Intel Corp. 82850 850 (Tehama) C ]
  pci0/00:00.0 [ Intel Corp. 82860 860 (Wombat) C ]

platform:
  legacy/floppy0 [ Floppy Drive ]

pnp:
  pnp0/00:10 [ 16550A-compatible COM port ]
  pnp0/00:0f [ ECP printer port ]
  pnp0/00:0d [ PC standard floppy disk controller ]
  pnp0/00:0c [ 16550A-compatible COM port ]
  pnp0/00:0b [ PS/2 Port for PS/2-style Mice ]
  pnp0/00:0a [ PCI Bus ]
  pnp0/00:09 [ Reserved Motherboard Resources ]
  pnp0/00:08 [ System Board ]
  pnp0/00:07 [  ]
  pnp0/00:06 [ Math Coprocessor ]
  pnp0/00:05 [ AT-style speaker sound ]
  pnp0/00:04 [ IBM Enhanced (101/102-key, PS/2 mouse support) ]
  pnp0/00:03 [ AT Real-Time Clock ]
  pnp0/00:02 [ AT Timer ]
  pnp0/00:01 [ AT DMA Controller ]
  pnp0/00:00 [ AT Interrupt Controller ]

scsi:

system:
  sys/rtc0 [ i8253 Real Time Clock ]
  sys/timer0 [ timer ]
  sys/pic0 [ i8259A PIC ]
  sys/cpu1 [ CPU 1 ]
  sys/cpu0 [ CPU 0 ]

usb:
  pci0/00:1f.2/usb1/1-0:0 [ Hub ]
  pci0/00:1f.2/usb1 [ Intel Corp. 82801BA/BAM USB (Hub (Linux 2.5.70 uh
]
%

The script is attached...




--=-nb44skVVMckWgS2hC7si
Content-Description: 
Content-Disposition: inline; filename=lsbus
Content-Type: text/x-sh; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

#
#	$Id$
#
#	andyp@osdl.org
#

mnt=`grep sysfs /proc/mounts | awk '{print $2}'`
cd $mnt

if [ $# = 0 ]; then
	cd ./bus
	buslist=`echo *`
	cd ..
else
	buslist="$*"
	cd ./bus
	for bus in $buslist; do
		if [ ! -d $bus ]; then
			echo "$bus: unknown bus"
			exit 1
		fi
	done
	cd ..
fi

for bus in $buslist; do
	cd ./bus
	if [ -d $bus ]; then
		echo "$bus:"
		cd $bus
		if [ -d ./devices ]; then
			cd ./devices
			devs=`find . -type l -printf "%l\n"`
			for dev in $devs; do
				name=""
				if [ -d $dev ]; then
					if [ -f $dev/name ]; then
						name=`cat $dev/name`
					fi
				fi
				terse=`echo $dev|sed -e 's/\.\.\/.*devices\///'`
				echo "  $terse [ $name ]"
			done
			cd ..
		fi
		cd ..
		echo
	fi
	cd ..
done

--=-nb44skVVMckWgS2hC7si--

