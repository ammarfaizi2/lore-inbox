Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTJPC0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 22:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTJPC0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 22:26:40 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:20364 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262622AbTJPC0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 22:26:39 -0400
Date: Wed, 15 Oct 2003 22:25:47 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: kakadu_croc@yahoo.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031016022547.GA615@phunnypharm.org>
References: <20031015032215.58d832c1.akpm@osdl.org> <20031015123444.46223.qmail@web40904.mail.yahoo.com> <20031015102810.4017950f.akpm@osdl.org> <20031015174047.GE971@phunnypharm.org> <20031015105359.31c016c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015105359.31c016c3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 10:53:59AM -0700, Andrew Morton wrote:
> Ben Collins <bcollins@debian.org> wrote:
> >
> > > highlevel_add_host() does read_lock() and then proceeds to do things like
> >  > starting kernel threads under that lock.  The locking is pretty broken
> >  > in there :(
> > 
> >  No, highlevel_add_host() itself doesn't start any threads. But it does
> >  pass around data that needs to be locked from changes, and one of the
> >  handlers happens to start a thread, and other things allocate memory
> >  (such as this case).
> > 
> >  It's ugly, and I've been trying to clean it up. This case can be fixed
> >  quickly with a simple check in hpsb_create_hostinfo() to pass GFP_ATOMIC
> >  to kmalloc.
> 
> nodemgr_add_host() looks like the hard one.  Maybe make hl_drivers_lock a
> sleeping lock?

Problem is, things like bus resets happen in interrupt, and while I can
push off some things to occur in the nodemgr thread, a lot of other
stuff has to happen in the interrupt, and they require the same lock.

It's all a matter of just tossing out my todo list for a good week and
redoing all of this logic from the ground up. I have high hopes this
will happen in the next few weeks, but I'm not signing any contracts to
hold me to it :)

> >  My problem right now, is I don't use any architectures that support
> >  preempt, so I don't see a lot of these problems, like I catch with
> >  CONFIG_SMP.
> 
> Anton had a ppc64 patch which implemented the preempt_count beancounting
> without actually implementing premption.  So might_sleep() does the right
> thing.

I might have to dig that out and try to make use of it. Thanks for the
pointer.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
