Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTKYTZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 14:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTKYTZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 14:25:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:14981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbTKYTZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 14:25:52 -0500
Date: Tue, 25 Nov 2003 11:26:25 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] prevent oops from read of proc entry for tty drivers
Message-Id: <20031125112625.4c2b40f0.shemminger@osdl.org>
In-Reply-To: <20031125004716.GA28135@kroah.com>
References: <20031124155222.6b44d2a3.shemminger@osdl.org>
	<20031125004716.GA28135@kroah.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are /proc handles there setup by proc_tty_register_driver, but there is
no module ownership association, so anything that reads after module unload
will blow.  Fix is to propagate owner of tty_driver to proc entry.

diff -Nru a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
--- a/fs/proc/proc_tty.c	Tue Nov 25 11:18:53 2003
+++ b/fs/proc/proc_tty.c	Tue Nov 25 11:18:53 2003
@@ -198,6 +198,7 @@
 		return;
 	ent->read_proc = driver->read_proc;
 	ent->write_proc = driver->write_proc;
+	ent->owner = driver->owner;
 	ent->data = driver;
 
 	driver->proc_entry = ent;
