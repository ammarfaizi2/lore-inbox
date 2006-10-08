Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWJHJxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWJHJxe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWJHJxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:53:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:114 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750922AbWJHJxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:53:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MVrLz5/Eih7b+KjdHiBbEvHQO9LcNNyY3a5UK1doKrUcvloiRMpyqZ6mvJRXv3cPiKv8r9t9c6mMEViQ+LNwf2BvqoAhDI+Jk81p23FHmqTT6PdNHtQRq0WAQGI6v9dIuy0JSwMf2BqQ4MdkiEUXWZlC1jB4GSxmlI8WFWlCZJY=
Message-ID: <4528CAAC.6070406@gmail.com>
Date: Sun, 08 Oct 2006 11:53:25 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.com, adilger@clusterfs.com, linux-ext4@vger.kernel.org
Subject: Re: 2.6.18-mm2: ext3 BUG?
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org> <4525925C.6060807@gmail.com> <20061005171428.636c087c.akpm@osdl.org> <20061008063330.GA30283@lug-owl.de> <20061008084816.GF30283@lug-owl.de>
In-Reply-To: <20061008084816.GF30283@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Sun, 2006-10-08 08:33:30 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>> dd bs=1M count=200 if=/dev/zero of=test0
>> while :; do
>> 	echo "cp 0-1"; cp test0 test1 || break
>> 	echo "cp 1-2"; cp test1 test2 || break
>> 	echo "cp 2-3"; cp test2 test3 || break
>> 	echo "cp 3-4"; cp test3 test4 || break
>> 	echo "od 0" ; od test0 || break
>> 	echo "rm 1"; rm test1 || break
>> 	echo "rm 2"; rm test2 || break
>> 	echo "rm 3"; rm test3 || break
>> 	echo "rm 4"; rm test4 || break
>> done
> 
> Just tested again and got *exactly* the same error message, bit
> already cleared for block 194810, but this time after only 20min:
> 
>> EXT3-fs error (device dm-5): ext3_free_blocks_sb: bit already cleared for block 194810
>> Aborting journal on device dm-5.
>> ext3_abort called.
>> EXT3-fs error (device dm-5): ext3_journal_start_sb: Detected aborted journal
>> Remounting filesystem read-only
>> EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has aborted
>> EXT3-fs error (device dm-5) in ext3_truncate: Journal has aborted
>> EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has aborted
>> EXT3-fs error (device dm-5) in ext3_orphan_del: Journal has aborted
>> EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has aborted
>> __journal_remove_journal_head: freeing b_committed_data
>> __journal_remove_journal_head: freeing b_committed_data
>> __journal_remove_journal_head: freeing b_committed_data
>>
>>
>> Last echoes from the testcase above:
>>
>> rm 1
>> rm 2
>> rm: cannot remove `test2': Read-only file system
> 
> ...and with exactly the same position it broke again.
> 
>> kolbe34-backup:/mnt# dumpe2fs /dev/kolbe34_backup/ext3crash 2>/dev/null | grep features
>> Filesystem features:      has_journal resize_inode dir_index filetype needs_recovery sparse_super large_file
> 
> However, fsck looks a bit different this time:
> 
> kolbe34-backup:/mnt# e2fsck -jy /dev/kolbe34_backup/ext3crash
> e2fsck 1.39 (29-May-2006)
> /dev/kolbe34_backup/ext3crash: recovering journal
> /dev/kolbe34_backup/ext3crash contains a file system with errors, check forced.
> Pass 1: Checking inodes, blocks, and sizes
> Deleted inode 49154 has zero dtime.  Fix<y>?
> 
> /dev/kolbe34_backup/ext3crash: e2fsck canceled.
> 
> /dev/kolbe34_backup/ext3crash: ***** FILE SYSTEM WAS MODIFIED *****
> 
> /dev/kolbe34_backup/ext3crash: ********** WARNING: Filesystem still has errors **********
> 
> kolbe34-backup:/mnt# e2fsck -fy /dev/kolbe34_backup/ext3crash
> e2fsck 1.39 (29-May-2006)
> Pass 1: Checking inodes, blocks, and sizes
> Deleted inode 49154 has zero dtime.  Fix? yes
> 
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Block bitmap differences:  -(107533--124927) -(178242--194673)
> Fix? yes
> 
> Free blocks count wrong for group #3 (7686, counted=25081).
> Fix? yes
> 
> Free blocks count wrong for group #5 (1933, counted=18366).
> Fix? yes
> 
> Free blocks count wrong (15196903, counted=15230731).
> Fix? yes
> 
> Inode bitmap differences:  -49154
> Fix? yes
> 
> Free inodes count wrong for group #3 (16379, counted=16380).
> Fix? yes
> 
> Free inodes count wrong (7864304, counted=7864305).
> Fix? yes
> 
> 
> /dev/kolbe34_backup/ext3crash: ***** FILE SYSTEM WAS MODIFIED *****
> /dev/kolbe34_backup/ext3crash: 15/7864320 files (6.7% non-contiguous), 497909/15728640 blocks

Just to confirm: these are errors I got.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
