Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSFYBEC>; Mon, 24 Jun 2002 21:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSFYBEB>; Mon, 24 Jun 2002 21:04:01 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:15093 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315437AbSFYBEA>; Mon, 24 Jun 2002 21:04:00 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15639.49536.119104.292179@wombat.chubb.wattle.id.au>
Date: Tue, 25 Jun 2002 11:04:00 +1000
To: linux-kernel@vger.kernel.org
Subject: [PATCH] new large-block-device patch available
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,
   there's a new version of the large block device patch at
http://www.gelato.unsw.edu.au/patches/2.5.24-lbd-patch

Barring errors, this patch allows use of arbitrarily sized devices on
64 bit platforms, and, with a configuration option, allows up to 16Tb
devices on 32bit platforms.  

The bulk of the patch is fixing the various SCSI driver's magic to
convert a size to a CHS.  

The important bits are:
    -- disc sizes kept as sector_t not int
    -- struct request takes a sector_t not a long as the block number
       to transfer
    -- sector_t is defined as unsigned long for most platforms; as u64
       iff CONFIG_LBD is defined
    -- the BLKGETSIZE iotcl returns EFBIG if the size cannot be
       represented in a long (maybe that should be EOVERFLOW same as
       lseek?)
    -- loop device transfer functions now in terms of sector_t
    -- loop device refuses to attach to a file or device that is too
       large (instead of silently failing)
    -- casts to unsigned long long and appropriate printf formats
       where sector offsets are given to printk()
    -- New macro sector_div (based on div64()) to do (possibly 64-bit)
       division and remainder where it's necessary (only for printing
       the size of a partition converted to MB)
    --  Modifications to the scsi disc handler to use 16-byte commands
       iff the blocknumber is out-of-range for a 10-byte command.

Courtesy of OSDL, I'm currently testing this patch on ia64 and ia32.
If other people with enormous discs could test it too, and tell me
what they find, that'd be extremely helpful.


You may need fixed versions of the various filesystem tools, too.
JFSutils 1.0.20 has been fixed, I believe; if you need instead  a
patched 1.0.19 you can fetch it from http://gelato.unsw.edu.au/debian

Likewise, there is a patched e2fsprogs and reiserfsprogs there.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
