Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270744AbTG0LbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270746AbTG0LbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:31:23 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:29460
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S270744AbTG0LbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:31:18 -0400
Message-ID: <099001c35434$f9ac3130$7f0a0a0a@lappy7>
Reply-To: "Sean Estabrooks" <seanlkml@rogers.com>
From: "Sean Estabrooks" <seanlkml@rogers.com>
To: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Jens Axboe" <axboe@suse.de>
Subject: [PATCH]  Block layer bug handling partial bvec
Date: Sun, 27 Jul 2003 07:48:19 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_098D_01C35413.72606E60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.102.213.108] using ID <seanlkml@rogers.com> at Sun, 27 Jul 2003 07:46:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_098D_01C35413.72606E60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Previously I submitted a patch for "blk: request botched" on floppy
write.  While the patch did make the floppy work, Jens mentioned 
that an underlying error still existed.   This spurred me on to look a 
little deeper and finally i found the root cause.   

There is a bug in "ll_rw_blk.c" handling partial bvec submissions.
For whatever reason the floppy driver was triggering it more than
other users.  Note that with the attached patch, my previous 
floppy_ patch is no longer needed.

Cheers,
Sean

------=_NextPart_000_098D_01C35413.72606E60
Content-Type: application/octet-stream;
	name="blk_partial_bvec.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="blk_partial_bvec.patch"

--- 26test1bk/drivers/block/ll_rw_blk.c	Sun Jul 27 07:03:29 2003=0A=
+++ 26test1bk/drivers/block/ll_rw_blk.c	Sun Jul 27 07:03:59 2003=0A=
@@ -2307,8 +2307,8 @@=0A=
 			 * not a complete bvec done=0A=
 			 */=0A=
 			if (unlikely(nbytes > nr_bytes)) {=0A=
-				bio_iovec(bio)->bv_offset +=3D nr_bytes;=0A=
-				bio_iovec(bio)->bv_len -=3D nr_bytes;=0A=
+				bio_iovec_idx(bio, idx)->bv_offset +=3D nr_bytes;=0A=
+				bio_iovec_idx(bio, idx)->bv_len -=3D nr_bytes;=0A=
 				bio_nbytes +=3D nr_bytes;=0A=
 				total_bytes +=3D nr_bytes;=0A=
 				break;=0A=

------=_NextPart_000_098D_01C35413.72606E60--

