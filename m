Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316533AbSEPFys>; Thu, 16 May 2002 01:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316581AbSEPFys>; Thu, 16 May 2002 01:54:48 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:38090 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316533AbSEPFyq>; Thu, 16 May 2002 01:54:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Stephen C. Tweedie" <sct@redhat.com>
Date: Thu, 16 May 2002 15:54:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15587.18828.934431.941516@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Thoughts on using fs/jbd from drivers/md
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen, 
  You mentioned to me some time ago the idea of using jbd to journal
  RAID5 changes so as to improve recovery for raid5 from a crash.   It
  didn't get very high on my list of priorities at the time, but I
  have been thinking about it a bit more lately and thought I would
  share my thoughts with you and the readership of linux-kernel in the
  hope than any misunderstanding might get cleared up and some
  improvements might be suggested.

  I don't know if or when I will get time to implement any of this,
  but one never knows...


The basic idea is to provide journaling for md/RAID arrays.  There
are two reasons that one might want to do this:
 1/ crash recovery.  Both raid1 and raid5 need to reconstruct the
   redundancy after a crash.  For a degraded raid5 array, this is not
   possible and you can suffer undetected data corruption.
   If we have a journal of recent changes we can avoid the
   reconstruction and the risk of corruption.

 2/ latency reduction.  If the journal is on a small, fast device
   (e.g. NVRAM) then you can get greatly reduced latency (like ext3 with
   data=journal).   This could benefit any raid level and would
   effectively provide a write-behind cache.

I think the most interesting version in an NVRAM journal for a RAID5
array, so that is what I will focus on.  If that can be made to work
then any other configuration should fall out.

A/ where to put the journal.
 Presumably JBD doesn't care where the journal is.  It's client just
 provides a mapping from journal offset to dev/sector and JBD just
 calls submit_bh with this information(?).
 The only other requirement that the JBD places would be a correct jbd
 superblock at the start.  Would that be right?

 Having it on a separate device would be easiest, particularly if you
 wanted it to be on NVRAM.
 The md module could - at array configuration time - reserve the
 head (or tail) of the array for a journal.  This wouldn't work for
 raid5 - you would need to reserve the first (or last) few stripes and
 treat them as raid1 so that there is no risk of data loss.  
 I'm not sure how valuable having a journal on the main raid devices
 would be though as it would probably kill performance...

B/ what to journal.

 For raid levels other than 4/5, we obviously just journal all data
 blocks.  There are no interdependencies or anything interesting.

 For raid4/5 we have the parity block to worry about.
 I think we want to write data blocks to the journal ASAP, and then
 once parity has been calculated for a stripe we write the parity
 block to the journal and then are free to write the parity and data
 to the array.

 On journal replay we would collect together data blocks in a stripe
 until we get a parity block for that stripe.
 When we get a parity block we can write the parity block and
 collected data block to the array.  If we hit the end of the journal
 before getting a parity block, then we can assume that the data never
 hit the array and we can schedule writes for the data blocks as
 normal.

 The only remaining issue is addressing. The journal presumably
 doesn't know about "parity" or "data" blocks.  It just knows about
 sector addresses.
 I think I would tell the journal that data blocks have the address
 that they have in the array, and parity block, which don't have an
 address in the array, have an address which is the address on the
 disc, plus some offset which is at least the size of the array.
 Would it cause JBD any problems if the sector address it is given is
 not a real address on any real device but is something that can be
 adequately interpreted by the client?

C/ data management.

 One big difference between a filesystem using JBD and a device driver
 using JBD is the ownership of buffers.
 It is very important that a buffer which has been written to the
 journal not be changed before it gets written to the main storage, so
 ownership is important.

 As I understand it, the filesystem owns it's buffers and can pretty
 much control who writes and when (a possible exception being mem-mapped
 buffers, but they aren't journaled except with data=journal...).
 This it can ensure that the same data that was written to the journal
 is written to the device.

 However a device drive does not own the buffers that it uses. It
 cannot control changes and it cannot be sure that the buffer will
 still even exist after it has acknowledged a write.
 RAID5 faces this problem as it needs to be sure that the data used
 for the parity calculation is the same as the data that ends up on
 disc.  To ensure this raid5 makes a copy of the data after doing any
 necessary pre-reading and just before making the final parity block
 calculation. 

 When journaling raid5, we could use the same approach: copy to the
 buffer, write to the journal, and then write to the main array.  Not
 only would this not work for other raid levels, but it would not be
 ideal for raid5 either.  This is because one of our aims is reducing
 latency, and if we had to wait for pre-reading to complete before
 writing to the journal, we would lose that benefit.  We could
 possibly copy to the same buffer earlier, but that would cause other
 problems - when doing read-modify-write parity update, we pre-read
 into the buffer that we will later copy the new data into, so we
 would need to allocate more buffers. (Is that coherent?)

 It seems that we need a generic buffer-cache in front of the md
 driver:
   - A write request gets copied into a buffer from this cache
   - the buffer gets written to the journal
   - the original write request gets returned
   - the buffer gets written to the array

 This would work, but means allocating lots more memory, and adds an
 extra mem-to-mem copy which will slow things down.

 The only improvement that I can think of would only work with an
 NVRAM journal device.  It involves writing to the journal and then
 acknowledging the write - with minimal latency - and then reading the
 data back in off the journal into a buffer that then gets written to
 the main device.
 This would possibly require less memory and give less latency.  But
 it would be doing an extra DMA over the PCI buss, rather than a
 mem-to-mem copy.  Which causes least overhead?

 A variation of this could be to write to the main storage directly
 out of the NVRAM.  This could only work on devices that can be
 completely mapped into the pci address space, which some can...

 I feel that the best approach would be to implement two options:
  1/ write straight to the journal and then read-back for writing to
     the device.  This would be used when the journal was on NVRAM and
     would be the only option for raid levels other than raid5.
  2/ Write to the journal after doing a parity calculation and before
     writing a new stripe to disc.  This would only be available with
     raid5 and would (probably) only be used if the journal was on a
     disc drive (or mirrored pair of disc drives).

That's about all my thoughts for now.
All comments welcome.

Now it's probably time for me to go read
   http://lwn.net/2002/0328/a/jbd-doc.php3
or is there something better?

NeilBrown
