Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUENV2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUENV2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUENV2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:28:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:62861 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262897AbUENV2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:28:04 -0400
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/video/riva/fbdev.c broken on x86_64
References: <40A514BD.1050308@clanhk.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: TAILFINS!!  ...click...
Date: Fri, 14 May 2004 23:28:02 +0200
In-Reply-To: <40A514BD.1050308@clanhk.org> (J. Ryan Earl's message of "Fri,
 14 May 2004 13:49:33 -0500")
Message-ID: <je4qqi1yxp.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J. Ryan Earl" <heretic@clanhk.org> writes:

> static void rivafb_load_cursor_image(struct riva_par *par, u8 *data,
>                                      u8 *mask, u16 bg, u16 fg, u32 w, u32 h)
> {
>         int i, j, k = 0;
>         u32 b, m, tmp;
>
>         for (i = 0; i < h; i++) {
> ->             b = *((u32 *)data);
>                 b = (u32)((u32 *)b + 1);
> ->              m = *((u32 *)mask);
>                 m = (u32)((u32 *)m + 1);

It appears that someone tried to fix the use of cast as lvalue and failed
miserably.  Untested patch ahead.

--- linux-2.6.5/drivers/video/riva/fbdev.c.~1~	2004-04-04 05:37:37.000000000 +0200
+++ linux-2.6.5/drivers/video/riva/fbdev.c	2004-05-14 23:23:38.092744302 +0200
@@ -500,9 +500,9 @@ static void rivafb_load_cursor_image(str
 
 	for (i = 0; i < h; i++) {
 		b = *((u32 *)data);
-		b = (u32)((u32 *)b + 1);
+		data = (u8 *)((u32 *)data + 1);
 		m = *((u32 *)mask);
-		m = (u32)((u32 *)m + 1);
+		mask = (u8 *)((u32 *)mask + 1);
 		reverse_order(&b);
 		
 		for (j = 0; j < w/2; j++) {

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
