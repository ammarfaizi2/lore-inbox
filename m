Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTHWNMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264230AbTHWNMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:12:47 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:31360
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263975AbTHWNMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:12:37 -0400
Date: Sat, 23 Aug 2003 07:41:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [PATCH 2.6] 2/3 Serio: possible race in handle_events
In-Reply-To: <20030823003447.24aa1efc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0308230739290.15935@montezuma.fsmlabs.com>
References: <200308230131.45474.dtor_core@ameritech.net>
 <200308230206.25142.dtor_core@ameritech.net> <20030823001922.487f83f5.akpm@osdl.org>
 <200308230225.10308.dtor_core@ameritech.net> <20030823003447.24aa1efc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003, Andrew Morton wrote:

> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > Do you think we should introduce allocate_serio/free_serio pair for dynamically 
> >  allocated serios; free_serio would scan event_list and invalidate events that 
> >  refer to freed serio?
> 
> I don't understand the subsystem well enough to say.  But if we are
> receiving events which refer to an already-freed serio then something is
> very broken.  We should be draining all those events before allowing the
> original object to be freed up.
> 
> Let's wait for Vojtech's comments.

This sounds somewhat like;

http://bugzilla.kernel.org/show_bug.cgi?id=973

Jul 25 04:54:24 lap kernel: slab error in cache_free_debugcheck(): cache 
`size-32': double free, or memory before object was overwritten
Jul 25 04:54:24 lap kernel: Call Trace:
Jul 25 04:54:24 lap kernel:  [<c014f130>] kfree+0xf0/0x310
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c025560d>] serio_handle_events+0xad/0xc0
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255665>] serio_thread+0x45/0x100
Jul 25 04:54:24 lap kernel:  [<c010a126>] work_resched+0x5/0x16
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c01073b9>] kernel_thread_helper+0x5/0xc
Jul 25 04:54:24 lap kernel:
Jul 25 04:54:24 lap kernel: slab error in cache_free_debugcheck(): cache 
`size-32': double free, or memory after  object was overwritten

Jul 25 04:54:24 lap kernel: Call Trace:
Jul 25 04:54:24 lap kernel:  [<c014f15e>] kfree+0x11e/0x310
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c025560d>] serio_handle_events+0xad/0xc0
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255665>] serio_thread+0x45/0x100
Jul 25 04:54:24 lap kernel:  [<c010a126>] work_resched+0x5/0x16
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c01073b9>] kernel_thread_helper+0x5/0xc
Jul 25 04:54:24 lap kernel:
