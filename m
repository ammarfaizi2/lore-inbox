Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbTETSz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbTETSz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:55:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5731 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263872AbTETSz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:55:26 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>
	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	<babhik$sbd$1@cesium.transmeta.com>
	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>
	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>
	<1053392095.21582.48.camel@imladris.demon.co.uk>
	<3EC9803F.6010701@zytor.com> <m1of1y15v1.fsf@frodo.biederman.org>
	<3EC9D823.5020400@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 May 2003 13:04:23 -0600
In-Reply-To: <3EC9D823.5020400@zytor.com>
Message-ID: <m1k7cl1lu0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > Ugh.  I now see both sides of this.
> > ABI changes always require writing new code to take advantage
> > of it but that code does not need to live in libc.  And libc is expected
> > to have the definitions necessary to compile the new code.
> >
> 
> Bingo.

Several more little more points.

In general this only affects applications that are tied tightly to
the kernel.

What the applications want is a kernel abi specification repository,
which glibc is not, at least in a timely fashion, and it is not the
emphasis of any libc so it is quite likely to be neglected.

So for applications today that cannot wait for the code to be
incorporated into glibc the only reasonable advice is to include
their own header files (that do not conflict with libc header files),
for the ioctls and definitions they need.  This is a maintainable if
not beautiful strategy.


> >>I maintain the proposal I have given before:
> >>
> >><linux/abi/*.h> as the header file namespace;
> > What about <linux-abi/*.h>
> >
> >><linux/*.h> <asm/*.h> namespaces reserved for compatibility (once the
> >>migration is complete these are owned by the libc)
> > I think removing the abi namespace totally from the legacy directories
> > helps this to a small extent.
> >
> 
> It might, but the <linux/abi/*.h> namespace hasn't been used, so it isn't really
> 
> legacy in the sense that you can have a possible conflict. Having said that,
> <linuxabi/*.h> is the least bleacherous nonlegacy alternative I've seen (I'd
> like to skip the dash, though.)  <abi/*.h> is already taken.

No problem with skipping the dash.  In general I would like to be able
to: ``rm -rf /usr/include/linux/ /usr/include/asm/'' and then compile 
applications.   This is not something I would recommend in a
production system any time soon but it would help in cruft detection.

> >>Types use the __kernel_* namespace *only*; structures use struct __kernel_*.
> >>
> >>Some form of export of the expected syscall ABI as well as syscall
> >>numbering.
> > Prototypes for everything including ioctls.
> >
> 
> Absolutely.  As I said in another post, if this is done correctly, a whole bunch
> of the ABI compatbility stuff like the 32-on-64 things should be possible to
> generate automatically.  If that isn't true, it's done wrong.
> 
> >>
> >>A bigger issue is if this really should be done in C.  A worthwhile
> >>thought: if this is done correctly then most or all of the 64/32 compat
> >>code (or any other arch1-on-arch2 compatibility) should be able to be
> >>automatically generated.  If not, it almost certainly isn't done
> >>correctly...
> > Potentially.  Certain things like type conversions may be a non-trivial
> > exercise.  It is certainly true that it should be possible to build
> > the entire decoding logic for strace.  Even in the mixed architecture
> > cases.
> > For cases that are hard to automate see: sys_old_mmap vs. sys_mmap2,
> > on x86.  Potentially it can be done but it requires a powerful stub
> > generator.
> >
> 
> That one is somewhat tricky, and probably needs some ad hoc code. However, you
> get a long way toward the goal if you can express the following:

My basic point with respect to arch-on-arch compatibility is that
sys_mmap -> sys_mmap2 (where they both take an off32_t argument) is
classic case of the arch on arch compatibility.

The case is actually more interesting because sys_mmap2 uses
a 4K aligned offset.  Instead of a byte aligned offset.  Which
makes sys_mmap64 unnecessary for the time being.

But I am certainly for it where the work can be done easily.

A more interesting possibility to me at least is network transparency.

> >>>If Linus would approve a strategy for rearranging the headers such that
> >>>people can work on it without suspecting that they're just wasting their
> >>>time, I think it could get done for 2.6.
> >>>
> >>>It's not the kind of thing you do in private and present as a fait
> >>>accomplis -- if it isn't quite right, you end up having to do the whole
> >>>thing from scratch, afaict.
> >>
> >>Agreed.
> > If it is done purely as headers certainly.  For a header generator it
> > might be something you can get away with.  Because the core repository
> > would not need to change just the world useable form.  This may
> > be the one good argument for doing this in something other than C.
> >
> 
> On the other hand, Linus just released "sparse", which is a pretty nice C parser
> that might be useful for this, especially with some kind of custom annotation
> capability.  I talked to him about this a while ago, actually.


Against doing this in C there are 3 arguments.
1) C may not be precise enough.
2) C may not contain enough information.
3) Reorganization by an automated tool may not be possible.

I don't know for certain that the ability to reorganize the generated
interfaces from original source is important.  A good design may
make this a non-issue.  But it may help prototyping so I mention it.

I suspect a good implementation of this would resemble to the CORBA
IDL.  A relative of C but with different restrictions.

Another very quite piece of the puzzle is how to include in the in
kernel DSO.

Eric
