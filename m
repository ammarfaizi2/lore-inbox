Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWGHBlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWGHBlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 21:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWGHBlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 21:41:55 -0400
Received: from xenotime.net ([66.160.160.81]:49070 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751295AbWGHBly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 21:41:54 -0400
Date: Fri, 7 Jul 2006 18:44:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jonsmirl@gmail.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       paulkf@microgate.com, akpm@osdl.org
Subject: Re: [PATCH] Ref counting for tty_struct and some locking clean up
Message-Id: <20060707184439.7927721d.rdunlap@xenotime.net>
In-Reply-To: <20060707183909.6ea6d05c.rdunlap@xenotime.net>
References: <9e4733910607071737n1bd01042u92b895edaceb73db@mail.gmail.com>
	<20060707183348.157cc272.rdunlap@xenotime.net>
	<9e4733910607071833r3d2dcea0la7e26a6d0b60bd3@mail.gmail.com>
	<20060707183909.6ea6d05c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 18:39:09 -0700 Randy.Dunlap wrote:

> On Fri, 7 Jul 2006 21:33:37 -0400 Jon Smirl wrote:
> 
> > On 7/7/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > > On Fri, 7 Jul 2006 20:37:36 -0400 Jon Smirl wrote:
> > >
> > > > This patch removes tty_mutex and replaces it with a ref counted
> > > > tty_struct. A new spinlock, tty_lock, serializes tty
> > > > creation/destruction. This code thoroughly audits everyone taking
> > > > references to tty_struct and tracks them. I have been running it
> > > > locally for a few days without any issues.
> > > >
> > > > If there is a refcount problem it will trigger a WARN_ON. If you hit
> > > > one, defining DEBUG_TTY_REFCOUNT will provide plenty of debug info to
> > > > help locate the missing reference. I definitely found multiple locking
> > > > holes in the old tty_mutex code but they they look hard to hit.
> > > >
> > > > This is just a first step, if this code proves to be stable I'll do
> > > > another round of cleanup. There is room for a lot more work to be
> > > > done. Ultimately there may not even be a need for a tty refcount if
> > > > everything is locked correctly. But that is a big step and we should
> > > > take some smaller ones first.
> > > >
> > > > This is meant for mm until it gets some testing - I don't want to
> > > > break anyone's console. If gmail wraps it let me know and I'll send
> > > > you an attachment.
> > >
> > > It has one wrapped line in it but does not apply cleanly to
> > > 2.6.18-rc1 or to 2.6.17-mm6.  What was it diffed against?
> > >
> > > ---
> > > ~Randy
> > >
> > 
> > Diffed against the current git tree. Commits going into git keep
> > making it have fuzz but none of them have broken it.
> 
> Which current git tree?  www.kernel.org/git/ lists a whole bunch
> of them, then there are some not at kernel.org.

Apparently not to Linus's 2.6 git tree.  I get:

> git pull
Already up-to-date.

and
linus-today> patch -p1 -b --dry-run < ~/tty-ref-count.patch 
patching file drivers/char/tty_io.c
Hunk #1 succeeded at 126 with fuzz 2.
Hunk #2 FAILED at 157.
Hunk #3 FAILED at 1089.
Hunk #4 FAILED at 1183.
Hunk #5 succeeded at 1193 with fuzz 2.
Hunk #6 succeeded at 1202 with fuzz 2.
Hunk #7 succeeded at 1209 with fuzz 1.
Hunk #9 succeeded at 1553 with fuzz 1.
Hunk #11 succeeded at 1630 with fuzz 2.
Hunk #12 FAILED at 1637.
Hunk #13 FAILED at 1667.
Hunk #14 FAILED at 1685.
Hunk #15 FAILED at 1711.
Hunk #16 FAILED at 1829.
Hunk #17 FAILED at 1858.
Hunk #18 FAILED at 1893.
Hunk #19 FAILED at 1918.
11 out of 27 hunks FAILED -- saving rejects to file drivers/char/tty_io.c.rej
patching file drivers/char/vc_screen.c
patching file drivers/char/vt.c
patching file drivers/net/ppp_async.c
patching file drivers/serial/serial_core.c
patching file drivers/usb/class/cdc-acm.c
patching file fs/devpts/inode.c
patching file include/linux/tty.h
patching file kernel/exit.c
patching file kernel/fork.c
patching file kernel/sys.c
patching file security/selinux/hooks.c

---
~Randy
