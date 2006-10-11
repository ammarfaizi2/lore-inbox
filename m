Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161403AbWJKVFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161403AbWJKVFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWJKVFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:16798 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161389AbWJKVEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:44 -0400
Date: Wed, 11 Oct 2006 14:04:04 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mike Isely <isely@pobox.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/67] Video: pvrusb2: Suppress compiler warning
Message-ID: <20061011210404.GJ16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="video-pvrusb2-suppress-compiler-warning.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Mike Isely <isely@pobox.com>

The pvrusb2 driver needs to call video_devdata() in order to correctly
transform a file pointer into a video_device pointer.  Unfortunately
the prototype for this function has been marked V4L1-only and there's
no official substitute that I can find for V4L2.  Adding to the
mystery is that the implementation for this function exists whether or
not V4L1 compatibility has been selected.  The upshot of all this is
that we get a compilation warning here about a missing prototype but
the code links OK.  This fix solves the warning by copying the
prototype into the source file that is using it.  Yes this is a hack,
but it's a safe one for 2.6.18 (any alternative would be much more
intrusive).  A better solution should be forthcoming for the next
kernel.

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.18.orig/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ linux-2.6.18/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
@@ -32,6 +32,12 @@
 #include <linux/videodev2.h>
 #include <media/v4l2-common.h>
 
+/* Mike Isely <isely@pobox.com> 23-Sep-2006 - This function is prototyped
+ * only for V4L1 but is implemented regardless of the V4L1 compatibility
+ * option state.  V4L2 has no replacement for this and we need it.  For now
+ * copy the prototype here so we can avoid the compiler warning. */
+extern struct video_device* video_devdata(struct file*);
+
 struct pvr2_v4l2_dev;
 struct pvr2_v4l2_fh;
 struct pvr2_v4l2;

--
