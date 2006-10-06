Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWJFLiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWJFLiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWJFLiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:38:19 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32462 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751215AbWJFLiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:38:18 -0400
Subject: Re: 2.6.18-git21, possible recursive locking in kseriod ends up in
	DWARF2 unwinder stuck
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <d120d5000610051334o7604b1d4hd2f4c9a9b858f06e@mail.gmail.com>
References: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com>
	 <Pine.LNX.4.64.0610042317590.12556@twin.jikos.cz>
	 <d120d5000610051334o7604b1d4hd2f4c9a9b858f06e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 13:38:16 +0200
Message-Id: <1160134696.2792.102.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 16:34 -0400, Dmitry Torokhov wrote:
> On 10/4/06, Jiri Kosina <jikos@jikos.cz> wrote:
> > On Wed, 4 Oct 2006, Alessandro Suardi wrote:
> >
> > > Non-fatal (box is still alive and apparently well) on boot,
> > > FC5-uptodate on a Dell Latitude C640. From the dmesg ring:
> >
> > > [    8.680000] =============================================
> > > [    8.680000] [ INFO: possible recursive locking detected ]
> > > [    8.680000] 2.6.18-git21 #1
> > > [    8.680000] ---------------------------------------------
> > > [    8.680000] kseriod/163 is trying to acquire lock:
> > > [    8.680000]  (&ps2dev->cmd_mutex/1){--..}, at: [<c03198c3>]
> > > ps2_command+0x89/0x358
> >
> > Me and Peter Zijlstra have already submitted patches to fix this - read
> > the thread at
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-09/msg07416.html
> >
> > I don't know the reason why these have not yet been merged into the input
> > tree. Dmitry?
> >
> 
> Sorry, was a little busy.
> 
> I tested the patches and they work. Couple of comments:
> 
> - register_lock_class is marked as inline but now has 2 call sites and
> is relatively big - might want to remove "inline"
> - how about adding lockdep_set_subclass() to avoid littering source
> with struct lock_class_key when we only want to tweak subclass? For
> that we might want export register_lock_class and hide it behind a
> #define...
> 

or something like this:

#define concat_i(a)	#a
#define concat(a,b)	concat_i(a ## b)

#define lockdep_set_subclass(lock, subclass) \
  ({ static struct lock_key_class __key; \
     lockdep_init_map(&(lock)->dep_map, concat(lock, subclass), \
                      &__key, subclass); })

