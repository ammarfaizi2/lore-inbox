Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWBENgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWBENgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 08:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWBENgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 08:36:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:10661 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750796AbWBENgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 08:36:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Date: Sun, 5 Feb 2006 14:34:40 +0100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nigel@suspend2.net
References: <200602051014.43938.rjw@sisk.pl> <20060205111815.GG1790@elf.ucw.cz> <200602051239.53175.rjw@sisk.pl>
In-Reply-To: <200602051239.53175.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051434.41686.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 February 2006 12:39, Rafael J. Wysocki wrote:
> On Sunday 05 February 2006 12:18, Pavel Machek wrote:
> > On Ne 05-02-06 12:11:06, Rafael J. Wysocki wrote:
> > > On Sunday 05 February 2006 11:50, Ingo Molnar wrote:
> > > > 
> > > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > 
> > > > > > The logic in that loop makes my brain burst.
> > > > > > 
> > > > > > What happens if a process does vfork();sleep(100000000)?
> > > > > 
> > > > > The freezing of processes will fail due to the timeout.
> > > > > 
> > > > > Without the if (!p->vfork_done) it would fail too, because the child 
> > > > > would be frozen and the parent would wait for the vfork completion in 
> > > > > the TASK_UNINTERRUPTIBLE state (ie. unfreezeable).  But in that case 
> > > > > we have a race between the "freezer" and the child process (ie. if the 
> > > > > child gets frozen before it completes the vfork completion, the paret 
> > > > > will be unfreezeable) which sometimes leads to a failure when it 
> > > > > should not.  [We have a test case showing this.]
> > > > 
> > > > then i'd suggest to change the vfork implementation to make this code 
> > > > freezable.
> > > 
> > > I think you are right, but I don't know how to do this.
> > > 
> > > > Nothing that userspace does should cause freezing to fail.   If it does,
> > > > we've designed things incorrectly on the kernel side. 
> > > 
> > > I tend to agree.
> > > 
> > > Generally, the problem is due to the use of completions where userland
> > > processes are waited for.  The two places I know of are the vfork
> > > implementation and the usermode helper code.
> > 
> > Can you produce userland testcase? If we have uninterruptible process for
> > days... that's a bug in kernel, suspend or not.
> 
> Sure, no problem.  [Pretty scary, no?]

Actually it's not that bad, because the parent will be killable when the child
exit()s (or gets killed).

Greetings,
Rafael
