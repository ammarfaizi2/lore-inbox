Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbTH1Cwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 22:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTH1Cwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 22:52:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13301 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263708AbTH1Cwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 22:52:32 -0400
Date: Wed, 27 Aug 2003 21:52:25 -0500 (CDT)
From: olof@austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] [2.4] /proc/ioports overrun for long device names
Message-ID: <Pine.A41.4.44.0308272143170.53904-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen some memory corruption on systems where we have long device
names, since the last entry when you cat /proc/ioports might run over into
the next page. The check is only to make sure there's room for 80
characters, when there's more than that (i.e. 64-bit addresses + long
device names), there can be an overrun.

2.5 obviously doesn't have this because of seq_file.

Below patch will take the length of the name into consideration.


--- kernel/resource.c.orig	2003-07-16 10:25:40.000000000 -0500
+++ kernel/resource.c	2003-07-24 09:51:47.000000000 -0500
@@ -32,14 +32,21 @@ static char * do_resource_list(struct re
 		const char *name = entry->name;
 		unsigned long from, to;

-		if ((int) (end-buf) < 80)
-			return buf;
-
 		from = entry->start;
 		to = entry->end;
 		if (!name)
 			name = "<BAD>";

+		/* Make sure there's enough room for the format string
+		   plus hex representation of 'from' and 'to' (2
+		   characters per byte) as well as the name of the
+		   resource. Due to the format characters in 'fmt', the
+		   estimate will be a little high.
+		 */
+		if ((int) (end-buf) < (strlen(fmt) + strlen(name) +
+		                       sizeof(from)*2 + sizeof(to)*2 + 1))
+			return buf;
+
 		buf += sprintf(buf, fmt + offset, from, to, name);
 		if (entry->child)
 			buf = do_resource_list(entry->child, fmt, offset-2, buf, end);



Thanks,

Olof


Olof Johansson                                        Office: 4E002/905
pSeries Linux Development                             IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM

