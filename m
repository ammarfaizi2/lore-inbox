Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRKYOSR>; Sun, 25 Nov 2001 09:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRKYOR6>; Sun, 25 Nov 2001 09:17:58 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:29865 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S276249AbRKYORx>; Sun, 25 Nov 2001 09:17:53 -0500
Date: Sun, 25 Nov 2001 16:06:49 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: thocking@sun.com, andre@linux-ide.org,
        Jani Forssell <jani.forssell@viasys.com>, hahn@physics.mcmaster.ca
Subject: HPT370 + IBM-DPTA-373420 corrupt data on 2.2 _and_ 2.4
Message-ID: <20011125160649.I4809@niksula.cs.hut.fi>
In-Reply-To: <2173081930.1006455144@[195.224.237.69]> <20011122210503.B4809@niksula.cs.hut.fi> <20011122215424.C4809@niksula.cs.hut.fi> <20011123143502.D4809@niksula.cs.hut.fi> <20011123163932.E4809@niksula.cs.hut.fi> <20011123233211.F4809@niksula.cs.hut.fi> <20011124085201.G4809@niksula.cs.hut.fi> <20011124091704.H4809@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011124091704.H4809@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sat, Nov 24, 2001 at 09:17:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of the thread so far:
- I had differing md5sum when reading /dev/md0 several time 
  under 2.2.20 + idepatch
  - hw involved is 2x IBM-DPTA-373420 (32.5GB), both on their own 
    IDE channel as the sole device. 
  - HPT370 on Abit KT7A-RAID
  - Duron 900
  - the drives default to UDMA66
  - several BIOSes tried
- I managed to reproduce the md5sum failures reading /dev/hde and /dev/hdg
  although it was harder to trigger.
- It happened on 2.5.15 + Hockins' hpt patch as well
- It happened on 2.2.20+IDE with and without Hockin's patch
- It happened on 2.2.20+IDE even at UDMA33
- The thread starts here:
  http://marc.theaimsgroup.com/?l=linux-kernel&m=100645594530137&w=2


I managed to reproduce the corruption on 2.2.18pre19, UDMA66 as well. It
seems harder to trigger (took 9 runs), but eventually failed 10GB blocks out 
of 64. (other kernels usually failed 0-2 GB blocks per run.) 
                                          
What's interesting is that even though 2.2.18pre19 and 2.2.20 both default  
to UDMA66, 2.2.20 manages to pull 30-35MB/s off md0, whereas 2.2.18pre19
only gets ~25MB/s. I'm not sure why that is (different VM, tuning of
elevator, newer IDE patch, whatever), but that only could explain why it is 
harder to reproduce; different access pattern, slower read->less stress to  
the IDE subsystem. (2.4 also does 30-35MB/s.)

(Mark Hahn suggested I should try to compare the blocks - not just md5sum
them - to see which bytes differ.)
 
I wrote a little program to try compare 512MB blocks. This turned out
difficult, since the only drive in addition to these two striped IDE drives
(that constitute md0) is an oldish 18GB Seagate scsi, where the rootfs
resides. The Seagate can only write max. 15MB/s, so I really can't stream
the 512MB block anywhere at full speed. And I do need to store them
somewhere to be able to reread and compare. The block can't be much smaller
than 512MB since I have 256MB of ram, and I absolutely do not want the OS to
pull the 2nd (comparison) read from the cache.

Right now I have the 2nd run going, but at these read speeds:
   
  At reading block at 59392 MB...13.8 MB/s. Comparing...7.8 MB/s.  

I don't expect the IDE system to be stressed enough yield errors. (Reading
includes read 512MB off md0 + write 512MB to sda, compare includes 512MB
read from md0 + 512MB read from sda)
 
Anyhow, at this point I'm not really that interested in what bytes differ.
HPT370+IBM-DPTA-373420 + linux (be it 2.2+IDE, 2.4 or 2.4+Hockin's hpt
patch) corrupt data, end of story.
       
I think the next stunt to pull is to plug the beasts on the VIA 686B IDE. 
"Via 686B ide" doesn't have that trust-evoking sound either (which is why I
went the HPT370 path in the first place; I had had very good experinces with
HPT366 albeit albeit some consider that flaky as well). But, I guess I have
little to lose with 686B at this point...


-- v -

v@iki.fi
