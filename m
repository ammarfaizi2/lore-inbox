Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318837AbSG0WR7>; Sat, 27 Jul 2002 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSG0WR5>; Sat, 27 Jul 2002 18:17:57 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:47612 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318837AbSG0WRz>; Sat, 27 Jul 2002 18:17:55 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Austin Gonyou" <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "Ville Herva" <vherva@niksula.hut.fi>, "DervishD" <raul@pleyades.net>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sat, 27 Jul 2002 15:22:04 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECOEPFCPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1027803522.18360.17.camel@UberGeek.digitalroadkill.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>You really must think beyond the desktop as well. With large servers
>running many databases, or a single large database, you will inherently
>use swap. Maybe not much, but it will get used.
>On a P4 Xeon 1MB L3 server with 8GB ram, I've got 4GB swap configured,
>and use about 2 of that with a 4 oracle instances running. The largest
>instance is ~700GB, whereas the 4 others are ~30GB ea.

>In this scenario you have a large SHMMAX defined (4GB in this case), or
>50% available RAM. As Oracle, Java, and other bits are used in the
>system threading or not, most of the entirety of the availble ram will
>eventually get used. The available to cache ratio on a box like this
>with 2.4.19-rc1 is ~2% free ram, and 95% cached, and 3% active.
>Swap is ~50% right now. So regardless of how much ram you have, you will
>swap some, somewhere.


I thought linux worked more like Solaris where it didn't use any swap (AT
ALL) until it has to... At least, I hope linux works this way.

I manage a couple of Sun E10K domains (currently 20 procs, 20GB ram) running
Oracle instances that are in excess
of 1.5TB (for a single instance, this is considered very large for OLTP
based usage of an Oracle instance)
and we rarely see any use of our swap devices.

Solaris uses a two handed clock algorithm that traverses the PTE's for all
pages in the system.
The 1st hand resets the MMU reference and modified bits for a given page and
the second hand checks to see if the reference
or modified bit has been flipped since the 1st hand reset it.
If not, it ( > Solaris 2.5.1 with priority paging or Solaris 8 ) checks to
see if the page is a filesystem
page and if so, flushes it to it's backing store (the filesystem), if it's
an anoymous page then it may or may
not send that page to swap (depending how memory deprived the system is,
there are several watermarks that trigger different behavior).
Pages that are mapped in MAP_PRIVATE and executable are skipped over until
the system is seriously deprived of physical memory.

I believe Linux does something similar (even though the implementations
probably look completely different)...

The point to make here is that this mechanism doesn't even kick in until
free physical memory on the system drops
to a low watermark (in Solaris it could be cachefree or lotsfree depending
on version and whether it's using priority paging).
Your not gonna have *anything* on the swap device until you have reached one
of these watermarks (1/64 physical memory free in Solaris 8).

Solaris recently added an option to vmstat to look at paging statistics. It
nicely seperates out executable anonymous and filesystem page in/outs. Heres
some sample output fom one of the domains mentioned above:

# uname -a
SunOS <hostname removed> 5.8 Generic_108528-07 sun4u sparc
SUNW,Ultra-Enterprise-10000
# prtconf | head
System Configuration:  Sun Microsystems  sun4u
Memory size: 20480 Megabytes
System Peripherals (Software Nodes):

SUNW,Ultra-Enterprise-10000
    packages (driver not attached)
        terminal-emulator (driver not attached)
        deblocker (driver not attached)
        obp-tftp (driver not attached)
        disk-label (driver not attached)

# vmstat -p 2
     memory           page          executable      anonymous
filesystem
   swap  free  re  mf  fr  de  sr  epi  epo  epf  api  apo  apf  fpi  fpo
fpf
 80330680 10599432 2613 14569 352 0 8 144 3    3   16   38   38 1294  382
310
 79949440 11044024 3 234 0  0   0    0    0    0    0    0    0    0    0
0
 79946224 11041472 0 286 0  0   0    0    0    0    0    0    0    0    0
0
 79940672 11037392 0 227 0  0   0    0    0    0    0    0    0    0    0
0
 79939440 11035592 0 0  0   0   0    0    0    0    0    0    0    0    0
0
 79936296 11031664 12 577 28 0  0    0    0    0    0    0    0    0   28
28
 79934240 11030512 51 249 0 0   0    0    0    0    0    0    0    0    0
0
 79931920 11029176 18 227 172 0 0    0    0    0    0    0    0    0  172
172
 79930704 11028264 0 58 0   0   0    0    0    0    0    0    0    0    0
0
 79926096 11025032 3 205 0  0   0    0    0    0    0    0    0    0    0
0
 79927752 11024472 57 691 0 0   0    0    0    0    0    0    0    0    0
0
 79922632 11019248 0 223 0  0   0    0    0    0    0    0    0    0    0
0
 79920776 11017768 98 984 0 0   0    0    0    0    0    0    0    0    0
0


So as you can see here, using the process described above, the system hit a
point where it was low on physical memory, turned the scanner on (name for
the clock algorithm described above) and it found some filesystem pages to
flush to their backing store that have not been used recently. Nothing went
to the swap device.

Now there is a little sitting on the swap device here, but this system has
been up for several days. What im stressing here is that it doesn't normally
use the swap devices at all.

When you size your DB you have control over how much memory is used for
buffer caches and sort area (for hash joins, etc..). you should be able to
size your instances so that they only occasionally hit the swap device. Now
if you can't afford the correct amount of hardware to stay off the swap
device, then that's another story, but what you imply above is that you
always use the swap device when runnning large DB's, and that just doesn't
make any sense to me.

--Buddy

