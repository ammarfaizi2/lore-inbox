Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUG0Jcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUG0Jcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUG0JbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:31:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:38892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbUG0J3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:29:54 -0400
Date: Tue, 27 Jul 2004 02:28:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
Message-Id: <20040727022826.2c95d8ff.akpm@osdl.org>
In-Reply-To: <41061AC0.8000607@suse.de>
References: <40FD23A8.6090409@suse.de>
	<20040725182006.6c6a36df.akpm@osdl.org>
	<4104E421.8080700@suse.de>
	<20040726131807.47816576.akpm@osdl.org>
	<4105FE68.7040506@suse.de>
	<20040727002409.68d49d7c.akpm@osdl.org>
	<41060B62.1060806@suse.de>
	<20040727013427.52d3e5f5.akpm@osdl.org>
	<41061AC0.8000607@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> wrote:
>
>  Problem with your patch is that call_usermodehelper might block on 
>  down() regardless whether it is called async or sync.
>  So any write to sysfs which triggers a hotplug event might block until 
>  enough resources are available.

This is exactly the behaviour we want.  If we don't block the caller then
the only option is to fail the call_usermodehelper() attempt, which would
be very bad indeed.

The main reason for calling call_usermodehelper(wait=0) is that the caller
holds locks which will prevent the helper application from terminating.  I
guess my proto-patch risks the same deadlock, because all the
currently-running helpers may be waiting on that lock.

Maybe this is why you were allocating a copy of the call_usermodehelper()
arguments?  I didn't try to reverse-engineer your patch to that extent -
I'd prefer to hear the design in your own words.  Am still waiting for
this, btw.

Allocating a whole bunch of buffers to hold copies of the
call_usermodehelper() args also uses resources, of course.  But it should
be acceptable.  We'd allocate the same amount of memory if we were sending
messages up a socket/pipe to userspace, which is what we should always have
done, instead of the direct-exec - it's caused tons of trouble.

You didn't answer half the questions in my previous email, btw.

Right now, I cannot think of any solution apart from:

- In the sync path, take the semaphore

- In the async path, take a copy of the args, then pass them over to some
  kernel thread which takes the args off a list one-at-a-time, takes the
  semaphore for each one, execs the helper and drops the semaphore on the
  exit path.
