Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUGZUo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUGZUo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGZUnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:43:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:39627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265789AbUGZUTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:19:35 -0400
Date: Mon, 26 Jul 2004 13:18:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
Message-Id: <20040726131807.47816576.akpm@osdl.org>
In-Reply-To: <4104E421.8080700@suse.de>
References: <40FD23A8.6090409@suse.de>
	<20040725182006.6c6a36df.akpm@osdl.org>
	<4104E421.8080700@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> wrote:
>
> > 
>  >> Any comments/suggestions welcome; otherwise please apply.
>  > 
>  > 
>  > I suggest you just use a semaphore, initialised to a suitable value:
>  > 
>  > 
>  > static struct semaphore foo = __SEMAPHORE_INITIALIZER(foo, 50);
>  > 
>  > 
>  > {
>  > 	...
>  > 	down(&foo);
>  > 	...
>  > 	up(&foo);
>  > 	...
>  > }
>  > 
>  Hmm; looks good, but: It's not possible to reliably change the maximum 
>  number of processes on the fly.
> 
>  The trivial way of course it when the waitqueue is empty and no 
>  processes are holding the semaphore. But it's quite non-obvious how this 
>  should work if processes are already holding the semaphore.
>  We would need to wait for those processes to finish, setting the length 
>  of the queue to 0 (to disallow any other process from grabbing the 
>  semaphore), and atomically set the queue length to the new value.
>  Apart from the fact that we would need a worker thread for that 
>  (otherwise the calling process might block indefinitely), there is no 
>  guarantee that the queue ever will become empty, as hotplug processes 
>  might be generated at any time.
> 
>  Or is there an easier way?

Well if you want to increase the maximum number by ten you do:

	for (i = 0; i < 10; i++)
		up(&foo);

and similarly for decreasing the limit.  That will involve doing down()s,
which will automatically wait for the current number of threads to fall to
the desired level.

But I don't really see a need to tune this on the fly - probably the worse
problem occurs during bootup when the operator cannot perform tuning.

So a __setup parameter seems to be the best way of providing tunability. 
Initialise the semaphore in usermodehelper_init().
