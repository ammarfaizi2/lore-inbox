Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSKJDGw>; Sat, 9 Nov 2002 22:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSKJDGv>; Sat, 9 Nov 2002 22:06:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24392 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263228AbSKJDGt>; Sat, 9 Nov 2002 22:06:49 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com>
	<m1u1iqcpjg.fsf@frodo.biederman.org>
	<20021109223142.A31205@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 20:10:51 -0700
In-Reply-To: <20021109223142.A31205@almesberger.net>
Message-ID: <m17kfmce6c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:
> 
> But ... I think you're designing too far ahead. The "load kernel on
> panic" part isn't trivial, and I think it would be better to tackle
> this in a second phase. For now, having a reasonably generic kexec
> mechanism would be all that's needed in term of building blocks.

I'm not designing yet, just looking and what I see says that it
does not very much resemble the non panic case.
 
> > Method 2 (For people with read only roots):
> > - /sbin/delayed_kexec /path/to/new/kernel 
> > - Read in the /path/to/new/kernel into anonymous pages
> 
> There's no delayed_kexec in kexec-tools 1.4, so let me gues how
> this would work: as far as I know, there's no way for regular
> user space to create a persistent unreferenced memory object, so
> you'd probably load the data, perhaps mlock the pages, and then
> fork a process that keeps the data in memory. Then, this process
> would probably call sys_kexec upon reception of a signal, or
> such.

What I was thinking is that the process would for and exec
something like "/etc/rc 6" or maybe "/etc/rc 7" to be clean.
And that script would do all of the user space shutdown.

No need to mlock any pages, or hack init, or special hacks.
Just user space cleanly shutting itself down.

> 
> > I then use the following algorithm to sort the potential mess out
> > before I jump to the new code.
> 
> I like this approach. It gives you complete freedom of where to
> load data. This also makes it future-proof. But I don't see the
> reason why you couldn't do the same thing with vmalloc. Using
> vmalloc may actually simplify your code a little.

Mostly it's a bird in the hand versus a bird in the bush.  I simply
see nowhere that vmalloc makes my code simpler.

> > Having had time to digest the idea of starting a new kernel on panic
> > I can now make some observations and what I believe it would take to
> > make it as robust as possible.
> 
> That pretty much sums it up, yes. But as I've said, this isn't
> really something that needs to be implemented at the same time
> as the basic kexec functionality. A two-phase kexec with
> unrestricted copying capabilities should be a good enough
> building block that only minor changes, if any, would be needed
> when adding kexec-on-panic.

My feel is that kexec-on-panic is a rather different problem.  Which
is why I thought it all through, to see if they felt close.  At the
very least you almost need to know that it is the same.

> 
> > And now I go back to the silly exercise of factoring my code so the
> > new kernel can be kept in locked kernel memory, instead of in a file
> > while the shutdown scripts are run.
> 
> Not silly :-)

Except for the part about getting Linus to accept it I don't see
the advantage.  kexec-on-panic looks different enough that I don't
think it will help at all with that case.

Eric
