Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWGZBA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWGZBA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 21:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWGZBA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 21:00:27 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:21466 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030302AbWGZBA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 21:00:26 -0400
Date: Tue, 25 Jul 2006 18:00:25 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell3.speakeasy.net
To: Edgar Toernig <froese@gmx.de>
cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>, akpm@osdl.org,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@osdl.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH 00/23] V4L/DVB fixes
In-Reply-To: <20060726004127.6eab5a9f.froese@gmx.de>
Message-ID: <Pine.LNX.4.58.0607251741350.8253@shell3.speakeasy.net>
References: <20060725180311.PS54604900000@infradead.org>
 <20060726004127.6eab5a9f.froese@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Edgar Toernig wrote:
> I'm still missing the VBI_OFFSET fix.  See:
>
>   http://marc.theaimsgroup.com/?m=114710558215044
>
> Could you consider that patch for the next update and
> IMHO also for 2.6.16.x and 2.6.17.x?

I've put a patch that fixes this in my tree.  Mauro, please pull from
http://linuxtv.org/hg/~tap/v4l-dvb for:

02/02: bttv: Revert VBI_OFFSET to previous value, it works better
http://www.linuxtv.org/hg/~tap/v4l-dvb?cmd=changeset;node=88eaa291cc50;style=gitweb

FYI, contents of patch:
diff -r aaf8b9916bbb -r 88eaa291cc50 linux/drivers/media/video/bt8xx/bttv-vbi.c
--- a/linux/drivers/media/video/bt8xx/bttv-vbi.c        Tue Jul 25 16:37:03 2006
-0700
+++ b/linux/drivers/media/video/bt8xx/bttv-vbi.c        Tue Jul 25 17:51:36 2006
-0700
@@ -31,11 +31,16 @@
 #include <asm/io.h>
 #include "bttvp.h"

-/* Offset from line sync pulse leading edge (0H) in 1 / sampling_rate:
-   bt8x8 /HRESET pulse starts at 0H and has length 64 / fCLKx1 (E|O_VTC
-   HSFMT = 0). VBI_HDELAY (always 0) is an offset from the trailing edge
-   of /HRESET in 1 / fCLKx1, and the sampling_rate tvnorm->Fsc is fCLKx2. */
-#define VBI_OFFSET ((64 + 0) * 2)
+/* Offset from line sync pulse leading edge (0H) to start of VBI capture,
+   in fCLKx2 pixels.  According to the datasheet, VBI capture starts
+   VBI_HDELAY fCLKx1 pixels from the tailing edgeof /HRESET, and /HRESET
+   is 64 fCLKx1 pixels wide.  VBI_HDELAY is set to 0, so this should be
+   (64 + 0) * 2 = 128 fCLKx2 pixels.  But it's not!  The datasheet is
+   Just Plain Wrong.  The real value appears to be different for
+   different revisions of the bt8x8 chips, and to be affected by the
+   horizontal scaling factor.  Experimentally, the value is measured
+   to be about 244.  */
+#define VBI_OFFSET 244

 #define VBI_DEFLINES 16
 #define VBI_MAXLINES 32

