Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291834AbSBHVbQ>; Fri, 8 Feb 2002 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291840AbSBHVbD>; Fri, 8 Feb 2002 16:31:03 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:1798 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S291829AbSBHVMn>;
	Fri, 8 Feb 2002 16:12:43 -0500
Date: Fri, 8 Feb 2002 12:36:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Heinz Diehl <hd@cavy.de>, linux-kernel@vger.kernel.org
Subject: WARNING: 2.5.3 -- IDE damages data! [was Re: Warning, 2.5.3 eats filesystems]
Message-ID: <20020208113649.GC117@elf.ucw.cz>
In-Reply-To: <20020206233051.GA503@chiara.cavy.de> <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> > > > beware.
> > 
> > > I can confirm that there are filesystem corruption issues with 2.5.3;
> > > after this message I rebooted and did a forced fsck which turned up
> > > around a half dozen inodes where the block count in the inode itself was
> > > too high.
> > 
> > Exactly the same thing here, and I bet it _is_ 2.5.3 and not a relict from
> > a 2.5.3-pre patch because I switched directly from 2.4.17 to 2.5.3
> > without ever using any pre patch at this machine.
> 
> Very interesting.  Which filesystems are mounted (other than ext2) and
> are you been able to reproduce it on 2.5.3-pre6?

[This is ext2 machine, IDE is 

  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 195).
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0x1000 [0x100f].

]


I did more testing, and yes, 2.5.3 does data corruption. This appeared
in syslog:

Feb  8 12:08:02 amd kernel: hda: status timeout: status=0xd0 { Busy }
Feb  8 12:08:02 amd kernel: hda: drive not ready for command
Feb  8 12:08:02 amd kernel: ide0: reset: success
Feb  8 12:09:26 amd kernel: hda: status timeout: status=0xd0 { Busy }
Feb  8 12:09:26 amd kernel: hda: drive not ready for command
Feb  8 12:09:26 amd kernel: ide0: reset: success
Feb  8 12:12:27 amd kernel: hda: status timeout: status=0xd0 { Busy }
Feb  8 12:12:27 amd kernel: hda: drive not ready for command
Feb  8 12:12:27 amd kernel: ide0: reset: success
Feb  8 12:13:05 amd log1n[103]: ROOT LOGIN on `tty6'
Feb  8 12:15:00 amd sendmail[150]: alias database /etc/aliases.db out
of date
Feb  8 12:15:00 amd sendmail[150]: MAA00150: from=pavel, size=2519,
class=0, pri=62519, nrcpts=2, msgid=<20020208111457.GA117@elf.ucw.cz>,
relay=pavel@localhost
Feb  8 12:15:04 amd sendmail[152]: MAA00150:
to=linux-kernel@vger.kernel.org,viro@math.psu.edu, ctladdr=pavel
(8/100), delay=00:00:04, xdelay=00:00:04, mailer=relay,
relay=[10.0.0.1] [10.0.0.1], stat=Sent (MAA10440 Message accepted for
delivery)
Feb  8 12:18:17 amd kernel: hda: status timeout: status=0xd0 { Busy }
Feb  8 12:18:17 amd kernel: hda: drive not ready for command
Feb  8 12:18:18 amd kernel: ide0: reset: master: error (0x00?)

And this happened on console:

croot@amd:~# cat /dev/urandom > /tmp/delme

root@amd:~# ls -al /tmp/delme
-rw-r--r--    1 root     root     246845440 Feb  8 12:11 /tmp/delme
root@amd:~# cp /tmp/delme /tmp/delme2
root@amd:~# cp /tmp/delme /tmp/delme3
root@amd:~# cp /tmp/delme /tmp/delme4
root@amd:~# md5sum /tmp/delme*
2da1568c45e298938353672d3a642714  /tmp/delme
bc99762f3cf9a104e58e3f5708eeba99  /tmp/delme2
2da1568c45e298938353672d3a642714  /tmp/delme3
2da1568c45e298938353672d3a642714  /tmp/delme4
root@amd:~# cd /tmp
root@amd:/tmp# ls -al delme delme2 delme3
-rw-r--r--    1 root     root     246845440 Feb  8 12:11 delme
-rw-r--r--    1 root     root     246845440 Feb  8 12:14 delme2
-rw-r--r--    1 root     root     246845440 Feb  8 12:17 delme3
root@amd:/tmp#

As you can see, delme2 was damaged. I tried to do some heavy reads,
but those seem to be okay.

root@amd:/tmp# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2432/255/63, sectors = 39070080, start = 0
 busstate     =  1 (on)
root@amd:/tmp#

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
