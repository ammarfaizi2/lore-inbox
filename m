Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSGEFdN>; Fri, 5 Jul 2002 01:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSGEFdM>; Fri, 5 Jul 2002 01:33:12 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:38900 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315483AbSGEFdL>; Fri, 5 Jul 2002 01:33:11 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15653.12329.565726.228100@wombat.chubb.wattle.id.au>
Date: Fri, 5 Jul 2002 15:35:37 +1000
To: reiserfs-dev@namesys.com
Subject: Results of testing Reiserfs on large block devices.
CC: gelato@gelato.unsw.edu.au, linux-kernel@vger.kernel.org
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,
   I couldn't get Reiserfs to work on large devices.  I've tracked the
problem down.

  When Reiserfs is mounted, it tries to allocate a chunk of memory for
bitmaps using kmalloc.  The largest chunk allocatable by kmalloc is
128k.  This limits the size of a reiserfs to just under 2TB on a
64-bit platform (16384 bitmaps times 8bytes per pointer) or just under
4TB on a 32 bit platform (32768 bitmaps times 4bytes per pointer).

This reasoning assumes that the number of bitmaps is given by the
formula (number_of_blocks + (8 * blocksize - 1))/(8 * blocksize) where
blocksize is 4096 bytes.  Thus 
	  number_of_blocks = 8 * 4096 * (16384 - 1) - 1  [64 bit]
								
	  number_of_blocks = 8 * 4096 * (32768 - 1) - 1  [32 bit]

Hacking mm/slab.c to increase the memory limit allowed larger
filesystems to be mounted, but I haven't tested these thoroughly yet.
--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.

