Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290425AbSAXWkn>; Thu, 24 Jan 2002 17:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290431AbSAXWkg>; Thu, 24 Jan 2002 17:40:36 -0500
Received: from 203-79-66-98.adsl-wns.paradise.net.nz ([203.79.66.98]:8067 "HELO
	volcano.kiwa.co.nz") by vger.kernel.org with SMTP
	id <S290425AbSAXWkV>; Thu, 24 Jan 2002 17:40:21 -0500
Date: Fri, 25 Jan 2002 11:40:18 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: linux-kernel@vger.kernel.org
Cc: Jani Forssell <jani.forssell@viasys.com>,
        Ville Herva <vherva@niksula.hut.fi>
Subject: 2.4.18-pre3-ac2 still having problems (was Disk corruption - Abit KT7, 2.2.19+ide patches)
Message-ID: <20020124224017.GF555@inktiger.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	linux-kernel@vger.kernel.org,
	Jani Forssell <jani.forssell@viasys.com>,
	Ville Herva <vherva@niksula.hut.fi>
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a follow up on the previous report.

Replace the kernel with 2.4.18-pre3-ac2 which includes the recent ATA
driver from Andre Hedric.  NIC was moved from slot 3.


nic@hoppa:~$ cat /proc/ide/drivers 
ide-cdrom version 4.59
ide-disk version 1.12


Everything seemed to be running smoothly.

I performed the stress test mentioned here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101059003125783&w 
with the added complication of ping flooding and being ping flooded.


nic@hoppa:~$ sudo cat /dev/hda > /dev/null & sudo ping -f -s 64000 inktiger
[1] 445
PING inktiger.kpac.co.nz (192.168.9.108): 64000 data bytes
.....................................................................................................................................................................................................................................................................................................................................................................................................
--- inktiger.kpac.co.nz ping statistics ---
406 packets transmitted, 16 packets received, 96% packet loss
round-trip min/avg/max = 258.3/695.8/1783.5 ms
nic@hoppa:~$ uname -a
Linux hoppa 2.4.18-pre3-ac2 #3 Wed Jan 23 10:48:41 NZDT 2002 i686 unknown



I was going to say "Stable as a rock again", but I thought to soon. 

Five mintues later, down it goes:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=28086092, sector=2960368
end_request: I/O error, dev 03:07 (hda), sector 2960368
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=28086108, sector=2960376
end_request: I/O error, dev 03:07 (hda), sector 2960376
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=28086108, sector=2960384
end_request: I/O error, dev 03:07 (hda), sector 2960384

Start filling up the console.

Lucky I've got ext3 I think. Nope, as soon as the reboot gets to that
partition the above messages start filling up the console again.

fsck -c /dev/hda7 only makes things worse. Looks like I'll just have to
deep six that whole part of the drive.

Power reset - to reset the HD IDE bus - doesn't seem to help matters
either. Looks like the low-level format part of the drive might be
corrupted.


Note: /dev/hda7 is the /var mount point. I've noted before that often
problems with the drive and related to CUPS spool events. Network and
disk IO at the same time. 


Looks like that part of the drive is completely toasted. I wonder where
I sould send the bill too. I'm definitely thinking that I should not
even consider AMD/VIA solutions near core servers.


Default settings on boot:
[nic@inktiger:~] cat hdparm.log 

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3737/255/63, sectors = 60046560, start = 0
 busstate     =  1 (on)


-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            icq. 1612865 

                         Quixotic Eccentricity
