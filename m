Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271732AbRHUQUb>; Tue, 21 Aug 2001 12:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271735AbRHUQUV>; Tue, 21 Aug 2001 12:20:21 -0400
Received: from ip144.gte21.rb1.bel.nwlink.com ([207.202.191.144]:28654 "EHLO
	mail.intra.calle.org") by vger.kernel.org with ESMTP
	id <S271732AbRHUQUI>; Tue, 21 Aug 2001 12:20:08 -0400
Date: Tue, 21 Aug 2001 09:20:17 -0700 (PDT)
From: Olivier Calle <olivier@calle.org>
To: Robert Baruch <autophile@starband.net>
cc: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] one-liner fix to sddr09.c for >= 64MB SmartMedia
Message-ID: <Pine.LNX.4.33.0108210909030.9955-100000@tesla.intra.calle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a problem with getting the LBA <-> PBA mapping from a 64MB
SmartMedia card in an SDDR09 card reader.  The mapping is read from the
card into 2 128k sg's.  The problem occurs when looking at the data in the
second sg.  The memory is accessed with an offset from the beginning of
all the data, regardless of which sg is being read from.  So, in the case
of the second sg, the data read is actually whatever memory is right after
the memory allocated to that sg.

Here is the one-liner fix.  It worked with my card and I believe this
should work for larger cards, althought I have none to test with.

--- sddr09.c.orig	Sat Apr 28 10:36:28 2001
+++ sddr09.c	Tue Aug 21 08:35:19 2001
@@ -693,7 +693,7 @@
 	// scatterlist block i*64/128k = i*(2^6)*(2^-17) = i*(2^-11)

 	for (i=0; i<numblocks; i++) {
-		ptr = sg[i>>11].address+(i<<6);
+		ptr = sg[i>>11].address+((i<<6)&0x1ffff);
 		if (ptr[0]!=0xFF || ptr[1]!=0xFF || ptr[2]!=0xFF ||
 		    ptr[3]!=0xFF || ptr[4]!=0xFF || ptr[5]!=0xFF) {
 			US_DEBUGP("PBA %04X has no logical mapping: reserved area = "

Hopefully this will make it into the kernel in the near future.

-- 
Olivier Calle

internet: <olivier@calle.org>
work tel: 425-446-5088    home tel: 360-658-2692     To err is human,
callsign: N7TAP, class: General                      to really foul up
job:      Fluke Networks, Sr. Software Engineer      requires the root
WWW Page URL: http://calle.org/olivier/              password...
Psalm 48:14                        SPU Electrical Engineering Graduate

