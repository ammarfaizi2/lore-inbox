Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVJFRO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVJFRO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVJFRO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:14:28 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54174 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751241AbVJFRO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:14:27 -0400
Date: Thu, 6 Oct 2005 13:13:31 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Mark Knecht <markknecht@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: Re: 2.6.14-rc3-rt1
In-Reply-To: <5bdc1c8b0510021225y951caf3p3240a05dd2d0247c@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510061308290.973@localhost.localdomain>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
  <20051002151817.GA7228@elte.hu>  <5bdc1c8b0510020842p6035b4c0ibbe9aaa76789187d@mail.gmail.com>
 <5bdc1c8b0510021225y951caf3p3240a05dd2d0247c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Oct 2005, Mark Knecht wrote:

>
> The only problem I had over the last few days happened with
> 2.6.14-rc2-rt7. One time, when attempting to shutdown, the machine
> hung after the 'Unloading Alsa modules...[OK]' step.

Acutally it may be the next step.  Do you have pcmcia configured?  I've
been noticing that my system has been locking up on shutdown of the
pcmcia.

Ingo, here's the patch.  This should probably go upstream too since it can
happen there too.  The pccardd thread has a race in it that it can
shutdown in the TASK_INTERRUPTIBLE state.  Here's the fix.

-- Steve

PS. Thanks for the info on quilt ;-)

Index: linux-rt-quilt/drivers/pcmcia/cs.c
===================================================================
--- linux-rt-quilt.orig/drivers/pcmcia/cs.c	2005-10-06 08:03:56.000000000 -0400
+++ linux-rt-quilt/drivers/pcmcia/cs.c	2005-10-06 12:48:02.000000000 -0400
@@ -689,6 +689,9 @@
 		schedule();
 		try_to_freeze();
 	}
+	/* make sure we are running before we exit */
+	set_current_state(TASK_RUNNING);
+
 	remove_wait_queue(&skt->thread_wait, &wait);

 	/* remove from the device core */
