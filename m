Return-Path: <linux-kernel-owner+w=401wt.eu-S1750821AbXAEWhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbXAEWhP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 17:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbXAEWhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 17:37:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:51002 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXAEWhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 17:37:12 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: RFC: Stable inodes for inode-less filesystems (was: Finding hardlinks)
To: Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>,
       bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 05 Jan 2007 23:36:54 +0100
References: <7vc91-5DA-11@gated-at.bofh.it> <7vfJT-64R-3@gated-at.bofh.it> <7x0n7-2Dk-5@gated-at.bofh.it> <7x0na-2Dk-21@gated-at.bofh.it> <7x5mR-2wX-3@gated-at.bofh.it> <7x9Ad-18O-35@gated-at.bofh.it> <7yXEy-UI-39@gated-at.bofh.it> <7yYKa-2Ds-3@gated-at.bofh.it> <7zcWP-7ET-5@gated-at.bofh.it> <7zdzA-jc-27@gated-at.bofh.it> <7zdJh-xh-37@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H2xgF-0000fu-09@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

>> Another idea is to export the filesystem internal ID as an arbitray
>> length cookie through the extended attribute interface.  That could be
>> stored/compared by the filesystem quite efficiently.
> 
> How will that work for FAT?

> Or maybe we can relax that "inode may not change over rename" and
> "zero length files need unique inode numbers"...

I didn't look into the code, and I'm not experienced in writing (linux)
fs, but I have an Idea I'd like to share. Maybe it's not that bad ...

(I'm going to type about inode numbers, since having constant inodes
 is desired and the extended attribute would only be an aid if the
 inode is too small.)

IIRC, no cluster is reserved for empty files on FAT; if I'm wrong, it'll
be much easier, you would just use the cluster-number (less than 32 bit).

The basic idea is to use a different inode range for non-empty and empty
files. This will result in the inode possibly changing after close()* or
on rename(empty1, empty2). OTOH it will keep a stable inode for non-empty
files and for newly written files** if they aren't stat()ed before writing
the first byte. I'm not sure if it's better than changing inodes after
$randomtime, but I just made a quick strace on gtar, rsync and cp -a;
they don't look at the dest inode before it would change (or at all).

(If this idea is applied to iso9660, the hard problem will be finding the
 number of hardlinked files for one location)

Changing the inode# on the last close* can be done by purging the cache
if the file is empty XOR the file has an inode# from the empty-range.
(That should be the same operation as done by unlink()?)
A new open(), stat() or readdir should create the correct kind of inode#.

*) You can optionally just wait for the inode to expire, but you need to
   keep the associated reservation(s) until then. I don't expect any
   visible effect from doing this, but see ** from the next paragraph
   on how to minimize the effect. The reserved directory entry (see far
   below in this text) is 32 Bytes, but the fragmentation may be bad.
**) which are empty on open() and therefore don't yet have a stable inode#
   Those inode numbers will apear to be stable because nobody saw them
   change. It's safe to change the inode# because by reserving disk space,
   we got a unique inode#. I hope the kernel side allows this ...


For non-empty files, you can use the cluster-number (start address), it's
unique, and won't change on rename. It will, however, change on emptying
or writing to an empty file. If you write to an empty file, no special
handling is required, all reservations are implicit*. If you empty a file,
you'll have to keep the first cluster reserved** untill it's closed,
otherwise you'd risk an inode collision.

*) since the inode# doesn't change yet, you'll still have to treat it like
   an empty file while unlinking or renaming.
**) It's OK to reuse it if it's in the middle of a file, so you may
    optionally keep a list of these clusters and not start files there
    instead of reserving the space. OTOH, it's more work.


Empty files will be a PITA with 32-bit-inodes, since a full-sized FAT32 can
have about 2^38 empty files*. (The extended attribute would work as described
below.) You can, however, generate inode numbers for empty files, risking
collisions. This requires all generated inode numbers to be above 0x40000000
(or above the number of clusters on disk).

*) 8 TB divided by 32 B / directory entry

With 64-bit-values, you can generate an unique inode for empty files
using cluster#-of-dir | 0x80000000 | index_in_dir << 32. The downside
is, it will change on cross-directory-renames and may change on in-
directory-renames. If this happens to an open file, you'll need to
make sure the old inode# is not reused by reserving that directory
entry, since the inode# can't change for open files.


extra operations on final close:
if "empty" inode:
 if !empty
  unreserve_directory_entry(inode & 0x7fffffff, inode >> 32)
  uncache inode (will change inode#)
  stop
 if unreserve_directory_entry(inode & 0x7fffffff, inode >> 32)
  uncache inode
if "non-empty" inode
 if empty
  free start cluster
  uncache inode

extra operations on unlink/rename:
if "empty" inode:
 if can_use_current_inode#_for_dest
  do it
  unreserve_directory_entry(inode & 0x7fffffff, inode >> 32)
  // because of "mv a/empty b/empty; mv b/empty a/empty"
 else if is_open_file
  // the current inode won't fit the new location:
  reserve_directory_entry(old_inode & 0x7fffffff, inode >> 32)

extra operations on truncate
if "non-empty" inode && empty_after_truncate
 exempt start cluster from being freed,
 or put it on a list of non-startclusters

extra operation on extend
if "empty" inode && nobody did e.g. stat() after opening this file
 silently change inode, nobody will notice. Racy? Possible?


Required data in filehandle:
 Location of directory entry (d.e. contains inode information)
  (this shouldn't be new data?)
 stat-flag (possibly one per filesystem is enough)
Directories additionally:
 Pointer to a list of reserved directory entries (usurally NULL)

Required data in Superblock:
 ->Optional List of non-startclusters

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
