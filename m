Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSKJDnh>; Sat, 9 Nov 2002 22:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSKJDnh>; Sat, 9 Nov 2002 22:43:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263279AbSKJDng>; Sat, 9 Nov 2002 22:43:36 -0500
Date: Sat, 9 Nov 2002 19:49:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Werner Almesberger <wa@almesberger.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <m17kfmce6c.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0211091927350.2336-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Nov 2002, Eric W. Biederman wrote:
> 
> What I was thinking is that the process would for and exec
> something like "/etc/rc 6" or maybe "/etc/rc 7" to be clean.
> And that script would do all of the user space shutdown.
> 
> No need to mlock any pages, or hack init, or special hacks.
> Just user space cleanly shutting itself down.

Ehh.. You do realize that the above doesn't actually _work_?

First off, "all the user space shutdown" includes things like turning off 
networking. Oh, and if you're on a NFS-root system, your process is now 
officially _toast_.

Unless you do the "mlockall()" etc that you seem to think that you don't 
need, that is.

In other words: oh, yes, you do need those mlock() calls.

And never mind the fact that everybody has a slightly different "init" 
setup, so executing "/etc/rc 6" may not actually _do_ anything. So now you 
need to learn about all the different initscripts, and get that right. 

And btw, thanks to the mlockall() requirements, you actually end up
pinning more memory than the two-phase approach ever would have done while 
you do all this.

You then need to do the pre-loading anyway for the "kexec-on-panic" case
that you think is so different (I don't understand why you think a reboot
is different from another reboot, but whatever). So now you not only
maintain something that knows about many different init scripts and uses
more memory, it also ends up doing the same reboot thing at least two
different ways.

  -- meanwhile, in another universe --

With the two-way separation, you don't have any of these problems. Your
maintenance nightmare has now become _one_ added script:

	/etc/rc.d/rc6.d/K00loadkernel

and people using other init script variants can trivially add a script to
match their setup. Done. No maintenance headache, no special init
binaries, no torn-out-hair.

And by adding a startup script, you can have a _different_ small "debug
dump" kernel loaded early, so that if the machine reboots without going
through the controlled sequence, it will automatically boot into that
debug kernel..

			Linus

