Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbTCJHTt>; Mon, 10 Mar 2003 02:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbTCJHTt>; Mon, 10 Mar 2003 02:19:49 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:37476 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S262291AbTCJHTs>; Mon, 10 Mar 2003 02:19:48 -0500
Date: Mon, 10 Mar 2003 08:22:25 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>
Subject: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <32835.4.64.238.61.1047269795.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.30.0303100723300.2790-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Mar 2003, Randy.Dunlap wrote:
> > On Sat, 8 Mar 2003, Szakacsits Szabolcs wrote:
> >>
> >>  EFLAGS: 00010282
> >>  eax: f6c0f080   ebx: 0000416d   ecx: 00010282 edx: f6c0f0f8
> >>  esi: c040b078   edi: f6c0f0f8   ebp: f6dd1dbc esp: f6dd1db4
> >>  ds: 007b   es: 007b   ss: 0068
> >>
> >>  3c0:       b9 06 00 00 00          mov    $0x6,%ecx
> >>  ... not important ...
> >>  3cc:       89 d7                   mov    %edx,%edi
> >>  3ce:       89 55 f4                mov    %edx,0xfffffff4(%ebp)
> >>  3d1:       f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
> >>  3d3:       8d 50 78                lea    0x78(%eax),%edx
> >>  3d6:       8b 4d f4                mov    0xfffffff4(%ebp),%ecx
> >>  3d9:       89 51 18                mov    %edx,0x18(%ecx)  ## OOPS ##
> >>
> >> So %ecx should be %edi-24 = f6c0f0e0, instead it's EFLAGS. Oops [indeed].
> >> %ebp value is correct, I checked. So it seems a hardware, strong radiation
> >> or an interrupt that didn't restore ecx.
> >
> > Actually the "interrupt" did a pushfl and overwrote 0xfffffff4(%ebp). esp =
> > 0xfffffff4(%ebp).

Actually 0xfffffff4(%ebp) = %esp - 4.

> Should I just close this bugzilla entry as invalid or not an NTFS problem?
> I don't mind doing that.

It's very valid and personally think it's serious kernel wide issue. I
grepped recent linux-kernel oopses for this type of bug and seems to
be several hits, e.g. search for handling faults around EFLAGS.

The question is if we want to support the buggy 2.9[56] compilers or
not. I checked Red Hat 7.3 and the latest errata gcc fixes this issue,
the generated code is ok. But your complier didn't and probably many
more out there don't.

At least spinlock debugging triggers this bad code generation in the
widely used init_waitqueue_head() but quite probably there are others.
AFAIK fomit-frame-pointer was used earlier to workaround this but
apparently not anymore, so the bug came back. Maybe the new kernel
build broke it or it was just forgotten or it's a new policy not
supporting broken compilers, etc. I don't know.

But something should be done about it, IMHO.

	Szaka

