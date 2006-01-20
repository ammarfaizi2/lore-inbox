Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWATXY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWATXY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWATXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:24:56 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:37184 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932138AbWATXYz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:24:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E6qNxRvxECEin4l7r091NbSpfSbC7aVljCBEpvqap4/8z/UlF8f9RoMIAa6LsqzA3M3oJFhr/s5JBC8EGAk1ut7RkRrb5o5KC2aWrG3C06cDA15k+8xOHtxLydHtbgiWlM6g2W53cIduaysbto74b3gAqIm5ij9qhDLAO1WbT6Q=
Message-ID: <5c49b0ed0601201524x26225a77k94a1eb95bc601883@mail.gmail.com>
Date: Fri, 20 Jan 2006 15:24:55 -0800
From: Nate Diller <nate.diller@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH 2/2][RESEND] Default iosched fixes (was: Fall back io scheduler for 2.6.15?)
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <5c49b0ed0601201517h3126ac8dp931bab93a85bf9c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com>
	 <20060120081145.GD4213@suse.de>
	 <5c49b0ed0601201517h3126ac8dp931bab93a85bf9c5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens has decided that allowing the default scheduler to be a module is
a bug, and should not be allowed under kconfig.  However, I find that
scenario useful for debugging, and wish for the kernel to be able to
handle this situation without OOPSing, if I enable such an option in
the .config directly.  This patch dynamically checks for the presence
of the compiled-in default, and falls back to no-op, emitting a
suitable error message, when the default is not available

Tested for a range of boot options on 2.6.16-rc1-mm2.

Signed-off-by: Nate Diller <nate.diller@gmail.com>

--- ./block/elevator.c	2006-01-20 14:52:53.000000000 -0800
+++ ./block/elevator.c	2006-01-20 15:00:16.000000000 -0800
@@ -169,10 +169,12 @@ int elevator_init(request_queue_t *q, ch
 	if (name && !(e = elevator_get(name)))
 		return -EINVAL;

-	if (!e && !(e = elevator_get(chosen_elevator))) {
-		e = elevator_get(CONFIG_DEFAULT_IOSCHED);
-		if (*chosen_elevator)
-			printk("I/O scheduler %s not found\n", chosen_elevator);
+	if (!e && *chosen_elevator && !(e = elevator_get(chosen_elevator)))
+		printk("I/O scheduler %s not found\n", chosen_elevator);
+
+	if (!e && !(e = elevator_get(CONFIG_DEFAULT_IOSCHED))) {
+		printk("Default I/O scheduler not found, using no-op\n");
+		e = elevator_get("noop");
 	}

 	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
