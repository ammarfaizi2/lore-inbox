Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVGYTxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVGYTxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVGYTvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:51:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261503AbVGYTux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:50:53 -0400
Date: Mon, 25 Jul 2005 12:50:46 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: usb: printer double up()
Message-Id: <20050725125046.36398aae.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a double up() is actually safe in Linux, but still, it's a bug.
This fix is present in 2.6.13-rc3.

By Domen Puncer <domen@coderock.org>
up(&usblp->sem) was called twice in a row in this code path.

--- linux-2.4.31/drivers/usb/printer.c	2004-08-10 13:43:36.000000000 -0700
+++ linux-2.4.31-usb/drivers/usb/printer.c	2005-06-05 11:21:12.000000000 -0700
@@ -740,6 +740,7 @@ static ssize_t usblp_read(struct file *f
 				schedule();
 			} else {
 				set_current_state(TASK_RUNNING);
+				down (&usblp->sem);
 				break;
 			}
 			down (&usblp->sem);
