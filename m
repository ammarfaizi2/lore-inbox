Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWJKFfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWJKFfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWJKFfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:35:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:63950 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932440AbWJKFfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:35:53 -0400
From: Neil Brown <neilb@suse.de>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Date: Wed, 11 Oct 2006 15:35:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17708.33450.608010.113968@cse.unsw.edu.au>
Cc: "Andrew Morton" <akpm@osdl.org>, "Pavel Machek" <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.19-rc1-mm1
In-Reply-To: message from Michal Piotrowski on Tuesday October 10
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	<6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 10, michal.k.k.piotrowski@gmail.com wrote:
> On 10/10/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Hi,
> >
> > On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> > >
> >
> > Kernel 2.6.19-rc1-mm1 + Neil's avoid_lockdep_warning_in_md.patch
> > (http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0642.html)
> >
> > (I'll try to reproduce this without Neil's patch).
> 
> I can't reproduce this without Neil's patch.
> 

Despite this circumstantial evidence, I don't see how my patch could
possible have an effect here....

Looking at the code, starting at _cpu_down in the CONFIG_HOTPLUG_CPU
case, the call notifier chain 'cpu_chain' contains
workqueue_cpu_callback which does 'mutex_lock(&workqueue_mutex)' in
the "DOWN_PREPARE" case and mutex_unlock(&workqueue_mutex) in the
DOWN_FAILED and DEAD cases.

blocking_notifier_call_chain is
	down_read(&nh->rwsem);
	ret = notifier_call_chain(&nh->head, val, v);
	up_read(&nh->rwsem);

and so holds ->rwsem while calling the callback.
So the locking sequence ends up as:

 down_read(&cpu_chain.rwsem);
 mutex_lock(&workqueue_mutex);
 up_read(&cpu_chain.rwsem);

 down_read(&cpu_chain.rwsem);
 mutex_unlock(&workqueue_mutex);
 up_read(&workqueue_mutex);

and lockdep doesn't seem to like this.  It sees workqueue_mutex
claimed while cpu_chain.rwsem is held. and then it sees
cpu_chain.rwsem claimed while workqueue_mutex is held, which looks a
bit like a class ABBA deadlock.
Of course because it is a 'down_read' rather than a 'down', it isn't
really a dead lock.

I don't know how to tell lockdep to do the right thing, but I'll leave
that up to Ingo et al.

Why it didn't trigger without my patch I cannot imagine.  Are you sure
the config was identical (you didn't remove CONFIG_HOTPLUG_CPU or
anything did you?).

NeilBrown


> >
> > echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> >
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > 2.6.19-rc1-mm1 #4
> > -------------------------------------------------------
