Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968796AbWLGFNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968796AbWLGFNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968798AbWLGFNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:13:23 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:24134 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968796AbWLGFNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:13:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Fzij7eC4MWnoZCZZ23TjZzC8kAdmPc7eDjHUP0xGUCcIhNHJQ5hC3LsuT8C6m6KM7V5jnVh9IdRMN/ivxjDkYC+5c6zPGJbpFkEFUbqfAd29b8ZR1JW9uwykEGdplk+svZPt1KJ1U+1BkmYP/Ajt6Nx0E/QinKCYnAmq+dRPNOE=
Date: Wed, 6 Dec 2006 21:13:17 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19] drivers/media/video/cpia2/cpia2_usb.c: Free
 previously allocated memory (in array elements) if kmalloc() returns NULL.
Message-Id: <20061206211317.b996bc34.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Free previously allocated memory (in array elements) if kmalloc() returns NULL, in function submit_urbs(), in file drivers/media/video/cpia2/cpia2_usb.c. If the system is low on memory, then previously allocated memory in the same array should be freed up to help the system recover.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/cpia2/cpia2_usb.c b/drivers/media/video/cpia2/cpia2_usb.c
index 28dc6a1..c938638 100644
--- a/drivers/media/video/cpia2/cpia2_usb.c
+++ b/drivers/media/video/cpia2/cpia2_usb.c
@@ -640,6 +640,10 @@ static int submit_urbs(struct camera_dat
 		cam->sbuf[i].data =
 		    kmalloc(FRAMES_PER_DESC * FRAME_SIZE_PER_DESC, GFP_KERNEL);
 		if (!cam->sbuf[i].data) {
+			for (--i; i >= 0; i--) {
+				kfree(cam->sbuf[i].data);
+				cam->sbuf[i].data = NULL;
+			}
 			return -ENOMEM;
 		}
 	}
