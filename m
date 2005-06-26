Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFZOA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFZOA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 10:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFZOA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 10:00:59 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:14823 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261213AbVFZOAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 10:00:21 -0400
Date: Sun, 26 Jun 2005 10:18:51 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor@mail.ru>,
       '@mail.kroptech.com
Subject: Re: 2.6.12-mm2
Message-ID: <20050626101851.A18283@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to lobby for the merging into mainline of this patch from
git-input. It fixes a real bug, seen by real users, and has been
languishing in the input tree since March. It may also be a candidate
for the stable tree given it's one-linedness.

--

Fix extraction of HID items >= 32 bits

HID items of width 32 (bits) or greater are incorrectly extracted due to
a masking bug in hid-core.c:extract(). This patch fixes it up by forcing
the mask to be 64 bits wide.


Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>


--- linux-2.6.11/drivers/usb/input/hid-core.c	Thu Mar  3 20:40:49 2005
+++ linux-2.6.11.adk/drivers/usb/input/hid-core.c	Sun Mar 13 14:00:47 2005
@@ -757,7 +757,7 @@
 static __inline__ __u32 extract(__u8 *report, unsigned offset, unsigned n)
 {
 	report += (offset >> 5) << 2; offset &= 31;
-	return (le64_to_cpu(get_unaligned((__le64*)report)) >> offset) & ((1 << n) - 1);
+	return (le64_to_cpu(get_unaligned((__le64*)report)) >> offset) & ((1ULL << n) - 1);
 }
 
 static __inline__ void implement(__u8 *report, unsigned offset, unsigned n, __u32 value)
