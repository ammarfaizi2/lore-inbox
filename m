Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVCHU3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVCHU3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVCHU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:27:37 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:12774
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262136AbVCHTol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:44:41 -0500
Date: Tue, 8 Mar 2005 11:44:19 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, roland@redhat.com, shai@scalex86.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] del_timer_sync scalability patch
In-Reply-To: <20050308081921.GA25679@elte.hu>
Message-ID: <Pine.LNX.4.58.0503081132210.2571@server.graphe.net>
References: <Pine.LNX.4.58.0503072244270.20044@server.graphe.net>
 <20050307233202.1e217aaa.akpm@osdl.org> <20050308081921.GA25679@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Ingo Molnar wrote:

> > >  The following patch makes the timer remember where the timer was last
> > >  started. It is then possible to only wait for the completion of the timer
> > >  on that specific cpu.
>
> i'm not sure about this. The patch adds one more pointer to a very
> frequently used and frequently embedded data structure (struct
> timer_list), for the benefit of a rarely used API variant
> (timer_del_sync()).

Without that pointer there is no information in the timer_list struct as
to where the timer is/was running since base is set to NULL when the timer
function is executed.

> Furthermore, timer->base itself is affine too, a timer always runs on
> the CPU belonging to timer->base. So a more scalable variant of
> del_timer_sync() would perhaps be possible by carefully deleting the
> timer and only going into the full loop if the timer was deleted before.
> (and in which case semantics require us to synchronize on timer
> execution.) Or we could skip the full loop altogether and just
> synchronize with timer execution if _we_ deleted the timer. This should
> work fine as far as itimers are concerned.

There is no easy way to distinguish the case that a timer was deleted
from the case that the timer function is running (which may reschedule
the periodic timer). A scan over all the bases is required to insure that
the timer function is not being executed right now.

If we only would sync when we deleted the timer (meaning timer->base was
!= NULL) then we would not synchronize when the timer function
is executing (and therefore timer->base == NULL). However, we need to sync
exactly in that case because a periodic timer may set timer->base again
when scheduling the next event. That is the main stated purpose of
del_timer_sync.
