Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275393AbTHIUJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275394AbTHIUJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:09:48 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17609 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275393AbTHIUJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:09:44 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 9 Aug 2003 22:09:42 +0200 (MEST)
Message-Id: <UTC200308092009.h79K9gV24870.aeb@smtp.cwi.nl>
To: akpm@osdl.org
Subject: input layer
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something that you might want to try in -mm, but which
is not for Linus' tree is the below.

There are lots of places (not only the three below)
where we leave a pointer to a structure, but free
the structure itself. Bad habit.

Making the pointer NULL will turn random behaviour
into NULL deref when the pointer is ever touched.

This does not fix anything.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Jun 23 04:43:32 2003
+++ b/drivers/input/keyboard/atkbd.c	Sat Aug  9 22:59:21 2003
@@ -473,6 +473,7 @@
 	struct atkbd *atkbd = serio->private;
 	input_unregister_device(&atkbd->dev);
 	serio_close(serio);
+	serio->private = NULL;
 	kfree(atkbd);
 }
 
@@ -518,6 +519,7 @@
 	serio->private = atkbd;
 
 	if (serio_open(serio, dev)) {
+		serio->private = NULL;
 		kfree(atkbd);
 		return;
 	}
@@ -526,6 +528,7 @@
 
 		if (atkbd_probe(atkbd)) {
 			serio_close(serio);
+			serio->private = NULL;
 			kfree(atkbd);
 			return;
 		}
