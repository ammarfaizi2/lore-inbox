Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVCYWYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVCYWYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVCYWY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:24:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:1969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261855AbVCYWXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:23:31 -0500
Date: Fri, 25 Mar 2005 14:23:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: jason@stdbev.com, linux-kernel@vger.kernel.org, elenstev@mesatop.com
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
Message-Id: <20050325142336.12687e09.akpm@osdl.org>
In-Reply-To: <20050325140654.430714e2.akpm@osdl.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<42446B86.7080403@mesatop.com>
	<424471CB.3060006@mesatop.com>
	<20050325122433.12469909.akpm@osdl.org>
	<4244812C.3070402@mesatop.com>
	<761c884705af2ea412c083d849598ca7@stdbev.com>
	<20050325140654.430714e2.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> It's the new rock-ridge bounds checking.

Try this, please?

diff -puN fs/isofs/rock.c~rock-handle-directory-overflows-fix fs/isofs/rock.c
--- 25/fs/isofs/rock.c~rock-handle-directory-overflows-fix	Fri Mar 25 14:21:32 2005
+++ 25-akpm/fs/isofs/rock.c	Fri Mar 25 14:22:01 2005
@@ -218,12 +218,12 @@ repeat:
 		if (rr->len < 3)
 			goto out;	/* Something got screwed up here */
 		sig = isonum_721(rs.chr);
+		if (rock_check_overflow(&rs, sig))
+			goto eio;
 		rs.chr += rr->len;
 		rs.len -= rr->len;
 		if (rs.len < 0)
 			goto eio;	/* corrupted isofs */
-		if (rock_check_overflow(&rs, sig))
-			goto eio;
 
 		switch (sig) {
 		case SIG('R', 'R'):
@@ -316,12 +316,12 @@ repeat:
 		if (rr->len < 3)
 			goto out;	/* Something got screwed up here */
 		sig = isonum_721(rs.chr);
+		if (rock_check_overflow(&rs, sig))
+			goto eio;
 		rs.chr += rr->len;
 		rs.len -= rr->len;
 		if (rs.len < 0)
 			goto eio;	/* corrupted isofs */
-		if (rock_check_overflow(&rs, sig))
-			goto eio;
 
 		switch (sig) {
 #ifndef CONFIG_ZISOFS		/* No flag for SF or ZF */
@@ -694,12 +694,12 @@ repeat:
 		if (rr->len < 3)
 			goto out;	/* Something got screwed up here */
 		sig = isonum_721(rs.chr);
+		if (rock_check_overflow(&rs, sig))
+			goto out;
 		rs.chr += rr->len;
 		rs.len -= rr->len;
 		if (rs.len < 0)
 			goto out;	/* corrupted isofs */
-		if (rock_check_overflow(&rs, sig))
-			goto out;
 
 		switch (sig) {
 		case SIG('R', 'R'):
_

