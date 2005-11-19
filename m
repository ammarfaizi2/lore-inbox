Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbVKSCD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbVKSCD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbVKSCD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:03:57 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:47271 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161152AbVKSCD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:03:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=PW2IliwG+DdU+Y7AYFC1Y+FeJhqLO4UQ4uwiO5zrKopo7qsc0oHQF1Ua/V0nNNndTn84te/XNg93pTxAkKzSolWdkw71j6YkwZRemP8MfR+szIWTtwi1l+dgAy/XXL/FvVRRM7qXJ/IZKGMDjF+piKc7GsakFwfq4lDskPEzHe8=
Message-ID: <437E850A.2080903@gmail.com>
Date: Sat, 19 Nov 2005 09:51:06 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] vgacon: Fix usage of stale height value on vc initialization
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by: Wayne E. Harlan

"[1.] One line summary of the problem:
When the kernel option "vga=1" is used, additional tty's (alt+control+Fx
with x=2,3,4,5, etc) do not provide the full 50 lines of output.  The first
one does have 50 lines, however.

[2.] Full description of the problem/report:
These addtitional tty's show only 39 lines plus the top pixel of the 40-th
line.  The remaining lines are black and not shown.  Kernel version
2.6.13.4 does not show this problem."

This bug is caused by using a stale font height value on vgacon_init.

Booting with vga=1 gives an 80x50 screen with an 8x8 font.  Somewhere
during the initialization, the font was changed to 8x9 and the first
vc was correctly resized to 80x44.  However, the rest of the vc's were
not allocated yet, and when they were subsequently initialized, they
still used a font height of 8 (instead of 9) causing the mentioned bug.

Fix by saving the new font height to vga_video_font_height.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/vgacon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 5ce8348..b49f645 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -979,7 +979,8 @@ static int vgacon_adjust_height(struct v
 	outb_p(0x12, vga_video_port_reg);	/* Vertical display limit */
 	outb_p(vde, vga_video_port_val);
 	spin_unlock_irq(&vga_lock);
-
+	vga_video_font_height = fontheight;
+	
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		struct vc_data *c = vc_cons[i].d;
 

