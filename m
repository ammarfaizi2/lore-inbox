Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269518AbUJFWcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269518AbUJFWcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJFW25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:28:57 -0400
Received: from peabody.ximian.com ([130.57.169.10]:34281 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269518AbUJFW0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:26:09 -0400
Subject: Re: [RFC][PATCH] inotify 0.13
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1097095286.9199.2.camel@vertex>
References: <1097095286.9199.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-l0SGu1/aWahwzg3LmdIa"
Date: Wed, 06 Oct 2004 18:24:38 -0400
Message-Id: <1097101478.3960.11.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l0SGu1/aWahwzg3LmdIa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Everything sent to user-space needs to be zeroed out first, to prevent
leaking random kernel memory.  So, we need to zero out the
inotify_kernel_event structure after allocating it.

We need to do this even though we initialize the fields in case of
structure padding.  Also, the filename field.

Patch is attached, on top of 0.13.1.

	Robert Love


--=-l0SGu1/aWahwzg3LmdIa
Content-Disposition: attachment; filename=inotify-0.13-rml-zero-struct-1.patch
Content-Type: text/x-patch; name=inotify-0.13-rml-zero-struct-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    3 +++
 1 files changed, 3 insertions(+)

diff -urN linux-inotify-0.13/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify-0.13/drivers/char/inotify.c	2004-10-06 16:47:54.000000000 -0400
+++ linux/drivers/char/inotify.c	2004-10-06 18:20:55.604363400 -0400
@@ -140,6 +140,9 @@
 		goto out;
 	}
 
+	/* we hand this out to user-space, so zero it out just in case */
+	memset(kevent, 0, sizeof(struct inotify_kernel_event));
+
 	iprintk(INOTIFY_DEBUG_ALLOC, "alloced kevent %p (%d,%d)\n",
 		kevent, wd, mask);
 

--=-l0SGu1/aWahwzg3LmdIa--

