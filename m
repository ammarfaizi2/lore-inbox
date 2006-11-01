Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946520AbWKAFky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946520AbWKAFky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946522AbWKAFkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:40:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:56465 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946520AbWKAFjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:39:44 -0500
Message-Id: <20061101053954.295627000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 27/61] ALSA: Fix re-use of va_list
Content-Disposition: inline; filename=alsa-fix-re-use-of-va_list.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix re-use of va_list

The va_list is designed to be used only once.  The current code
may pass va_list arguments multiple times and may cause Oops.
Copy/release the arguments temporarily to avoid this problem.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/core/info.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.18.1.orig/sound/core/info.c
+++ linux-2.6.18.1/sound/core/info.c
@@ -119,7 +119,10 @@ int snd_iprintf(struct snd_info_buffer *
 	len = buffer->len - buffer->size;
 	va_start(args, fmt);
 	for (;;) {
-		res = vsnprintf(buffer->buffer + buffer->curr, len, fmt, args);
+		va_list ap;
+		va_copy(ap, args);
+		res = vsnprintf(buffer->buffer + buffer->curr, len, fmt, ap);
+		va_end(ap);
 		if (res < len)
 			break;
 		err = resize_info_buffer(buffer, buffer->len + PAGE_SIZE);

--
