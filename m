Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVKWXue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVKWXue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKWXre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:40130 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751339AbVKWXqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:39 -0500
Date: Wed, 23 Nov 2005 15:45:17 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dwrobel@ertel.com.pl
Subject: [patch 14/22] USB: SN9C10x driver - bad page state fix
Message-ID: <20051123234517.GO527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-sn9c10x-driver-bad-page-state-fix.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damian Wrobel <dwrobel@ertel.com.pl>


This patch solves the following problem I've already discovered on the
latest 2.6.15-rc1-git1 kernel:

Nov 13 07:37:28 wrobel kernel: Bad page state at free_hot_cold_page (in process 'motion', page c164e020)
Nov 13 07:37:28 wrobel kernel: flags:0x40000400 mapping:00000000 mapcount:0 count:0
Nov 13 07:37:28 wrobel kernel: Backtrace:
Nov 13 07:37:28 wrobel kernel:  [<c0146d86>] bad_page+0x85/0xbe
Nov 13 07:37:28 wrobel kernel:  [<c0147629>] free_hot_cold_page+0x54/0x129
Nov 13 07:37:28 wrobel kernel:  [<c01598c6>] __vunmap+0xa9/0xfe
Nov 13 07:37:28 wrobel kernel:  [<c0154114>] vmalloc_to_page+0x34/0x55
Nov 13 07:37:28 wrobel kernel:  [<c0159942>] vfree+0x27/0x35
Nov 13 07:37:28 wrobel kernel:  [<f8a20292>]  sn9c102_release_buffers+0x30/0x3f [sn9c102]
Nov 13 07:37:28 wrobel kernel:  [<f8a231c2>] sn9c102_release+0x37/0xeb [sn9c102]
Nov 13 07:37:28 wrobel kernel:  [<c0163e74>] __fput+0xa9/0x1aa
Nov 13 07:37:28 wrobel kernel:  [<c01624f7>] filp_close+0x49/0x6d
Nov 13 07:37:30 wrobel kernel:  [<c016258f>] sys_close+0x74/0x95
Nov 13 07:37:30 wrobel kernel:  [<c0102ef9>] syscall_call+0x7/0xb
Nov 13 07:37:31 wrobel kernel: Trying to fix it up, but a reboot is needed

Signed-off-by: Damian Wrobel <dwrobel@ertel.com.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/media/sn9c102_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/drivers/usb/media/sn9c102_core.c
+++ usb-2.6/drivers/usb/media/sn9c102_core.c
@@ -199,7 +199,7 @@ static void sn9c102_release_buffers(stru
 {
 	if (cam->nbuffers) {
 		rvfree(cam->frame[0].bufmem,
-		       cam->nbuffers * cam->frame[0].buf.length);
+		       cam->nbuffers * PAGE_ALIGN(cam->frame[0].buf.length));
 		cam->nbuffers = 0;
 	}
 }

--
