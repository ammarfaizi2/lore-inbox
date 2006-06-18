Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWFRNUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWFRNUp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWFRNUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:20:45 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:64705 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932207AbWFRNUo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:20:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XPvuaapX3jMpEhuea/MB2K/yHWzgDYdXwjnbzIR0saOqEW0nfdocFyNVfEdyYZkvMF3MFAjxDnfkgwv2d2GM1k/yfEtJirGMg1HVrZa32UXKXnl9Uju9Uome4Y32TraUcm3kdEx5Ps1MQOJ6QDTHp5897FLiB8OrSSccl8GOavY=
Message-ID: <b8bf37780606180620y6e980e04k5b35da2c61fa1d1f@mail.gmail.com>
Date: Sun, 18 Jun 2006 09:20:43 -0400
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "linux list" <linux-kernel@vger.kernel.org>
Subject: Support for SEEK_HOLE and SEEK_DATA for sparse files on lseek(2)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!

Jeff Bonwick, from Slab allocator and ZFS fame is asking for comments on
supporting SEEK_HOLE and SEEK_DATA for sparse files on lseek(2), like
stated in this snip:

"Portability
At this writing, SEEK_HOLE and SEEK_DATA are Solaris-specific. I
encourage (implore? beg?) other operating systems to adopt these
lseek(2) extensions verbatim (100% tax-free) so that sparse file
navigation becomes a ubiquitous feature that every backup and
archiving program can rely on. It's long overdue."

Here is the original source:
http://blogs.sun.com/roller/page/bonwick?entry=seek_hole_and_seek_data#comments

FULL TEXT from the source above:

SEEK_HOLE and SEEK_DATA for sparse files

A sparse file is a file that contains much less data than its size
would suggest. If you create a new file and then do a 1-byte write to
the billionth byte, for example, you've just created a 1GB sparse
file. By convention, reads from unwritten parts of a file return
zeroes.

File-based backup and archiving programs like tar, cpio, and rsync can
detect runs of zeroes and ignore them, so that the archives they
produce aren't filled with zeroes. Still, this is terribly
inefficient. If you're a backup program, what you really want is a
list of the non-zero segments in the file. But historically there's
been no way to get this information without looking at
filesystem-specific metadata.

Desperately seeking segments

As part of the ZFS project, we introduced two general extensions to
lseek(2): SEEK_HOLE and SEEK_DATA. These allow you to quickly discover
the non-zero regions of sparse files. Quoting from the new man page:

       o  If whence is SEEK_HOLE, the offset of the start of  the
          next  hole greater than or equal to the supplied offset
          is returned. The definition of a hole is provided  near
          the end of the DESCRIPTION.

       o  If whence is SEEK_DATA, the file pointer is set to  the
          start  of the next non-hole file region greater than or
          equal to the supplied offset.

        [...]

     A "hole" is defined as a contiguous  range  of  bytes  in  a
     file,  all  having the value of zero, but not all zeros in a
     file are guaranteed to be represented as holes returned with
     SEEK_HOLE. Filesystems are allowed to expose ranges of zeros
     with SEEK_HOLE, but not required to.  Applications  can  use
     SEEK_HOLE  to  optimise  their behavior for ranges of zeros,
     but must not depend on it to find all such ranges in a file.
     The  existence  of  a  hole  at the end of every data region
     allows for easy programming and implies that a virtual  hole
     exists  at  the  end  of  the  file. Applications should use
     fpathconf(_PC_MIN_HOLE_SIZE) or  pathconf(_PC_MIN_HOLE_SIZE)
     to  determine if a filesystem supports SEEK_HOLE. See fpath-
     conf(2).

     For filesystems that do not supply information about  holes,
     the file will be represented as one entire data region.

Any filesystem can support SEEK_HOLE / SEEK_DATA. Even a filesystem
like UFS, which has no special support for sparseness, can walk its
block pointers much faster than it can copy out a bunch of zeroes.
Even if the search algorithm is linear-time, at least the constant is
thousands of times smaller.

Sparse file navigation in ZFS

A file in ZFS is a tree of blocks. To maximize the performance of
SEEK_HOLE and SEEK_DATA, ZFS maintains in each block pointer a fill
count indicating the number of data blocks beneath it in the tree (see
below). Fill counts reveal where holes and data reside, so that ZFS
can find both holes and data in guaranteed logarithmic time.

      L4                           6
                  -----------------------------------
      L3          5                0                1
             -----------      -----------      -----------
      L2     3    0    2                       0    0    1
            ---  ---  ---                     ---  ---  ---
      L1    111       101                               001

    An indirect block tree for a sparse file, showing the fill count
in each block pointer. In this example there are three block pointers
per indirect block. The lowest-level (L1) block pointers describe
either one block of data or one block-sized hole, indicated by a fill
count of 1 or 0, respectively. At L2 and above, each block pointer's
fill count is the sum of the fill counts of its children. At any
level, a non-zero fill count indicates that there's data below. A fill
count less than the maximum (3L-1 in this example) indicates that
there are holes below. From any offset in the file, ZFS can find the
next hole or next data in logarithmic time by following the fill
counts in the indirect block tree.

Portability

At this writing, SEEK_HOLE and SEEK_DATA are Solaris-specific. I
encourage (implore? beg?) other operating systems to adopt these
lseek(2) extensions verbatim (100% tax-free) so that sparse file
navigation becomes a ubiquitous feature that every backup and
archiving program can rely on. It's long overdue.

Thank in advance,
-- 
[]s,
André Goddard
