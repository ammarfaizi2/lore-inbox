Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSJRN7S>; Fri, 18 Oct 2002 09:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSJRN7S>; Fri, 18 Oct 2002 09:59:18 -0400
Received: from mail.powweb.com ([63.251.213.34]:65248 "EHLO mail.powweb.com")
	by vger.kernel.org with ESMTP id <S265092AbSJRN7R> convert rfc822-to-8bit;
	Fri, 18 Oct 2002 09:59:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <markgross@thegnar.org>
Organization: thegnar
To: phil-list@redhat.com, Daniel Jacobowitz <dan@debian.org>,
       Mark Kettenis <kettenis@gnu.org>, mgross <mgross@unix-os.sc.intel.com>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Date: Fri, 18 Oct 2002 07:03:20 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org,
       NPT library mailing list <phil-list@redhat.com>
References: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <20021018004847.GA27817@nevyn.them.org> <200210180657.38291.mark@thegnar.org>
In-Reply-To: <200210180657.38291.mark@thegnar.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210180703.20497.markgross@thegnar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I fixed it to set namesz to 5, with the +1 it was making it 6.  My
patch is supposed to remove the +1.

The value for men-name for the extended registers case is "LINUX".

--mgross

> On Thursday 17 October 2002 05:48 pm, Daniel Jacobowitz wrote:
> > You'd have to ask Mark Kettenis about that.  Mark, it looks like you
> > updated the kernel to write namesz == 6, but BFD still expects 5 (and
> > elfcore_write_note writes 6)?  Shouldn't we accept both, anyway?
> >
> > On Thu, Oct 17, 2002 at 05:07:41PM -0400, mgross wrote:
> > > This patch is working pretty well for me with only one problem, which
> > > seems to have happened indepently of Ingo's patch.
> > >
> > > Extended floating point note sections are no longer getting recognized
> > > by GDB 5.x.
> > >
> > > After a bit of poking around in the GDB 5.2.1 code (line 6399
> > > bfd/efl.c) I noticed that there is a n_namesz test for the reg-xfp
> > > section parsing.
> > >
> > > The following minor tweak on top of Ingo's patch  to binfmt_elf.c fixes
> > > the problem.
> > >
> > > diff -urN -X dontdiff linux-2.5.43/fs/binfmt_elf.c
> > > linux-2.5.43.xfp/fs/binfmt_elf.c
> > > --- linux-2.5.43/fs/binfmt_elf.c      Thu Oct 17 16:54:13 2002
> > > +++ linux-2.5.43.xfp/fs/binfmt_elf.c  Thu Oct 17 16:53:00 2002
> > > @@ -964,7 +964,9 @@
> > >  {
> > >       struct elf_note en;
> > >
> > > -     en.n_namesz = strlen(men->name) + 1;
> > > +     en.n_namesz = strlen(men->name);
> > > +     /* en.n_namesz = strlen(men->name) + 1;  gdb checks namez and the
> > > + 1 */ +                                     /*breaks xfp core file
> > > note sections. */ en.n_descsz = men->datasz;
> > >       en.n_type = men->type;
> > >
> > >
> > >
> > > I don't know when this +1 was added to writenote binfmt_elf.c or why. 
> > > I do know that newer than July and it isn't in 2.4
> > >
> > > If there the + 1 is needed of others then we may need to special case
> > > the NT_PRXFPREG note sections.
> > >
> > > --mgross

