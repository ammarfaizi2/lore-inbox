Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUENXg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUENXg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUENXfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:35:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:2246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264625AbUENXdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:33:51 -0400
Date: Fri, 14 May 2004 16:36:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Schwab <schwab@suse.de>
Cc: heretic@clanhk.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/video/riva/fbdev.c broken on x86_64
Message-Id: <20040514163620.13b9172b.akpm@osdl.org>
In-Reply-To: <je4qqi1yxp.fsf@sykes.suse.de>
References: <40A514BD.1050308@clanhk.org>
	<je4qqi1yxp.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> wrote:
>
>          for (i = 0; i < h; i++) {
> > ->             b = *((u32 *)data);
> >                 b = (u32)((u32 *)b + 1);
> > ->              m = *((u32 *)mask);
> >                 m = (u32)((u32 *)m + 1);
> 
> It appears that someone tried to fix the use of cast as lvalue and failed
> miserably.

That would be me.

How about we simplify things a bit?




---

 25-akpm/drivers/video/riva/fbdev.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/video/riva/fbdev.c~fbdev-lval-fix drivers/video/riva/fbdev.c
--- 25/drivers/video/riva/fbdev.c~fbdev-lval-fix	Fri May 14 16:34:10 2004
+++ 25-akpm/drivers/video/riva/fbdev.c	Fri May 14 16:35:32 2004
@@ -492,17 +492,17 @@ static inline void reverse_order(u32 *l)
  * CALLED FROM:
  * rivafb_cursor()
  */
-static void rivafb_load_cursor_image(struct riva_par *par, u8 *data, 
-				     u8 *mask, u16 bg, u16 fg, u32 w, u32 h)
+static void rivafb_load_cursor_image(struct riva_par *par, u8 *data8,
+				     u8 *mask8, u16 bg, u16 fg, u32 w, u32 h)
 {
 	int i, j, k = 0;
 	u32 b, m, tmp;
+	u32 *data = (u32 *)data8;
+	u32 *mask = (u32 *)mask8;
 
 	for (i = 0; i < h; i++) {
-		b = *((u32 *)data);
-		b = (u32)((u32 *)b + 1);
-		m = *((u32 *)mask);
-		m = (u32)((u32 *)m + 1);
+		b = *data++;
+		m = *mask++;
 		reverse_order(&b);
 		
 		for (j = 0; j < w/2; j++) {

_

