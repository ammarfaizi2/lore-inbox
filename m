Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSE2L6g>; Wed, 29 May 2002 07:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSE2L6f>; Wed, 29 May 2002 07:58:35 -0400
Received: from host213-121-106-55.in-addr.btopenworld.com ([213.121.106.55]:64428
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S314929AbSE2L6e>; Wed, 29 May 2002 07:58:34 -0400
Subject: [PATCH]: mmap packet socket information leak (trivial)
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 29 May 2002 12:58:55 +0100
Message-Id: <1022673535.31102.17.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a quick patch which blanks the mmap() packet socket buffer areas
before using them. Previously you would get uninitialised data inbetween
the data structures where they are TPACKET_ALIGNED().

The root user could potentially unwittingly save this data to a file and
distribute it not knowing his password was in it or whatever... Not very
likely but its worth fixing IMHO :)

Regards

diff -urN linux.orig/net/packet/af_packet.c linux/net/packet/af_packet.c
--- linux.orig/net/packet/af_packet.c	Wed May 29 12:30:10 2002
+++ linux/net/packet/af_packet.c	Wed May 29 12:29:10 2002
@@ -1679,6 +1679,7 @@
 			int k;
 
 			for (k=0; k<frames_per_block; k++, l++) {
+				memset((void *)ptr, 0, req->tp_frame_size);
 				io_vec[l] = (struct tpacket_hdr*)ptr;
 				io_vec[l]->tp_status = TP_STATUS_KERNEL;
 				ptr += req->tp_frame_size;

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
8646BE7D: 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

