Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVDIOVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVDIOVT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVDIOVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 10:21:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22409 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261345AbVDIOVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 10:21:12 -0400
Date: Sat, 9 Apr 2005 07:19:13 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Message-Id: <20050409071913.7f2aab65.pj@engr.sgi.com>
In-Reply-To: <42567B3E.8010403@grupopie.com>
References: <4252BC37.8030306@grupopie.com>
	<20050407214747.GD4325@stusta.de>
	<42567B3E.8010403@grupopie.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo wrote:
> In the first case you have to read carefully to make sure that the size 
> argument in both the kmalloc and the memset are the same.

If that were the only concern (which it isn't, and I don't pretend to be
addressing the other concerns on this thread) then pulling out the
common sub-expression would help readability, and reduce the chance of a
coding bug should the size change in the future.

Anytime you find yourself coding the same complex expression twice, an
alarm should go off in your mind, and you should ask yourself if there
is a reasonable way to get by with only one instance of the coding in
the source.

The following patch shows what I mean here.

It also replaces the less conventional form:

	if (!(ptr = some_function(args)) do-something;

with the more conventional form:

	if ((ptr = some_function(args)) == NULL)
		do-something;


diff -Naurp 2.6.12-rc2.orig/drivers/usb/input/hid-core.c 2.6.12-rc2/drivers/usb/input/hid-core.c
--- 2.6.12-rc2.orig/drivers/usb/input/hid-core.c	2005-04-09 06:57:47.000000000 -0700
+++ 2.6.12-rc2/drivers/usb/input/hid-core.c	2005-04-09 07:05:14.000000000 -0700
@@ -90,17 +90,18 @@ static struct hid_report *hid_register_r
 static struct hid_field *hid_register_field(struct hid_report *report, unsigned usages, unsigned values)
 {
 	struct hid_field *field;
+	int sz;
 
 	if (report->maxfield == HID_MAX_FIELDS) {
 		dbg("too many fields in report");
 		return NULL;
 	}
 
-	if (!(field = kmalloc(sizeof(struct hid_field) + usages * sizeof(struct hid_usage)
-		+ values * sizeof(unsigned), GFP_KERNEL))) return NULL;
-
-	memset(field, 0, sizeof(struct hid_field) + usages * sizeof(struct hid_usage)
-		+ values * sizeof(unsigned));
+	sz = sizeof(struct hid_field) + usages * sizeof(struct hid_usage) +
+			values * sizeof(unsigned);
+	if ((field = kmalloc(sz, GFP_KERNEL)) == NULL)
+		return NULL;
+	memset(field, 0, sz);
 
 	field->index = report->maxfield++;
 	report->field[field->index] = field;


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
