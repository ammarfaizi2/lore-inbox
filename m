Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTEWGqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTEWGqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:46:22 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:34319 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263720AbTEWGqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:46:18 -0400
Date: Fri, 23 May 2003 09:06:10 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Andrew Morton <akpm@digeo.com>
cc: "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
In-Reply-To: <20030515181211.5853fd18.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0305230840140.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Andrew Morton wrote:

> > > [ unregister_netdevice calls call_usermodehelper which waits for keventd to
> > >   pick up the subprocess_info, but keventd is blocked on rtnl_lock, which
> > >   unregister_netdev took ]
> 
> 
> "David S. Miller" <davem@redhat.com> wrote:
> >
> > I'd much rather see /sbin/hotplug be able to handle things
> > asynchonously.
> 
> Yeah, I'm inclined to agree.  I'll take a look at it.

Asking just because there was another user hitting this deadlock: it seems 
with linux-irda we have a very good test case for reproducing this issue.
So I'd be happy to go testing patches if this might help.

I've also looked into the code to see if I could do something myself. 
Well, personally I do also think the best way would be to modify the 
kernel hotplug part so we can call it asynch under rtnl-lock. 
Unfortunately, given the fact there are already several layers 
(schedule_work, 2 times kernel_thread and execve) stacked on top of each 
other, I'm pretty much lost how to fix it without breaking other stuff.

I was also thinking about making net_run_sbin_hotplug asynch itself, but 
I'm unsure how this might interact with call_usermodehelper(), namely
wrt. the wait=0 parameter.

I assume we all agree this issue isn't easy to resolve. May I suggest 
adding it to the must-fix-before-2.6 list so it wouldn't get lost?
As people tend to run with CONFIG_HOTPLUG=y there would be a lot of 
trouble with 2.6 otherwise.

Thanks.
Martin

