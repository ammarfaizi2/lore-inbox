Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbTCGOHb>; Fri, 7 Mar 2003 09:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261592AbTCGOHa>; Fri, 7 Mar 2003 09:07:30 -0500
Received: from p0054.as-l043.contactel.cz ([194.108.242.54]:4088 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S261584AbTCGOH2> convert rfc822-to-8bit; Fri, 7 Mar 2003 09:07:28 -0500
To: linux-kernel@vger.kernel.org
Subject: NFS client with sync mount option to sloooow
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Fri, 07 Mar 2003 15:19:44 +0100
Message-ID: <m3d6l3s1hb.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have three systems connected via Gigabit Ethernet switch.

One is Dell PowerVault 770 with Windows 2000 Advanced server. This is NFS
appliance with RAID5 array (for now).

And there are two clients:

    - DELL PowerEdge600SC with original SuSE kernel 2.4.10 from 7.3 with
      CERC (megaraid) with IDE discs
    - one blade system PowerEdge 1655MC in a chassis with vanilla 2.4.20

Chassis contains already mentioned gigabit switch and every system is
connected to it. Here are some stats of the connections:

I used FTP server on PowerVault (Windows) and also on 600SC (Linux). Every
transfer with 896MB file (/tmp/kcore, direct copy from /proc).

FTP upload from 600SC to PowerVault took 45s.
FTP download to 600SC from PowerVault took 45s.

FTP upload from 1655MC to PowerVault took 18s
FTP download to 600SC from PowerVault took 24s.

FTP upload from 1655MC to 600SC took 82s
FTP download to 600SC from 600SC took 51s.

Now going to NFS:

Copy (I used dd) from the PowerVault (server) to 600SC (2.4.10, SuSE)
- with -o tcp sync/async (does not matter!! Why? Bug in 2.4.10?) took ~61s.
- with -o udp sync/async (does not matter!! Why? Bug in 2.4.10?) took ~92s.

Time for reverse direction (dd from local disc on 600SC to PowerVault):

- -o tcp,sync 92s
- -o udp,sync 92s

But when I used blade server 1655MC instead of 600SC here (with 2.4.20,
original) times are:

"TCP"	"Sync"	"20min56s"	"!!!!!!!!!!!!!!"
"TCP"	"Nosync"	"37s"	
"UDP"	"Sync"	"20min44s"	"!!!!!!!!!!!!!!"
"UDP"	"Nosync"	"83s"	

Ie.

2.4.20:~ mount -o tcp,sync PowerVault:/Share /mnt
2.4.20:~ time dd if=/tmp/kcore of=/mnt

This took unbelievable amount of 21minutes! Reverse direction is OK!

I tried to "upgrade" the kernel on 600SC from 2.4.10-SuSE (which is fast!)
to:

  - 2.4.20 vanilla
  - 2.4.20-SuSE from Hubert Mantel's next directory on ftp.suse.com
  - 2.4.20 from Red Hat phoebe
  - 2.4.21-pre5
  - 2.4.21-pre4-ac7

and everything was that slow. Only 2.4.10-SuSE from 7.3 is fast.

I also watched /proc/net/rpc/nfs.

In the case of async mount, there were about 28672 NFS write
operations. Ie. 896MB/32768. It used 32k blocks for doing async writes.

In the case of sync mount, there were about 1835008 NFS write
operations. Ie. 896MB/512. It used 512 B blocks for doing sync writes.

iptraf showed that sync transfer gave me about 1.6GB of traffic between
both servers!

I searched the Internet and found many people having similar
problems. There is even an entry in RH Bugzilla.

Oh, I forgot. Blade 1655MC uses tg3 driver and 600SC uses e1000. Shuffling
with rsize and wsize does not have effects.

Today I did other tests. I created a file /tmp/file:

00000000001111111111222222222233333333334444444444555555555566.....999999

This line is repeated so the total length of the file is:

-rw-r--r--    1 pavel    users     1010000 2003-03-06 15:04 file

Then I did this on 600SC:

mount -o tcp powervault:/Share /mnt
time dd if=/tmp/file of=/mnt/file

I used both 2.4.10-SuSE and 2.4.20-vanilla to gather tcpdump output from
both sync and async NFS writes. I put complete archive of this to

wget http://www.janik.cz/tmp/out.tar.gz

I have permanent access to this equipment so I can test everything you tell
me. I do not have Internet connection there so it could take some time to
reply, but I surely will reply!

Thank you for helping me!
-- 
Pavel Janík

Right now Mr McVoy prohibits me from reviewing your patches.
                  -- Alan Cox in LKML
