Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275527AbRJFTQm>; Sat, 6 Oct 2001 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275567AbRJFTQd>; Sat, 6 Oct 2001 15:16:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7735 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S275527AbRJFTQZ>; Sat, 6 Oct 2001 15:16:25 -0400
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
In-Reply-To: <Pine.LNX.4.30.0110051345450.30494-100000@waste.org>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 06 Oct 2001 13:05:34 -0600
In-Reply-To: <Pine.LNX.4.30.0110051345450.30494-100000@waste.org>
Message-ID: <m1hetcy4g1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> writes:

> On Fri, 5 Oct 2001, Linus Torvalds wrote:
> 
> > On Fri, 5 Oct 2001, Horst von Brand wrote:
> >
> > > Linus Torvalds <torvalds@transmeta.com> said:
> > > > On 5 Oct 2001, Eric W. Biederman wrote:
> > >
> > > [...]
> > >
> > > > > Currently checking to see if the file is executable looks good
> > > > > enough.
> > > >
> > > > [ executable by the user in question, not just anybody ]
> > > >
> > > > Yes, I suspect it is.
> > >
> > > Who is "user in question"? It is quite legal (if strange) to have a file
> > > user A can modify, but not execute, while B can execute it.
> >
> > The "user in question" being the one that actually does the
> > mmap(MAP_DENYWRITE). If _he_ can execute the file, that would be
> > reason enough to think that he can deny others from writing to it while he
> > has it mapped..
> 
> This violates principle of least surprise. It _should_ be harmless for an
> admin to mark /var/log/utmp +x, yes? Stupid, but harmless. Now suppose it
> lives on VFAT...

Right now with some care you can theoretically still trigger the
/var/log/utmp DOS attack if the file is executable.  First you
trick binfmt_misc into thinking it is an executable.  Then you execute
it and immediately send it SIGSTOP before it exits.  So marking
/var/log/utmp +x is not harmless.

What user space is really asking in this case is that the principle of
least suprise isn't violated with their shared library.  With that
in mind it for the first implementation I will also check to make
certain that at the time of mmap no one can open the file for write,
in addition to the file being executable.

It may be reasonable to remove that check at a future time.  But it
doesn't remove the usefulness, and it trivially protects against
logfile DOS attacks.  

In a system that only has MAP_PRIVATE and not MAP_COPY your
executables and shared libraries should really be read only anyway to
prevent a spontaneous change.

Eric

