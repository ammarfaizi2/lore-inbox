Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSFYG7v>; Tue, 25 Jun 2002 02:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSFYG7u>; Tue, 25 Jun 2002 02:59:50 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:56053 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315455AbSFYG7s>; Tue, 25 Jun 2002 02:59:48 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15640.5302.257228.579646@wombat.chubb.wattle.id.au>
Date: Tue, 25 Jun 2002 16:59:02 +1000
To: "Amit  Agrawal, Noida" <amitag@noida.hcltech.com>
Subject: RE: Bogus LBD patch
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB21210331C254@exch-01.noida.hcltech.com>
References: <E04CF3F88ACBD5119EFE00508BBB21210331C254@exch-01.noida.hcltech.com>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
CC: linux-kernel@vger.kernel.org
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AmitR" == Amit Agrawal <Amit> writes:

AmitR> Hi Peter I've been found in your todo list ,in url u have
AmitR> given, that "large disc simulator" is planned, there is one
AmitR> solution developed by me regarding this,which ignores filedata
AmitR> and writes only metadata on the actual device so a large disc
AmitR> space is seen especially for big files. This produces a real

That sounds like a good idea.

AmitR> "large disc simulator" in you todo list.Please tell me your
AmitR> strategy for "large disc simulator" , if you have planned it

What I did was create a fake scsi device based on the HP simulator for
IA64, backed by a sparse file.  So it's really a loop device that
obeys SCSI commands.  It worked back on 2.5.9, but the changes since
then mean it deadlocks immediately now --- I intend to fix it, and
release it as soon as I can make some time.

The purpose was to test the SCSI layer's response to large discs.

What I'm trying to test now is what happens with real discs. 
I found that ext2 has too much metadata for the amount of disc space I
have for the sparse file approach to work.  JFS worked very well.
Reiserfs doesn't work at present, but I sent the bug report to them,
and they're working on the problems.

The testing I'm doing is:
    1.  Is the size of the drive reported correctly by the kernel?
	-- at bootup
	-- via ioctl(GETBLKSIZE)
	-- via ioctl(GETBLKSIZE64)
	-- via lseek(,0, SEEK_END)
    2.  Can the drive be partitioned?
        I expect Gnu parted with GDT to work properly; I expect the
	others to fail gracefully
    3.  Can a file system be written to the drive?
        I've been testing ext2, jfs and reiserfs;
	I tested XFS on an earlier patch, but at present it's too much
	of a pain to integrate.
    4.  If a filesystem is created, does fsck work?
    5.  Can the filesystem be mounted?
    6.  Then test how large a file I can create on the filesystem,
        both sparse and full.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
