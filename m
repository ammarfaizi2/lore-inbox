Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTA0SWH>; Mon, 27 Jan 2003 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTA0SWH>; Mon, 27 Jan 2003 13:22:07 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:35276 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267265AbTA0SWC>; Mon, 27 Jan 2003 13:22:02 -0500
Date: Mon, 27 Jan 2003 12:31:07 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Joel Becker <Joel.Becker@oracle.com>
cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
In-Reply-To: <20030127175917.GO20972@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0301271208580.18686-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Joel Becker wrote:

> On Sun, Jan 26, 2003 at 03:46:30PM -0600, Kai Germaschewski wrote:
> > it have added -DKBUILD_BASENAME and -DKBUILD_MODNAME, which are required 
> > by the new module code. And, how did they avoid subtle breakage like not 
> > giving the same switches on the command line? (This list goes on...)
> 
> 	As opposed to the kernel forcing subtle breakage by specifying
> options that break said module?  Don't say that doesn't happen (just
> like the kernel has to add/remove compiler switches to make some of its
> code work).

Well, if you're doing things in your module which break with the command 
line options the rest of the kernel is using, I'd claim you're playing 
tricks in your module which you shouldn't. The only place I'm aware of 
where someone really needs to change the options is kernel/sched.c, and 
that's a very internal part of the kernel, an area which surely shouldn't 
be touched by an external module. (Of course mere adding of -I -Dmacro 
happens quite a bit, you can do that for your module as you like)

> > Okay, you have a point here, there's still a bug. vermagic.o will be 
> > rebuilt when the version changes or any of the recorded config options 
> > change, but it doesn't pick up changes in the compiler version, if the 
> > new gcc has the same name.
> 
> 	IOW, you not only need a kernel source tree (built, no less,
> taking up space) but it needs to be writable!

Basically, yes. The build process needs to be able to write, e.g. to 
compile its helper code in scripts/, so init/vermagic.o is just another
file being written.

I guess you'll hate me even more with CONFIG_MODVERSIONING coming back
soon. Because that means that we need to generate the versions checksum
from all the kernel objects, and we need to write the somewhere, too. In
fact, these checksums are generated as part of the compiled objects, so
recording checksums needs all other compiled objects to be around. If you 
know a sensible way to get around this limitation, I'd be happy to hear 
it, but I fear there isn't.

So it boils down to the fact that we need a full writeable kernel tree. I 
agree that this is asking a lot, and I'm sure open for suggestions. The 
writeable part can and will be lifted using separate object directories, 
which means that the source can remain read-only and you can specify your 
own writeable object tree.

> > o One thing I do not understand at all: What is the problem with using
> >   the internal build system? It makes maintainance of external modules
> >   much easier than keeping track of what happens in the kernel and
> >   patching a private solution all the time.
> 
> 	Well, the Red Hat kernel tree is designed to allow you to build
> against there UP, SMP, and large memory kernels from one tree.  In your
> example, you require three(!) fully built kernel trees lying around, each
> with a different configuration.  That's a lot of space.

As I said, I am sure interested in working with people and distros to get 
something which everybody can live with. I'm wondering how RedHat manages 
to have one tree for different configurations, since in that case, at 
least .config/autoconf.h, EXTRAVERSION and the module version files 
(*.ver) need to differ, so that kinda seems not possible in one 
(read-only) tree.

Generally, you need to have the configured source around for the kernel 
you want to build the module against. If that's three kernels, you need 
the source three times. (Or, of course, you reconfigure it between the 
builds)

> 	Granted, Red Hat (as our example) can do what they have to do,
> since the generic kernel isn't responsible for whatever Red Hat does.
> However, even without their setup, in 2.4 all I have to do is keep
> around version.h and autoconf.h and I can usually do the right thing
> with one completely clean kernel tree.

And that's with module versioning?

--Kai


