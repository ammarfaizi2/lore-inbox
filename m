Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbVKAIUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVKAIUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVKAIUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:20:10 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:23775 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965080AbVKAIQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:58 -0500
Message-ID: <43672459.7050402@m1k.net>
Date: Tue, 01 Nov 2005 03:16:25 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 34/37] dvb: fix bug in demux that caused lost mpeg sections
Content-Type: multipart/mixed;
 boundary="------------010801020609000504080100"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010801020609000504080100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------010801020609000504080100
Content-Type: text/x-patch;
 name="2411.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2411.patch"

From: Mark Adams <mark147m@gmail.com>

Fix a bug in the software demux which causes large MPEG sections to be lost
when they follow very small sections.

The problem happens when two sections begin in the same transport
packet.  The dvb_demux code resets its buffer only before the first of
these sections.  This means that when the second (or subsequent)
section begins, there is up to 182 bytes of buffer space already used.
If the following section is close to the maximum size, it currently
won't fit in the (4096-byte) buffer and is thrown away.

The fix is simply to enlarge the buffer by the size of one transport
packet and correct one usage of the SECFEED_SIZE definition where what
is really meant is the maximum size of a section.

Signed-off-by: Mark Adams <mark147m@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/dvb-core/demux.h     |    5 ++++-
 drivers/media/dvb/dvb-core/dvb_demux.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-core/demux.h
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-core/demux.h
@@ -48,8 +48,11 @@
  * DMX_MAX_SECFEED_SIZE: Maximum length (in bytes) of a private section feed filter.
  */
 
+#ifndef DMX_MAX_SECTION_SIZE
+#define DMX_MAX_SECTION_SIZE 4096
+#endif
 #ifndef DMX_MAX_SECFEED_SIZE
-#define DMX_MAX_SECFEED_SIZE 4096
+#define DMX_MAX_SECFEED_SIZE (DMX_MAX_SECTION_SIZE + 188)
 #endif
 
 
--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-core/dvb_demux.c
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-core/dvb_demux.c
@@ -246,7 +246,7 @@
 
 	for (n = 0; sec->secbufp + 2 < limit; n++) {
 		seclen = section_length(sec->secbuf);
-		if (seclen <= 0 || seclen > DMX_MAX_SECFEED_SIZE
+		if (seclen <= 0 || seclen > DMX_MAX_SECTION_SIZE
 		    || seclen + sec->secbufp > limit)
 			return 0;
 		sec->seclen = seclen;


--------------010801020609000504080100--
