Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSKJBZi>; Sat, 9 Nov 2002 20:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSKJBZi>; Sat, 9 Nov 2002 20:25:38 -0500
Received: from almesberger.net ([63.105.73.239]:21771 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262875AbSKJBZh>; Sat, 9 Nov 2002 20:25:37 -0500
Date: Sat, 9 Nov 2002 22:31:42 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
Message-ID: <20021109223142.A31205@almesberger.net>
References: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com> <m1u1iqcpjg.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u1iqcpjg.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 09, 2002 at 04:05:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>    - Extra care must be taken so what broke the first kernel does
>      not break this one, and so that the shards of the old kernel
>      do not break it.

For this, you should checksum the data that you've pre-loaded, and
verify it before rebooting. If the pre-loaded kernel has been hit,
you just do a normal reboot. (In the case if a bzImage, you'd
probably fail uncompression anyway.)

Alternatively, you could also wire this into the uncompression
functions (i.e. reboot if bzImage or initrd don't uncompress
cleanly), but this would be more intrusive.

>    - Care must be taken so that loading the second kernel does not
>      erase valuable data that is desirable to place in a crash dump.

Or copy all "interesting" memory to a safe place before the kexec.
I don't quite like the idea of building a kernel that "knows" which
addresses it isn't supposed to touch, and I think being able to use
the same kernel binary for regular and panic use would be a
desirable feature.

Also, firmware may not give you the choice of preserving all memory,
so you need that "copy memory to a safe place" functionality anyway.
Furthermore, you most likely want to checksum that memory, too.

But ... I think you're designing too far ahead. The "load kernel on
panic" part isn't trivial, and I think it would be better to tackle
this in a second phase. For now, having a reasonably generic kexec
mechanism would be all that's needed in term of building blocks.

> Method 2 (For people with read only roots):
> - /sbin/delayed_kexec /path/to/new/kernel 
> - Read in the /path/to/new/kernel into anonymous pages

There's no delayed_kexec in kexec-tools 1.4, so let me gues how
this would work: as far as I know, there's no way for regular
user space to create a persistent unreferenced memory object, so
you'd probably load the data, perhaps mlock the pages, and then
fork a process that keeps the data in memory. Then, this process
would probably call sys_kexec upon reception of a signal, or
such.

Unfortunately, init assumes that it can SIGKILL all non-init
processes (that is, all processes with PID != 1). Worse yet, this
assumption makes sense, because walking the process list and
killing each of them individually would be racy.

So you'd either have to add this race condition to init, add some
magic to make this type of killing atomic, teach the kernel that
your kexec memory keeper process is somehow magic too, or merge
kexec into init. Not nice.

> I then use the following algorithm to sort the potential mess out
> before I jump to the new code.

I like this approach. It gives you complete freedom of where to
load data. This also makes it future-proof. But I don't see the
reason why you couldn't do the same thing with vmalloc. Using
vmalloc may actually simplify your code a little.

> Having had time to digest the idea of starting a new kernel on panic
> I can now make some observations and what I believe it would take to
> make it as robust as possible.

That pretty much sums it up, yes. But as I've said, this isn't
really something that needs to be implemented at the same time
as the basic kexec functionality. A two-phase kexec with
unrestricted copying capabilities should be a good enough
building block that only minor changes, if any, would be needed
when adding kexec-on-panic.

> And now I go back to the silly exercise of factoring my code so the
> new kernel can be kept in locked kernel memory, instead of in a file
> while the shutdown scripts are run.

Not silly :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
