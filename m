Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVC3S5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVC3S5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVC3S4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:56:32 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:23475 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262400AbVC3Svk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:51:40 -0500
Subject: [patch 8/8] Fix the console stuttering [for 2.6.12]
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       rob@landley.net
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:34:06 +0200
Message-Id: <20050330173407.169FFEFF2A@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Rob Landley <rob@landley.net>

I spent far too much of the weekend tracking this sucker down through the guts
of the tty code.  The problem turns out to be that drivers/char/n_tty.c has a
write_chan that does buffering and retransmitting data, and
arch/um/drivers/chan_kern.c ALSO has a write_chan that buffers and retransmits
data, and the first calls the second but the second doesn't always return
correct status information for the -EAGAIN case.

When they get confused, both of them try to buffer and retransmit data, hence
the stuttering.

The first fix is that if chan_kern's write_chan gets an -EAGAIN, it should NOT
gratuitously change that to a 0 before returning.  I don't know why that code
is in there, but deleting those two lines makes 90% the stuttering go away. 
But not quite all of it.

The second half of the fix is arch/um/drivers/line.c has a buffer_data()
function that adds data to the buffer, tries to flush the buffer out to disk,
gets -EAGAIN, and then returns -EAGAIN even though it successfully buffered
all the data it was sent.  So the upper layer resubmits the last chunk of data
it sent when the console unblocks, even though the lower layer buffered it and
sent it on by that point.

With this patch, I can't get the UML console to stutter anymore by suspending
the process it's writing to.  (Add tee to the mix and you can still make it
hang by suspending its xterm for a second or two, but I think that tee
is hanging, not UML.  Hangs with RHEL4 tee, but not busybox tee...)

Signed-off-by: Rob Landley <rob@landley.net>
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/chan_kern.c |    5 +----
 linux-2.6.11-paolo/arch/um/drivers/line.c      |    2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff -puN arch/um/drivers/chan_kern.c~uml-fix-console-stuttering arch/um/drivers/chan_kern.c
--- linux-2.6.11/arch/um/drivers/chan_kern.c~uml-fix-console-stuttering	2005-03-29 17:03:18.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/drivers/chan_kern.c	2005-03-29 17:03:19.000000000 +0200
@@ -248,11 +248,8 @@ int write_chan(struct list_head *chans, 
 		n = chan->ops->write(chan->fd, buf, len, chan->data);
 		if (chan->primary) {
 			ret = n;
-			if ((ret == -EAGAIN) || ((ret >= 0) && (ret < len))){
+			if ((ret == -EAGAIN) || ((ret >= 0) && (ret < len)))
 				reactivate_fd(chan->fd, write_irq);
-				if (ret == -EAGAIN)
-					ret = 0;
-			}
 		}
 	}
 	return(ret);
diff -puN arch/um/drivers/line.c~uml-fix-console-stuttering arch/um/drivers/line.c
--- linux-2.6.11/arch/um/drivers/line.c~uml-fix-console-stuttering	2005-03-29 17:03:19.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/drivers/line.c	2005-03-29 17:03:19.000000000 +0200
@@ -128,7 +128,7 @@ int line_write(struct tty_struct *tty, c
 		ret = buffer_data(line, buf, len);
 		err = flush_buffer(line);
 		local_irq_restore(flags);
-		if(err <= 0)
+		if(err <= 0 && (err != -EAGAIN || !ret))
 			ret = err;
 	}
 	else {
_
