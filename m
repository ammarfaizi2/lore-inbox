Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVAUQha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVAUQha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVAUQha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:37:30 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:29066 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262419AbVAUQhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:37:00 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: Radeon framebuffer weirdness in -mm2
Date: Sat, 22 Jan 2005 00:36:38 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       benh@kernel.crashing.org
References: <20050120232122.GF3867@waste.org> <20050120160123.14f13ca6.akpm@osdl.org> <20050121035758.GH12076@waste.org>
In-Reply-To: <20050121035758.GH12076@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501220036.41359.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 11:57, Matt Mackall wrote:
> On Thu, Jan 20, 2005 at 04:01:23PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:

> If I do a reboot(8) from inside X, I get switched to vt 0, but the
> shutdown messages come out on vt 7, where X was running. As I'm
> sitting on vt 0 during shutdown, I see character cells changed to
> something like "_" (last two scanlines filled) slowly marching down
> the screen corresponding to the shutdown messages.

Confirmed that this also occurs with vesafb.

This corruption (underscores) is due to the cursor of a not visibile console
being drawn on the foreground display. The console layer should decide when
and where to draw the console but, for now, a simple workaround is to
disallow drawing of the fbcon cursor if the console is not visible.

Signed-off-by: Antonino  Daplas <adaplas@pol.net>
---

 fbcon.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-01-21 20:15:20 +08:00
+++ b/drivers/video/console/fbcon.c	2005-01-22 00:31:30 +08:00
@@ -1087,7 +1087,7 @@
 	int y = real_y(p, vc->vc_y);
  	int c = scr_readw((u16 *) vc->vc_pos);
 
-	if (fbcon_is_inactive(vc, info))
+	if (fbcon_is_inactive(vc, info) || !CON_IS_VISIBLE(vc))
 		return;
 
 	ops->cursor_flash = 1;


