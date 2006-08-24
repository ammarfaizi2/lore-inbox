Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWHXGlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWHXGlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWHXGlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:41:04 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:15310 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030352AbWHXGlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:41:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JfScoQ48hJl2psyVByr8xyL7gN8U7oCGBK/7/YySeUMPKe49/Dv5Yu/g9kkrCsGY8mZ+nL4RiM9zMGs9m1NbLpNI+tde60mBC7Zgx8vxLObE0AnmtOaTTL0bIlsSrRGecxyN7VNyk8JN0YVUnJGN8zKaN7k90TI3srcGyY1le2U=
Message-ID: <18d709710608232341x491b4bf6g87f74ef830a203@mail.gmail.com>
Date: Thu, 24 Aug 2006 03:41:00 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "Solar Designer" <solar@openwall.com>
Subject: [PATCH] loop.c: kernel_thread() retval check - 2.6.17.9
Cc: "Willy Tarreau" <w@1wt.eu>, linux-kernel@vger.kernel.org, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is my porting (to 2.6.x) of the loop.c issue reported and patched
by Solar Designer, to whom all credits of the original idea to the
patch go (more info in the original "[PATCH] loop.c: kernel_thread()
retval check" e-mail thread).

Honestly, I couldn't test it on other computers, but mine. But the
tests were made against a stock (unmodified) 2.6.17.9 kernel and the
patch works like it should. Nevertheless, a second thought/review is
always appreciated.

Cheers,

    Julio Auto

Signed-off-by: Julio Auto <mindvortex@gmail.com>

--- drivers/block/loop.c.orig	2006-08-23 11:44:51.000000000 -0700
+++ drivers/block/loop.c	2006-08-24 00:33:54.000000000 -0700
@@ -841,10 +841,20 @@ static int loop_set_fd(struct loop_devic

 	error = kernel_thread(loop_thread, lo, CLONE_KERNEL);
 	if (error < 0)
-		goto out_putf;
+		goto out_clr;
 	wait_for_completion(&lo->lo_done);
 	return 0;

+ out_clr:
+	lo->lo_device = NULL;
+	lo->lo_flags = 0;
+	lo->lo_backing_file = NULL;
+	set_capacity(disks[lo->lo_number], 0);
+	invalidate_bdev(bdev, 0);
+	bd_set_size(bdev, 0);
+	mapping_set_gfp_mask(mapping, lo->old_gfp_mask);
+	lo->lo_state = Lo_unbound;
+
  out_putf:
 	fput(file);
  out:
