Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTKNEtn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 23:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTKNEtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 23:49:43 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9898 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262174AbTKNEti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 23:49:38 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Date: Fri, 14 Nov 2003 14:11:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
Subject: [RFCI] How best to partition MD/raid devices in 2.6
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


RFCI == Request For Clever Ideas.

Hi all..

 I want be able to partition "md" raid arrays.
 e.g. I want to be able to use RAID1 to mirror sda and sdb as whole
 drives, and then partitions that into root, swap, other (or whatever
 suits the particular situation).

 I am already doing this on 2.4 based kernels using a local patch
 which is unlikely ever to get into the kernel.

 This patch declares a new major number and uses it to address upto 15
 partitions on each of the first 16 md arrays.
 Not only does this limit you do only partitioning 16 md arrays, but
 it means that there are two separate devices (major+minor) that
 access the same device.  In 2.4 this is just untidy.  In 2.6 it would
 also subvert the exclusive access provided by bd_claim, and that
 isn't a good thing. 

 So I'm looking for a nice clean way to provide partitioning of md
 devices in 2.6.
 In 2.6 we have 20 bits for minor number and I am quite happy to
 require the use of them - i.e. there is no need for the approach to
 work equally well in 2.4.

 Backwards compatibility is fairly important, and that means that the
 first 256 minor numbers for block major number '9' have to still be
 whole md arrays.

 Some options that occur to me are:

 1/ compile time option that redefines major 9 to use 6 bits for
   partition information.  This throws backwards compatibility out the
   window and is a nice clean way forward.  I think this would be a
   support nightmare and I wouldn't impose it on anyone.

 2/ new major number which uses 6 bits for partitioning and provide
   some sort of interlock so that you cannot access the same raid
   array from both the old and the new major at the same time.
   I'm not sure how easy the interlock would be, but it is probably
   do-able.  The problem is that I would like a well-defined major
   number and Linus doesn't seem keen on any more of those (though I
   realise that isn't unanimous).
   There was once talk of a 'disk' major number and all the things
   that looked like discs would come under that somehow, but that
   doesn't seem to have eventuated.  Maybe it should, but there would
   still be the interlock problem

 3/ define minor numbers of block-major-9 that are larger than 255 to
   have 6 bits of partitioning information. i.e.
     9,0 -> md0
     9,1 -> md1
      ...
     9,255 -> md255
     9,256 -> md256
     9,257 -> md256p1
     9,257 -> md256p2
      ...
     9,320 -> md257
     9,321 -> md257p1
      ...
   This has least impact on other system and is in some ways simplest,
   but it has the problem of lack of uniformity.  You wouldn't be able
   to partition md0, but that isn't a big problem as long as you can
   partition some md arrays.

 4/ just use 'dm', or write a new 'md' module that can present a
    partition of a device.  Then leave the setup to user-space.
    This is least impact on the kernel, but most impact on
    user-space.  It would not be too hard to create a userspace tool
    that made most of this fairly transparent.
    Particularly if it was a new 'md' personality, userspace could
    then effectively decide how the minor numbers of block-major-9
    were used with respect to partitioning.


There are probably other options and I would be happy to hear them.
My personal preference is wavering between 4 (using md) and 2.
Possibly I should learn more about how 'dm' could handle it for me..

Opinions welcome,
Thanks,
NeilBrown
