Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278662AbRKNXdL>; Wed, 14 Nov 2001 18:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278653AbRKNXdC>; Wed, 14 Nov 2001 18:33:02 -0500
Received: from mail309.mail.bellsouth.net ([205.152.58.169]:20134 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278633AbRKNXcy>; Wed, 14 Nov 2001 18:32:54 -0500
Message-ID: <3BF2FF0E.ABD507CF@mandrakesoft.com>
Date: Wed, 14 Nov 2001 18:32:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Mundt <pmundt@mvista.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fbdev-devel@lists.sourceforge.net,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] fb_mmap() holding BKL
In-Reply-To: <20011114152656.A31149@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------71F0C094ED73F87E171511F7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------71F0C094ED73F87E171511F7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul Mundt wrote:
> Just a minor cleanup.. in the event of some sanity checking in fb_mmap(), the
> BKL is accidentally held on a return.. this trivial patch fixes this issue.

No idea why your patch didn't apply here, but it didn't.

Attached is the same fix patch, rediff'd against 2.4.15-pre4.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------71F0C094ED73F87E171511F7
Content-Type: text/plain; charset=us-ascii;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Index: drivers/video/fbmem.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/video/fbmem.c,v
retrieving revision 1.4
diff -u -r1.4 fbmem.c
--- drivers/video/fbmem.c	2001/10/11 09:39:14	1.4
+++ drivers/video/fbmem.c	2001/11/14 23:31:44
@@ -563,8 +563,10 @@
 		/* memory mapped io */
 		off -= len;
 		fb->fb_get_var(&var, PROC_CONSOLE(info), info);
-		if (var.accel_flags)
+		if (var.accel_flags) {
+			unlock_kernel();
 			return -EINVAL;
+		}
 		start = fix.mmio_start;
 		len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.mmio_len);
 	}

--------------71F0C094ED73F87E171511F7--


