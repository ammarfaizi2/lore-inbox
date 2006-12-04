Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937227AbWLDRJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937227AbWLDRJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937228AbWLDRJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:09:04 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:44308
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937227AbWLDRJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:09:02 -0500
Date: Mon, 4 Dec 2006 09:08:56 -0800
To: bert hubert <bert.hubert@netherlabs.nl>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Cc: "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH 0/4] lock stat for 2.6.19-rt1
Message-ID: <20061204170856.GA32398@gnuppy.monkey.org>
References: <20061204015323.GA28519@gnuppy.monkey.org> <20061204122129.GA2626@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204122129.GA2626@outpost.ds9a.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 01:21:29PM +0100, bert hubert wrote:
> On Sun, Dec 03, 2006 at 05:53:23PM -0800, Bill Huey wrote:
> 
> > [8264, 996648, 0]		{inode_init_once, fs/inode.c, 196}
> > [8552, 996648, 0]		{inode_init_once, fs/inode.c, 193}
> 
> Impressive, Bill!
> 
> How tightly is your work bound to -rt? Iow, any chance of separating the
> two? Or should we even want to?

Right now, it's solely dependent on -rt, but the basic mechanisms of how
it works is pretty much the same as lockdep. Parts of it should be
moveable across to regular kernels. The only remaining parts would be
altering the lock structure (spinlock, mutex, etc...) to have a pointer
that it can use to do the statistical tracking. If it's NULL then it's
dunamically allocated and handled differently and allocated when the
lock is contended against.

There's other uses for it as well. Think about RCU algorithms that need
to spin-try to make sure the update of an element or the validation of
it's data is safe to do. If an object was created to detect those spins
it'll track what is effectively contention as well as it is represented
in that algorithm. I've seen an RCU radix tree implementation do something
like that.

> > The first column is the number of the times that object was contented against.
> > The second is the number of times this lock object was initialized. The third
> > is the annotation scheme that directly attaches the lock object (spinlock,
> > etc..) in line with the function initializer to avoid the binary tree lookup.
> 
> I don't entirely get the third item, can you elaborate a bit?

I hate the notion of a search, so I directly set the pointer to a
object that's statically defined. It means that the object is directly
connected to what is suppose to backing it without doing a runtime
search.  When that's done, all of the numbers from the second column
get moved to the third.
 
> Do you have a feeling of the runtime overhead?

There's minimal runtime overhead I believe since it's only doing an
atomic increment of the stats during the slowpath before the thread
is actually shoved into a wait queue. That's something that happpens
seldomly.

bill

