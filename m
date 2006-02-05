Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWBELMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWBELMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWBELMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:12:41 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:27812 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751712AbWBELMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:12:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Date: Sun, 5 Feb 2006 12:11:06 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       nigel@suspend2.net
References: <200602051014.43938.rjw@sisk.pl> <200602051134.19490.rjw@sisk.pl> <20060205105037.GA26222@elte.hu>
In-Reply-To: <20060205105037.GA26222@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051211.07103.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 February 2006 11:50, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > The logic in that loop makes my brain burst.
> > > 
> > > What happens if a process does vfork();sleep(100000000)?
> > 
> > The freezing of processes will fail due to the timeout.
> > 
> > Without the if (!p->vfork_done) it would fail too, because the child 
> > would be frozen and the parent would wait for the vfork completion in 
> > the TASK_UNINTERRUPTIBLE state (ie. unfreezeable).  But in that case 
> > we have a race between the "freezer" and the child process (ie. if the 
> > child gets frozen before it completes the vfork completion, the paret 
> > will be unfreezeable) which sometimes leads to a failure when it 
> > should not.  [We have a test case showing this.]
> 
> then i'd suggest to change the vfork implementation to make this code 
> freezable.

I think you are right, but I don't know how to do this.

> Nothing that userspace does should cause freezing to fail.   If it does,
> we've designed things incorrectly on the kernel side. 

I tend to agree.

Generally, the problem is due to the use of completions where userland
processes are waited for.  The two places I know of are the vfork
implementation and the usermode helper code.

Greetings,
Rafael
