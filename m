Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVJGLIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVJGLIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVJGLIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:08:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31208 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751365AbVJGLIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:08:50 -0400
Date: Fri, 7 Oct 2005 13:09:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [patch] pcmcia-shutdown-fix.patch
Message-ID: <20051007110914.GA30873@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu> <20051002151817.GA7228@elte.hu> <5bdc1c8b0510020842p6035b4c0ibbe9aaa76789187d@mail.gmail.com> <5bdc1c8b0510021225y951caf3p3240a05dd2d0247c@mail.gmail.com> <Pine.LNX.4.58.0510061308290.973@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510061308290.973@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo, here's the patch.  This should probably go upstream too since it 
> can happen there too.  The pccardd thread has a race in it that it can 
> shutdown in the TASK_INTERRUPTIBLE state.  Here's the fix.

ah, certainly makes sense. Dominik, does it look good to you too? Patch 
below is for upstream.

	Ingo

----

The pccardd thread has a race in it that it can shutdown in the 
TASK_INTERRUPTIBLE state. Found on the -rt kernel.

From: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--

 drivers/pcmcia/cs.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux/drivers/pcmcia/cs.c
===================================================================
--- linux.orig/drivers/pcmcia/cs.c
+++ linux/drivers/pcmcia/cs.c
@@ -689,6 +689,9 @@ static int pccardd(void *__skt)
 		schedule();
 		try_to_freeze();
 	}
+	/* make sure we are running before we exit */
+	set_current_state(TASK_RUNNING);
+
 	remove_wait_queue(&skt->thread_wait, &wait);
 
 	/* remove from the device core */
