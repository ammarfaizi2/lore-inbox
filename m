Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262732AbSJCFPK>; Thu, 3 Oct 2002 01:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbSJCFPK>; Thu, 3 Oct 2002 01:15:10 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:37047 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262732AbSJCFPI>; Thu, 3 Oct 2002 01:15:08 -0400
From: <peterc@gelato.unsw.edu.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 15:20:31 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15771.54175.218430.835917@lemon.gelato.unsw.EDU.AU>
Subject: [PATCH] Large Block device patch part 0/4
CC: neilb@cse.unsw.edu.au, axboe@suse.de
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks, 
   in the next 4 emails from me (which of course, you may receive
   out-of-order)  there is the next version of the Large Block Device
   patch against 2.5.40 that allows linux to transition to 64-bit
   sector_t, and so escape the 2TB block device size limit.

   This patch fixes the block layer, the SCSI and IDE midlayers, the
   loop device, and MD.  It has been tested in previous incarnations
   with the megaraid controller and up to 3.6TB of attached storage,
   and reviewed by various people including Jens Axboe, Christopher
   Hellwig, Neil Brown and Martin Dalecki.  I have not tested this
   version (although I'm reasonably confident it'll work) because
   software RAID is currently broken wrt recent block layer changes
   (MD can't cope with I/O requests that cross one of its zone
   boundaries).

   The only part I find horribly kludgy (a better solution is
   requested) is that to support RAID levels 0 through 5 with large
   block devices you really really need 64-bit division.  As nothing
   else needs it, I've linked gcc's division and remainder routines
   into md.o, and exported them as symbols (if you're using modules).

   Nothing else uses 64-bit division directly; for the few cases where
   it's needed I've included a sector_div() macro based on the div64()
   macro needed for printk.

   There are a couple of workarounds for gcc 2.96: gcc3.2 works a lot better.

Still to do:
      -- 16-byte SCSI commands (READ_CAPACITY_16, READ16, WRITE16 and
         the corresponding error paths).  I have an untested patch for
         that, but as far as I know, none of the drivers for cards I
         have access to at present understand the 16-byte command set.
      -- Better 64-bit support for the megaraid controller (that
         should be relatively easy)
      -- A major rewrite of MD (someone else do this please?  NeilB?)
         to allow software RAID members bigger than 2TB.
      -- the original (old) HD driver.

You can get the patch directly from the bk tree at
bk://gelato.unsw.edu.au:2023, or 
pick it up from http://www.gelato.unsw.edu.au/patches


Note to Neil and Jens: I'm not going to send the patches directly to you

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.

   
