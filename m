Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbTFWMgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 08:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbTFWMgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 08:36:33 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:50936 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265782AbTFWMga
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:36:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Davide Libenzi <davidel@xmailserver.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: O(1) scheduler & interactivity improvements
Date: Mon, 23 Jun 2003 07:50:13 -0500
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1056298069.601.18.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.55.0306221238230.15064@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0306221238230.15064@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Message-Id: <03062307501302.31982@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 June 2003 15:00, Davide Libenzi wrote:
> On Sun, 22 Jun 2003, Felipe Alfaro Solana wrote:
> > Hi all,
> >
> > I must say I'm a little bit disappointed with the interactive feeling of
> > latest kernels. From what I have read, it seems the scheduler decides on
> > the "interactive" behavior of a process based on its CPU usage and
> > sleeping times. I am no kernel expert, so I will assume this is how it
> > works, more or less, behind the scenes.
> >
> > I think that marking a process as "interactive" based on the previous
> > premise is quite unreal. Let's take, for example, a real application
> > like a word processor which performs background spell checking. The word
> > processor should be considered interactive, even when it may be hogging
> > the CPU a lot to perform the background spell check and the rest of its
> > threads are sleeping waiting for user input.
>
> I'm sorry to disagree. A word processor that waited 24 hours to receive an
> input should be *gradually* migrated to lower priorities (CPU hogs) when
> it starts eating all its timeslice. You can tune how *gradually* (negative
> feedback) you move the process, but you can't bolt in explicit rules into
> the scheduler. If your word processor that was waiting by 24 hours will
> start eating all its timeslice, it must be migrated down in priority. When
> the spell check will be over, it'll re-gain its status of interactive task.
> One suggestion for Ingo would be to use the previous task history to
> compute how gradually to migrate the task, with a factor for each
> direction. Processes with a long history of interactive tasks should have a
> brake when migrating towards lower priorities, like the ones that showed
> CPU hogs properties repeatedly should have a brake when moving to higher
> priorities. The value of this "brake" should be made function of the
> previous history.

Wait a minute... A word processor that waits 24 hours to recieve an input is
IDLE for everything except file save/checkpoint.

No CPU utilization at all.

What SHOULD happen gradually is that it's memory (RSS) should be trimmed due
to lack of activity.

The processor priority should/could stay the same (or even go higher). That
way the applications gets a chance to page in necessary data AS SOON as the
input IS available.

The described word processor is a MEMORY scheduling issue, not an interactive
scheduling issue.

Interactive jobs can be identified by having short term sleep events occuring
before (more often than) timeslice consumption. These processes could use a
priority boost (special conditions do occurr with polling without a timeout).

Those processes that exhaust a timeslice frequently are CPU bound, with 
little I/O involved. These could do with a reduced priority (again, some
special conditions do occur with poll).
