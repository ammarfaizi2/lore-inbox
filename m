Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSKFEZ3>; Tue, 5 Nov 2002 23:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265646AbSKFEZ3>; Tue, 5 Nov 2002 23:25:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9539 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265643AbSKFEZ2>; Tue, 5 Nov 2002 23:25:28 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	<3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net>
	<20021105171230.A11443@in.ibm.com>
	<20021105150048.H1408@almesberger.net>
	<1036521360.5012.116.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Nov 2002 21:29:36 -0700
In-Reply-To: <1036521360.5012.116.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1d6pjfhhr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Tue, 2002-11-05 at 18:00, Werner Almesberger wrote:
> > Yes, I've just checked with Eric, and he hasn't received any
> > indication from Linus so far. I posted a reminder to linux-kernel.
> > I'd really hate to see kexec miss 2.6.
> 
> Let me ask the same dumb question - what does kexec need that a dumper
> doesn't. In other words given reboot/trap hooks can kexec happily live
> as a standalone module ?

In replying to another post by Al Viro I managed to think this through.
kexec needs:

- An allocated slot in some namespace.
- The ability to request the kernel devices shut themselves down.
- Buffers that are safe to use.
- The ability to transition the cpu into a state that is suitable
  for jumping to another kernel.
- Awareness of it's existence.

Most of this code is intimate with how the kernel currently behaves
and needs at least minor adjustments for things like living in PAE
mode.

The safe buffers a kernel can probably avoid.

I cannot see the core functionality of kexec every living happily as a
standalone module.  The kexec code accomplishes nothing.  If there is
something useful it does it can probably be moved elsewhere and the
line count reduced.  The entire code base is basically obsessed with
getting safe temporary buffers for the new kernel to live in, and
given improvements to how the kernel allocates memory that are
theoretically possible with rmap I could remove that code as well.

The only thing that keeps kexec at all maintainable outside the kernel
is that big fundamental changes do not happen often.  But the kernel
must be tracked, closely.  I don't see that as a recipe for a
standalone module.  I can barely even see making the code a module, or
what the point would be.

The reason kmonte fails in so many cases where kexec succeeds is
precisely because kmonte is a module.

If we include machine_kexec or something very similar to but more
generalized to the list of exported functions, perhaps kexec could
just have the buffer allocation code and live happily outside of the
kernel.  But as it is, if we want to factor kexec into pieces so one
piece can live happily as a standalone module it will take some
serious design work, and a total rethink of the implementation.  And
we will still have to add code to the kernel.

Eric
