Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWFOKrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWFOKrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 06:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWFOKrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 06:47:06 -0400
Received: from tougher.kangaroot.net ([62.213.203.135]:17837 "EHLO
	tougher.kangaroot.net") by vger.kernel.org with ESMTP
	id S1030191AbWFOKrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 06:47:04 -0400
Date: Thu, 15 Jun 2006 12:47:02 +0200
From: Wouter Paesen <wouter@kangaroot.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.17-rc6] input/mouse/sermouse: fix memleak and potential buffer overflow
Message-ID: <20060615104702.GA4866@tougher.kangaroot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While strolling trough the sermouse driver for some example code, I
noticed 2 strange things happening there :

* In the sermouse_connect function an input device structure is
  allocated (input_allocate_device), which is not deallocated 
  in the sermouse_disconnect function.  
  
  If I understand this correctly someone repeatedly connecting and 
  disconnecting the mouse would leak input_dev structures.

* In the sermouse_connect function the phys member of the sermouse 
  structure (32 characters) is initialised with :

     sprintf(sermouse->phys, "%s/input0", serio->phys);

  Because serio->phys is also a 32 character field the sprintf could
  result in 39 characters being written to the sermouse->phys.

If my understanding of both these concepts is correct, this is a patch
to fix the problems.

Signed-off-by: Wouter Paesen <wouter@kangaroot.net>

--- a/drivers/input/mouse/sermouse.c	2006-06-15 08:47:47.000000000 +0200
+++ b/drivers/input/mouse/sermouse.c	2006-06-15 08:52:13.000000000 +0200
@@ -53,7 +53,7 @@
 	unsigned char count;
 	unsigned char type;
 	unsigned long last;
-	char phys[32];
+	char phys[39];
 };
 
 /*
@@ -233,6 +233,7 @@
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 	input_unregister_device(sermouse->dev);
+	input_free_device(sermouse->dev);
 	kfree(sermouse);
 }
