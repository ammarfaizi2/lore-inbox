Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313946AbSDKBfQ>; Wed, 10 Apr 2002 21:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313947AbSDKBfP>; Wed, 10 Apr 2002 21:35:15 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:36504 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S313946AbSDKBfP>; Wed, 10 Apr 2002 21:35:15 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Date: Thu, 11 Apr 2002 11:38:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15540.59659.114876.390224@notabene.cse.unsw.edu.au>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: message from Richard Gooch on Wednesday April 10
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday April 10, rgooch@ras.ucalgary.ca wrote:
> 
> The device is set up (i.e. SCSI host driver is loaded) long before I
> do raidstart /dev/md/0

raidstart simply does not and cannot work reliably when your device
numbers change around.  It takes the first device listed in
/etc/raidtab and gives it to the kernel.
The kernel reads the superblock, finds some device numbers and tries
to attach those devices.  If device number have changed, you loose.

autodetect is the other alternative.  However, as has been mentioned,
it does not and cannot work with md as a module.  This is because
devices can only be register for autodetection after md.o is loaded,
and autodetection is done at the time that md is loaded.  So
autodetection can only work if the device driver and md are loaded at
simultaneously.  i.e. they are compiled into the kernel.

I use and recommend mdadm.
  http://www.cse.unsw.edu.au/~neilb/source/mdadm/
(I hope to release a 1.0 in the next week or so).

With mdadm you can assemble devices whenever you like based on uuid in
the superblock.

Assuming you use devfs :-)
Create /etc/mdadm.conf containing:

  DEVICE /dev/scsi/*/*/*/*/part*

[[ you should be able to say

   DEVICE /dev/discs/*/part*

  but glob(3) gets confused by that :-(
]]

and run

   mdadm -Es >> /etc/mdadm.conf

Then edit /etc/mdadm.conf removing bits that are wrong, and changing
bits that need changing.  The mdadm.conf.5 to understand what should
be there.

You will need to:
   get rid of the "devices=" parts
   Make sure no extra arrays were found.

Once you have done this, then

  mdadm -As

in your startup scripts will assemble your arrays.

Make sure you use mdadm-0.8.2.  I found a little bug in 0.8.1 as I was
testing this example.

NeilBrown
