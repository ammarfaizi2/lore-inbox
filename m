Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVFZE2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVFZE2f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 00:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFZE2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 00:28:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8596 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261519AbVFZE17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 00:27:59 -0400
Message-Id: <200506250040.j5P0eXDQ005342@laptop11.inf.utfsm.cl>
To: Daniel Arnold <arnomane@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Daniel Arnold <arnomane@gmx.de> 
   of "Sat, 25 Jun 2005 01:43:16 +0200." <200506250143.17343.arnomane@gmx.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 24 Jun 2005 20:40:33 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Arnold <arnomane@gmx.de> wrote:

[...]

> Although I'm currently using ReiserFS v3 at my (Suse) Linux box (and am
> happy that it uses my small hard disk space better than other file
> systems and that I could always repair the data on the file system in
> some minutes at least in large parts

Not enough in my book.

>                                      in case my _hardware_ caused a
> system crash; I had a evil graphics card...), I'm very excited of the
> possibilities v4 provides and wonder why there are people at LKML that
> don't see those possibilities although they have a lot of more knowledge
> than I have on files system issues (as I'm mainly a user). Perhapes some
> are beside technical concerns trapped into to a "traditional Unix
> religion" (for me this is the real reason why e.g. the free BSD's are
> constantly forked, as everyone thinks he has found the only true way in
> the "Unix religion").

OK, let's look.

> Here are only some possibilities that come into my mind regarding Reiser4:

> One big thing are all the nice applications that want databases like
> MySQL.

Shoving the RDBMS into the kernel doesn't solve this, quite to the
contrary. It makes the whole system less flexible (if you don't want MySQL
but something else, you can't get it easily). The whole is /more/ complex
(kernel space programming is /a huge lot harder/ than userspace
programming). It will be /much more/ unstable, as any idiotic bug in the
RDBMS will bring the /whole system/ down, or screw up completely unrelated
innocent bystanders.

>        As they need that extra database software with its own tools and
> structures they are often too complicated for a normal end user.

Having stuff inside the kernel doesn't make it magically simple(r) to
use. Quite the opposite.

>                                                                  Having
> the same software using an intelligent file system without need for a
> special database would be a big step in end user usability especially but
> not only at the desktop. And of course you can easily manipulate your
> database with easy standard tools like a file manager or from command
> line like cp, mv, rm which would be again a big step back to simplicity.

If what you want to do can be expressed in terms of ln(1), mv(1), rm(1) et
al, do use them and be happy: No need for any fancy database stuff. If it
can't, I'm sorry, but it /will/ be complex anyway.

> Another idea is a CVS-like revision file system. Especially in /etc/ this
> would help a lot... Imagine a revision-plugin for Reiser4: This system
> would be self documenting as you don't need to keep in mind where, when,
> what you changed (and for system scripts it would be easier to track the
> manual manipulations; especially a problem at system upgrades). You could
> easily make a diff of two revisions of a file e.g. for
> /etc/squid/squid.conf (a huge single config file) with standard command
> line tools like diff (like "diff /etc/squid/squid.conf/rev-0
> /etc/squid/squid.conf/rev-current").

And why don't you use a version management system for this? You could use
RCS (simple, easy to use; but doesn't handle sideways relations at all), or
something more complex. Userland solutions /do/ exist, and work fine. They
even handle saving stuff over the network, etc.

> Another possibility would be e.g. replacing the RPM-database by a
> structure in the Reiser4 file system. Imagine the structure of the rpm
> database which software is installed sitting below /etc/packages/,
> e.g. in /etc/packages/apache/. With removing the /etc/packages/apache/
> directory a clever Reiser4-plugin would instantly remove the whole
> package (don't know how to handle the problem of executing necessary
> system scripts during that procedure though). That this idea is highly
> demanded can be seen on Apple computers and on a wired approach at a new
> FreeBSD distribution called PC-BSD, where everything of a application is
> installed in a own separate directory as on Windows...

And shove RPM into the kernel... 

All this means that you have /zilch/ possibility to savage your data if the
system with the custom plugins isn't available. Thanks, had more than
enough fun with corrupted "databases" elsewhere. No need to make /all/ data
dependent on something like that.

> Of course there are competiting approaches to this problem via hiding the
> database structure to the user and reinventing again the file system
> level as e.g. FUSE (which is/was also controversial at LKML but also
> highly demanded by end users). You could also mount a rpm database with a
> proper FUSE-plugin and let it look like a file system but this approach
> is not that elegant, needs a lot more software than the "filesystem as a
> database vision" and has of course poor performance by design compared to
> a direct solution like Reiser4.

You have to consider not only the userland code, but also the kernel
code. That it comes "for free" with ReiserFS doesn't make it go away. Plus
the fact that whatever it provides will be ideal for a few applications, a
bad fit (but livable) for many, and completely useless (or even plainly
counterproductive) for some. Yes, there are operating systems around that
don't have "files", everything is in a database. PHBs love them, the
people who develop for them or have to manage them hate them.

Again, operating systems with funny "just as applications require"
structured files were common until Unix came along with the simple "a file
is a sequence of bytes, do as you wish with it but in userland" and the lot
went away like a bad dream. Unix is about simple, generic infrastructure on
which you can build what /you/ want, not just what /the system/ allows.
Don't kill that.

> And even FUSE is higly demanded as you can see e.g. with the KIO-Slaves
> of KDE where the filesystem view is implemented even in a higher level
> (to my knowledge KIO only exists as KDE needed a solution that works
> right now and not after many flames and discussions about a system like
> FUSE).

> So I personally see FUSE and Reiser4 somewhat related and beeing objected by 
> some people at LKML beside implementational problems by the same reasons of 
> "traditional" thinking.

Funny. The "traditional" thinking was once radical, and swept away much of
what you advocate...

[...]

> Both ideas would be the killer feature of Linux desktops if used in 
> applications on larger scale.

Chicken and egg: Applications using strange filesystem semantics won't show
up until said semantics are commonplace, which won't be until there is
extensive use...

> So I wish you very much luck with getting this finally into the Linux 2.6
> main kernel as this software works right now

It hasn't been integrated exactly because it /doesn't/ work right.

>                                              and is needed right
> now.

Very few people have expressed any need for it.

>      There is always room for later tuning in which kernel layer a
> specific function has to be...

No. It has to be done right (or nearly right) from the start. Also,
screwing around with filesystems /is/ risky, as it could affect innocent
bystanding filesystems.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
