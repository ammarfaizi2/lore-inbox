Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUKITE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUKITE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUKITE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:04:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:48604 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261624AbUKITEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:04:55 -0500
Date: Tue, 9 Nov 2004 11:04:21 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christian Kujau <evil@g-house.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@gmail.com>, Matt_Domsch@dell.com
Subject: [PATCH] kobject: fix double kobject_put() in error path of kobject_add()
Message-ID: <20041109190420.GA2498@kroah.com>
References: <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org> <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem introduced in the previous set of driver model
changes that has been seen by a lot of people (most notibly the greater
than 256 pty users, but others might also be hitting this without
realizing it.)

Also add a comment so we don't try to "fix" this again.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

--- a/lib/kobject.c	2004-11-05 10:06:33 -08:00
+++ b/lib/kobject.c	2004-11-08 23:58:02 -08:00
@@ -181,10 +181,10 @@ int kobject_add(struct kobject * kobj)
 
 	error = create_dir(kobj);
 	if (error) {
+		/* unlink does the kobject_put() for us */
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
-		kobject_put(kobj);
 	} else {
 		kobject_hotplug(kobj, KOBJ_ADD);
 	}
