Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbSJQMH7>; Thu, 17 Oct 2002 08:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSJQMG6>; Thu, 17 Oct 2002 08:06:58 -0400
Received: from thunk.org ([140.239.227.29]:29650 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261520AbSJQMGd>;
	Thu, 17 Oct 2002 08:06:33 -0400
Date: Thu, 17 Oct 2002 08:12:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
Message-ID: <20021017121213.GA13573@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <agruen@suse.de>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	linux-kernel@vger.kernel.org
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at> <20021017032619.GA11954@think.thunk.org> <874rblcpw5.fsf@goat.bogus.local> <200210171302.25413.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210171302.25413.agruen@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:02:25PM +0200, Andreas Gruenbacher wrote:
> Filesystem capabilities move complexity out of applications into the
> file system (=system configuration), so the admins have to deal with
> an additional task.
> 
> From a security point of view suid root applications that are
> dropping capabilities voluntarily aren't much different from plain
> old suid root apps; there may still be exploitable bugs before the
> code that drops capabilities (which doesn't mean that apps shouldn't
> drop capabilities). With capabilities the kernel ensures that
> applications cannot exceed their capabilities.

If developers drop capabilities they don't need as the very first
thing that the program does --- i.e., the first statement in main()
--- then it's done once, and it's no longer a configuration issue.
This is also better because the developer generally has a much better
idea what capabilities are needed by his/her program --- as compared
to having every single individual administrator have make this
determination by his or herself.

As far as bugs which might be there before the application drops root,
this is largely dealt with by dropping the capabilities as the very
first thing in main().  Now, you may say, what if the application
needs to do some processing work as root before they can drop some of
the capabilities?  Well, in that case, if you have a buffer overrun or
other bug which might be exploitable before the capabilities are
dropped, even in a full capability system, the program is still
vulnerable in exactly the same way.

The one thing which you can't do by simply dropping the max effective
and current capabilities in a setuid root application, is to set a max
inheritable capability mask.  That is, you do need to be more careful
if you have some number of capabilities raised, that they be
appropriately filtered or dropped before you exec another program.
But everything else can be done by dropping all the privileges you
don't need as the first thing in main.

> > So you claim, system administrators are stupid people?

Each additional thing which the system administrator has to do, is an
additional thing that he/she can *get* *wrong*.  System administators
aren't stupid, just over-loaded, and often asked to administer
something that's too complicated.

Millions and millions of knobs and dials are not necessarily a good
thing.  If there is basically only one correct answer for how the
knobs can be set up, sure, you can have a complex database for
applications to determine what sort of capability masks they should
have, and you can run that database against your database every night
(otherwise, you might miss someone quietly modifying one or two
capability masks to leave him/herself a back door).  

But why go through all that effort?  It may be a lot simpler to have
the application drop capabilities in main(), and then the standard MD5
integrity scan of your executable will do the job for you.  Yes, it's
not perfect; but it's a heck of a lot easier to maintain.

Finally, it should also be noted that in order to get the full effect
of a capabilities system, you need to very tightly restrict the
inheritability capmask of all executables in the system.  That is, if
/bin/cp isn't allowed to inherit the DAC override capability, then you
don't have to worry about a buffer overrun of a privileged executable
from calling /bin/cp to overwrite some critical system configuration
file.  But by the same token, that means that a someone executing
/bin/cp from a root shell (or a root shell script) will also not be
able to override DAC.  This is generally considered to be
unacceptable, so very often, most binaries in the system are given a
very high inheritable capmask, so that they can still be used with
privileges from a root shell.  But as soon as you do that, you've
removed most of the advantages of a full-fledged capability system
over simply dropping capabilities in main().

So yes, a properly managed capability system can be more secure than
simpler alternatives.  But it's a bear to manage, and would require
new userspace tools (which the administrator will probably not be
familiar, and at least initially would be far more immature than the
current standbys).  Worst of all, in its fully secured form, is
extremely inconvenient for system administrators running out of a root
shell.  (Basically, it no longer feels like Unix system
administration, but more like VMS system administration.)  If you
don't do all of these things, a full-fledged capabilities system can
be much, much LESS secure.

						- Ted
