Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbULIM7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbULIM7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 07:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbULIM7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 07:59:30 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:15543 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261516AbULIM7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 07:59:25 -0500
Date: Thu, 9 Dec 2004 13:59:18 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: kruty@fi.muni.cz
Subject: XFS: inode with st_mode == 0
Message-ID: <20041209125918.GO9994@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I have seen the strange problem on our NFS server: yesterday I have
found an empty file owned by UID 0/GID 0 and st_mode == 0 in my home
directory (ls -l said "?--------- 1 root root 0 <date> <filename>").
The <filename> was correct name of a temporary file used by one of my
cron jobs (and the cron job was failing because it could not rewrite the file).
It was not possible to write to this file, so I have renamed it
as "badfile" for further investigation (using mv(1) on the NFS server itself).

Today I did "ls -l badfile", and the file had correct owner/group
and st_mode as expected from file created by my cron job: 

# stat badfile
  File: `badfile'
  Size: 0               Blocks: 0          IO Block: 4096   Regular File
Device: fd00h/64768d    Inode: 356913      Links: 1
Access: (0644/-rw-r--r--)  Uid: (xxxx/     kas)   Gid: (yyyy/ student)
Access: 2004-12-07 21:17:01.000000000 +0100
Modify: 2004-12-07 21:17:01.000000000 +0100

We have seen empty files with uid==gid==0 and st_mode==0 few times
before, at places where newly-created regular files were expected,
but we have simply deleted them. This time I have renamed the file
and looked at it after a day or so.

These files were created over NFS (our home directories are served by
NFS server) from various NFS clients (this one was Solaris 8, at least
one of the previous instances was created by an IRIX NFS client). The
filesystem itself is XFS on a LVM2 volume. The server is HP DL-585 quad
opteron, running RHEL3 plus our 2.6.10-rc2 kernel.

Maybe some data is flushed in an incorrect order?

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
