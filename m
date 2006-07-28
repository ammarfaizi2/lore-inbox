Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161330AbWG1Wdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWG1Wdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161336AbWG1Wdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:33:37 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:51106 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1161330AbWG1Wdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:33:37 -0400
Subject: Re: [RFC] /dev/itimer
From: Nicholas Miell <nmiell@comcast.net>
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060728235951.7de534eb.froese@gmx.de>
References: <20060728235951.7de534eb.froese@gmx.de>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 15:33:35 -0700
Message-Id: <1154126015.2451.13.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 23:59 +0200, Edgar Toernig wrote:
> Hi,
> 
> this is a simple driver which provides interval timers via
> file descriptors.
> 
> Everytime I have to write code to do something at regular
> intervals I face the problem that the time routines on Unix 
> are pretty archaic.  Only a single process wide timer which
> notifies via signals.  The single timer asks for a dedicated
> roll-your-own timer infrastructur, usually implemented via
> a lot of gettimeofday calls and appropriate select timeouts.
> But even if the single timer is enough, the delivery via
> signals is error prone and breaks a lot of (i.e. library)
> code, especially when the timer rate is high.  One common
> work around is forking a separate task which gets the signals
> and a pipe to notify the main process which may select/poll
> the other and of the pipe.  But this is pretty heavy-weight
> and not easy to get right either.  Recently, people started
> to use the real time clock driver (/dev/rtc) to get an fd
> to sleep on.  But this is even worse as there's (usually)
> only a single one in the whole system and you have to decide
> whether i.e. mplayer, artsd, timidity, or vdr gets it.

Pretty much everything in this paragraph is wrong, except for the part
about the difficulty of making a single unified event loop and the
resulting pipe hack that everybody uses to get around that.

Solaris lets you specify SIGEV_PORT in your struct sigevent which then
queues timer completions (or anything else that takes a struct sigevent,
like POSIX AIO) to a port and then all types of queued events (including
fd polling and user generated events) can be waited on and fetched with
a single function call.

Something similar could probably worked up in Linux which queues timer
completions to an AIO context.

You might also want to look into the event channel / kevent discussion
that's currently in progress.

-- 
Nicholas Miell <nmiell@comcast.net>

