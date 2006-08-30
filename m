Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWH3QuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWH3QuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWH3QuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:50:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28632 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWH3QuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:50:10 -0400
Date: Wed, 30 Aug 2006 09:49:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@infradead.org>, kraxel@bytesex.org,
       haveblue@us.ibm.com, serue@us.ibm.com, Containers@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
Message-Id: <20060830094943.bad0d618.akpm@osdl.org>
In-Reply-To: <44F5BD23.3000209@fr.ibm.com>
References: <20060829211555.GB1945@us.ibm.com>
	<20060829143902.a6aa2712.akpm@osdl.org>
	<44F5BD23.3000209@fr.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 18:30:27 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> Andrew Morton wrote:
> > On Tue, 29 Aug 2006 14:15:55 -0700
> > Sukadev Bhattiprolu <sukadev@us.ibm.com> wrote:
> > 
> >> Replace kernel_thread() with kthread_run() since kernel_thread()
> >> is deprecated in drivers/modules. 
> >>
> >> Note that this driver, like a few others, allows SIGTERM. Not
> >> sure if that is affected by conversion to kthread. Appreciate
> >> any comments on that.
> >>
> > 
> > hm, I think this driver needs more help.
> > 
> > - It shouldn't be using signals at all, really.  Signals are for
> >   userspace IPC.  The kernel internally has better/richer/faster/tighter
> >   ways of inter-thread communication.
> > 
> > - saa7134_tvaudio_fini()-versus-tvaudio_sleep() looks racy:
> > 
> > 	if (dev->thread.scan1 == dev->thread.scan2 && !dev->thread.shutdown) {
> > 		if (timeout < 0) {
> > 			set_current_state(TASK_INTERRUPTIBLE);
> > 			schedule();
> > 
> >   If the wakeup happens after the test of dev->thread.shutdown, that sleep will
> >   be permanent.
> > 
> > 
> > So in general, yes, the driver should be converted to the kthread API -
> > this is a requirement for virtualisation, but I forget why, and that's the
> > "standard" way of doing it.
> > 
> > - The signal stuff should go away if at all possible.
> 
> The thread of this driver allows SIGTERM for some obscure reason. Not sure
> why, I didn't find anything relying on it.
> 
> could we just remove the allow_signal() ?
> 

I hope so.  However I have a bad feeling that the driver wants to accept
signals from userspace.  Hopefully Mauro & co will be able to clue us in.
