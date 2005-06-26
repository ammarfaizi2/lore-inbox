Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFZLp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFZLp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 07:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFZLp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 07:45:58 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:51408 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261205AbVFZLp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 07:45:27 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Daniel Arnold <arnomane@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 plugins
References: <arnomane@gmx.de>
	<200506250040.j5P0eXDQ005342@laptop11.inf.utfsm.cl>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 26 Jun 2005 13:45:24 +0200
In-Reply-To: <200506250040.j5P0eXDQ005342@laptop11.inf.utfsm.cl>
Message-ID: <m3ll4x5okr.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Daniel Arnold <arnomane@gmx.de> wrote:
> > Another idea is a CVS-like revision file system. Especially in /etc/ this
> > would help a lot... Imagine a revision-plugin for Reiser4: This system
> > would be self documenting as you don't need to keep in mind where, when,
> > what you changed (and for system scripts it would be easier to track the
> > manual manipulations; especially a problem at system upgrades). You could
> > easily make a diff of two revisions of a file e.g. for
> > /etc/squid/squid.conf (a huge single config file) with standard command
> > line tools like diff (like "diff /etc/squid/squid.conf/rev-0
> > /etc/squid/squid.conf/rev-current").
> 
> And why don't you use a version management system for this? You could use
> RCS (simple, easy to use; but doesn't handle sideways relations at all), or
> something more complex. Userland solutions /do/ exist, and work fine. They
> even handle saving stuff over the network, etc.

And this can be solved much nicer by using inotify/dnotify and a
callout to whatever version management system the user prefers.  Why
lock oneself into just one version managed filesystem?

The same goes for a local search engine such as spotlight, it doesn't
have to be integrated into the kernel, all that has to be in the
kernel is the infrastructure that can inform the engine about file
changes.  And look, we have just that in dnotify and inotify, generic
infrastructure that can be made to work on all filesystems, and is not
just limited to one.

> > Another possibility would be e.g. replacing the RPM-database by a
> > structure in the Reiser4 file system. Imagine the structure of the rpm
> > database which software is installed sitting below /etc/packages/,
> > e.g. in /etc/packages/apache/. With removing the /etc/packages/apache/
> > directory a clever Reiser4-plugin would instantly remove the whole
> > package (don't know how to handle the problem of executing necessary
> > system scripts during that procedure though). That this idea is highly
> > demanded can be seen on Apple computers and on a wired approach at a new
> > FreeBSD distribution called PC-BSD, where everything of a application is
> > installed in a own separate directory as on Windows...
> 
> And shove RPM into the kernel... 
> 
> All this means that you have /zilch/ possibility to savage your data if the
> system with the custom plugins isn't available. Thanks, had more than
> enough fun with corrupted "databases" elsewhere. No need to make /all/ data
> dependent on something like that.

Well, generic filesystem transactions would be nice, but it is a hard
problem to solve.  There would have to be limits on how large a
transaction can be, there must be some way to handle deadlocks where
two different processes try to modify the same file concurrently.
Then there's security, what happens if one process starts a
transaction and then asks a suid process to write to a file in that
transaction, can the suid application handle that?  What if the
unprivileged process has started a different transaction already, can
the suid process handle getting a -EDEADLOCK error properly?

I'd love to have filesystem transactions in Linux, but I don't belive
its easy to do and I don't know if the complexity is worth it.  And
besides, if someone shows that it is possible, and desirable, I'd like
to have them on ext3.  So I would prefer to see a generic transaction
API in the VFS that can be implemented by multiple filsystemes.  This
does not belong in just one filesystem IMHO.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
