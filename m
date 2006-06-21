Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWFUJLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWFUJLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWFUJLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:11:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751435AbWFUJLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:11:16 -0400
Date: Wed, 21 Jun 2006 02:07:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jes@sgi.com, lse-tech@lists.sourceforge.net,
       sekharan@us.ibm.com, stern@rowland.harvard.edu, jtk@us.ibm.com,
       balbir@in.ibm.com, nagar@watson.ibm.com
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
Message-Id: <20060621020754.59dd42c6.akpm@osdl.org>
In-Reply-To: <1150878929.21787.956.camel@stark>
References: <1150242721.21787.138.camel@stark>
	<20060619032453.2c19e32c.akpm@osdl.org>
	<1150878929.21787.956.camel@stark>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 01:35:29 -0700
Matt Helsley <matthltc@us.ibm.com> wrote:

> On Mon, 2006-06-19 at 03:24 -0700, Andrew Morton wrote:
> > On Tue, 13 Jun 2006 16:52:01 -0700
> > Matt Helsley <matthltc@us.ibm.com> wrote:
> > 
> > > Task watchers is a notifier chain that sends notifications to registered
> > > callers whenever a task forks, execs, changes its [re][ug]id, or exits.
> > 
> > Seems a reasonable objective - it'll certainly curtail (indeed, reverse)
> > the ongoing proliferation of little subsystem-specific hooks all over the
> > core code, will allow us to remove some #includes from core code and should
> > permit some more things to be loaded as modules.
> > 
> > But I do wonder if it would have been better to have separate chains for
> > each of WATCH_TASK_INIT, WATCH_TASK_EXEC, WATCH_TASK_UID, WATCH_TASK_GID,
> > WATCH_TASK_EXIT.  That would reduce the number of elements which need to be
> > traversed at each event and would eliminate the need for demultiplexing at
> > each handler.
> 
> 	It's a good idea, and should have the advantages you cited. My only
> concern is that each task watcher would have to (un)register multiple
> notifier blocks. I expect that in most cases there would only be two.

OK.

> Also, if we apply this to per-task notifiers it would mean that we'd
> have a 6 raw notifier heads per-task.

hm, that's potentially a problem.

It's a lock and a pointer.  72 bytes in the task_struct.  I guess we can
live with that.

An alternatve would be to dynamically allocate it, but that'll hurt code
which uses the feature, and will be fiddly.

Perhaps six struct notifier_block *'s, which share a lock?  Dunno.

> 	Would you like me to redo the patches as multiple chains?

Well, how about you see how it looks, decide whether this is worth
pursuing.

It's hard to predict the eventual typical length of these chains.

> Alternately,
> I could produce patches that apply on top of the current set.

It depends on how many of the existing patches are affected.  If it's just
one or two then an increment would be fine.  If it's everything then a new
patchset I guess.

