Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269289AbUJTKaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbUJTKaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270027AbUJTK1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:27:14 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:54524 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270055AbUJTKYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:24:09 -0400
Date: Wed, 20 Oct 2004 03:23:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH (updated)] Avoid annoying build warning on 32-bit platforms
Message-ID: <20041020102343.GA6901@taniwha.stupidest.org>
References: <200410200956.i9K9ujOu026178@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410200956.i9K9ujOu026178@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:56:45AM +0200, Mikael Pettersson wrote:

> There's a coding idiom for doing this: just break up
> the ">> 32" in two steps, like: ((time >> 31) >> 1).

i assumed gcc would complain there too but it doesn't and it does
optimize this away (i checked)

> Definitely preferable over #ifdef:s.

indeed



Avoid annoying gcc warning on 32-bit platforms.

Signed-off-by: cw@f00f.org

===== drivers/char/random.c 1.57 vs edited =====
--- 1.57/drivers/char/random.c	2004-10-05 14:21:53 -07:00
+++ edited/drivers/char/random.c	2004-10-20 03:19:17 -07:00
@@ -818,12 +818,10 @@ static void add_timer_randomness(struct 
 	 * jiffies.
 	 */
 	time = get_cycles();
-	if (time != 0) {
-		if (sizeof(time) > 4)
-			num ^= (u32)(time >> 32);
-	} else {
+	if (time)
+		num ^= (u32)((time >> 32) >> 1);
+	else
 		time = jiffies;
-	}
 
 	/*
 	 * Calculate number of bits of randomness we probably added.
