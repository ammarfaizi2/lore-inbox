Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTDUPhq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbTDUPhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:37:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50694 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261405AbTDUPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:37:43 -0400
Date: Mon, 21 Apr 2003 16:49:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: trond.myklebust@fys.uio.no
Subject: 2.5.68: NFS hang on write/close
Message-ID: <20030421164944.A7100@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	trond.myklebust@fys.uio.no
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@assabet /root]$mount|grep flint
flint:/mnt/src on /mnt/src type nfs (rw,rsize=4096,nolock,addr=xxxxxxxxxxxx)
[root@assabet /root]$cp core /mnt/src/tests/
<hang>
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
cp            D C02371A0 19704060   136     91                     (NOTLB)
[<c0236f5c>] (schedule+0x0/0x45c) from [<c02bb87c>] (nfs_wait_on_request+0x160/0x188)
 r7 = C14D5ED0  r6 = 00000000  r5 = C145B5EC  r4 = C145B5D0
[<c02bb71c>] (nfs_wait_on_request+0x0/0x188) from [<c02bf0ec>] (nfs_wait_on_requests+0xc8/0x130)
[<c02bf024>] (nfs_wait_on_requests+0x0/0x130) from [<c02c06cc>] (nfs_sync_file+0xa4/0xac)
[<c02c0628>] (nfs_sync_file+0x0/0xac) from [<c02b6dc8>] (nfs_file_flush+0x4c/0x84)
[<c02b6d7c>] (nfs_file_flush+0x0/0x84) from [<c0274ad4>] (filp_close+0x74/0x114)
 r5 = C1FA4504  r4 = C14D4000 
[<c0274a60>] (filp_close+0x0/0x114) from [<c0222300>] (ret_fast_syscall+0x0/0x30)
 r7 = 00000006  r6 = 00000003  r5 = BEFFDC74  r4 = BEFFBC48
ofs: server flint not responding, still trying

I can assure you that flint is alive and well.

"core" is a 64K file, flint is running 2.4.19 with knfsd, assabet is
running 2.5.68.

Looking at the filesystem on flint, it's created a file called "core" of
zero bytes:

  File: "/mnt/src/tests/core"
  Size: 0          Blocks: 0         Regular File
Access: (0600/-rw-------)         Uid: (    0/    root)  Gid: (    0/    root)
Device: 907        Inode: 625311     Links: 1    
Access: Mon Apr 21 16:31:39 2003
Modify: Mon Apr 21 16:44:03 2003
Change: Mon Apr 21 16:44:03 2003

NFS traffic wise, I'm seeing:

16:43:52.101873 assabet.61450 > flint.nfs: 128 getattr fh 0,0/117442816 (DF)
16:43:52.102275 flint.nfs > assabet.61450: reply ok 96 (DF)
16:43:52.103546 assabet.61451 > flint.nfs: 128 getattr fh 148,125/117442816 (DF)
16:43:52.105570 flint.nfs > assabet.61451: reply ok 96 (DF)
16:44:00.446444 assabet.61452 > flint.nfs: 128 getattr fh 138,158/117442816 (DF)
16:44:00.446868 flint.nfs > assabet.61452: reply ok 96 (DF)
16:44:03.040634 assabet.61453 > flint.nfs: 128 getattr fh 138,159/117442816 (DF)
16:44:03.041039 flint.nfs > assabet.61453: reply ok 96 (DF)
16:44:03.042908 assabet.61454 > flint.nfs: 160 setattr fh 138,159/117442816 (DF)
16:44:03.044452 flint.nfs > assabet.61454: reply ok 96 (DF)
<silence>

There don't appear to be any further NFS requests from "assabet".


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

