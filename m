Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVLFBwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVLFBwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVLFBwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:52:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9949 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964908AbVLFBwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:52:19 -0500
Date: Tue, 6 Dec 2005 02:52:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206015200.GJ1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <20051205172938.GC25114@atrey.karlin.mff.cuni.cz> <1133816579.3872.83.camel@localhost> <20051205233430.GA1770@elf.ucw.cz> <1133832410.6360.35.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133832410.6360.35.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > If goal is "make it work with least effort", answer is of course
> > > > suspend2; but I need someone to help me doing it right.
> > > 
> > > How do you think suspend2 does it wrong? Is it just that you think that
> > > everything belongs in userspace, or is there more to it?
> > 
> > Everything belongs in userspace... that makes it "wrong
> > enough". Userland and kernel programming is quite different, so any
> > improvements to suspend2 will be wasted, long-term. You'll make users
> > happy for now, but it means u-swsusp gets less users and less
> > developers, making "doing it right" slightly harder...
> 
> Ok. I guess I need help then in seeing why everything belongs in
> userspace. Actually, let's revise that for a start - I know you don't
> really mean everything, because even you still do the atomic copy in
> kernel space... or are you planning on changing that too? :)

Unfortunately atomic copy can not be moved to userspace, nor can be
driver handling moved. [If I knew how to do it completely from
userspace, I definitely would, BTW.]

> I'm not unwilling to be convinced - I just don't see why, with such a
> lowlevel operation as suspending to disk, userspace is the place to put
> everything. The preference for userspace seems to me to be just that - a
> preference.

Its actually pretty hard rule. It should be userspace if it reasonably
can. It should be userspace if it contains policy.

suspend2 contains bits of policy -- esc to cancel, compression
options, encryption options. It is not unreasonable that someone would
want any key to cancel, or some other compression, or something like
that. You actually put progressbar code into userspace -- good
step. So you have all the complexity of userspace running during
suspend/resume (it is not that bad), but are not using full benefits
-- move more code to userspace. 

Practical benefits of u-swsusp should be:

* no need to split userland parts in small pieces.

* it is easier to develop in userspace.

* access to libraries -- adding LZW or whatever is not a problem. No
need to convert those libraries to kernel coding style.

* it is possible to have multiple version. In kernel, only one version
can exist, but in userland, it is okay to have few implementations.

> Regarding improvements to suspend2 being wasted long term, I actually
> think that I could port at least part of it to userspace without too
> much effort at all. My main concern would be exporting the information
> and interfaces needed in a way that isn't ugly, is reliable and doesn't
> open security holes. I'm not at all convinced that kmem meets those
> criteria. But if you can show me a better way, I'll happily come on
> board.

I have thought about this. We already mark pages for suspend with
PageNosave | PageNosaveFree; we could only allow access to pages
marked like this by /dev/suspend, or something like that. 

Rafael thinks we should provide nicer interface to userspace; that's
okay with me as long as it is not slow or too much of code.

								Pavel
-- 
Thanks, Sharp!
