Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154008AbQDDQ3r>; Tue, 4 Apr 2000 12:29:47 -0400
Received: by vger.rutgers.edu id <S154346AbQDDQZ1>; Tue, 4 Apr 2000 12:25:27 -0400
Received: from ix.netcorps.com ([207.1.125.106]:61972 "EHLO ix.netcorps.com") by vger.rutgers.edu with ESMTP id <S153994AbQDDQSo>; Tue, 4 Apr 2000 12:18:44 -0400
Message-ID: <38EA14F4.DED528F6@timpanogas.com>
Date: Tue, 04 Apr 2000 10:14:44 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: Recomended Page Cache Enhancement for 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu



Something the Windows 2000 IFS allows you to do that we exploit in NWFS
on Windows 2000 File System is map the extents for a file as lists of
contiguous sector runs.  These runs get stored in MDL lists that are
chained off the VM Cache Manager in Windows 2000.  When the cache
manager pushes a group of dirty pages onto the disk, it references these
lists, and if any of them are contingous runs of sectors (for example,
multiple pages may all reside in continguous sectors i.e. 100K of dirty
pages may all start at sector x and run fully contiguous to x + size of
the entire device).  They have a method of being able to pass these
lists to the drivers and the driver will issue a single I/O request for
all of these sectors (some controllers can take a request for 1000+
sectors at one time, and do them in one I/O).  NTFS gets very high
performance using this technique, and from what I have seen in 2.4, this
would seem to be the only remaining implementation difference between
the two implementations of NT Cache Manager vs. Linux 2.4 VFS and Page
Cache, and explains why Windows 2000 is still slightly faster in some
configuratins than Linux in benchmark testing.  

In NWFILE.C, line 1364 and line 1488 are two functions that the W2K IFS
calls to obtain run information for a file in NWFS.  The page cache in
linux seems very close.  What would be interesing (and would boost page
cache performance), would be for the VFS page cache interface to support
getting large runs for multiple dirty pages that are contiguous in a
file (since they will probably be contiguous on a disk -- we use a 64K
cluster size, which is always 16 contiguous pages, a file allocates
clusters or chunks of 16 pages, if striping is not enabled, clusters can
also span and be contiguous as well).

What would be involved is the ability for the page cache to ask for
contiguous runs for multiple page writes (i.e. if the page cache knows
it is writing multiple contiguous pages, call the VFS in the file system
to see if they are also sequential on the disk, and send them as a
single I/O requests to the driver, or allow the VFS to do so within the
file system -- this is what W2K does).    

I believe these optimizations will increase the performance of all the
File Systems in Linux (and NWFS) and bring Linux FS performance on par
with W2K in those configuration where NTFS is slightly faster than
Linux. 

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
