Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVA3XCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVA3XCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVA3XCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:02:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:60363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261823AbVA3XC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:02:26 -0500
Date: Sun, 30 Jan 2005 15:02:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: bcollins@debian.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() &&
 irqs_disabled()
Message-Id: <20050130150224.33299170.akpm@osdl.org>
In-Reply-To: <41FD6478.9040404@comcast.net>
References: <41FD498C.9000708@comcast.net>
	<20050130131723.781991d3.akpm@osdl.org>
	<41FD6478.9040404@comcast.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
>
> Andrew Morton wrote:
> 
> ...
> >- We'll need a flush_workqueue() in the teardown function for that data
> >  structure to ensure that any pending callbacks have completed before we
> >  free the storage.
> >  
> >
> By saying flush_workqueue did you intend to suggest using separate work 
> queue for ohci1394?

No.  Using keventd and flush_scheduled_work() should be OK in this
application.  rmmod isn't very common.

> >  Care needs to be taken to ensure that the work_struct is suitably
> >  initialised so that the flush_workqueue() will work OK even if the
> >  callback has never been scheduled.
> >  
> >
> Didn't understand this one  - Is this about properly NULL'ing elements 
> in work queue so flush_workqueue doesn't touch them? Can you elaborate 
> please?

Well, it's just that the shutdown code needs to run flush_scheduled_work()
or flush_workqueue() on a work_struct which may or may not have been used. 
So we need to ensure that it has sane contents.  Just run INIT_WORK() on it
in the setup code.

