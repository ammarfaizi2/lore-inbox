Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285209AbRLXSUM>; Mon, 24 Dec 2001 13:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285213AbRLXSUD>; Mon, 24 Dec 2001 13:20:03 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:59060 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S285209AbRLXSTu>; Mon, 24 Dec 2001 13:19:50 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Date: Mon, 24 Dec 2001 09:54:05 -0800 (PST)
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <3C277049.3070000@redhat.com>
Message-ID: <Pine.LNX.4.40.0112240951030.24605-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so this just means that an eye needs to be kept on the non-dynamic
syscalls  and up the starting point for dynamic syscalls significantly
before we run out of space for the non-dynamic ones.

running software that depends on features in a new kernel on a
significantly older kernel is always questionable, if you software really
needs to do that you need to watch for a bunch of things.

David Lang


On Mon, 24 Dec 2001, Doug Ledford wrote:

> Date: Mon, 24 Dec 2001 13:13:29 -0500
> From: Doug Ledford <dledford@redhat.com>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
>      Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
> Subject: Re: [patch] Assigning syscall numbers for testing
>
> David Lang wrote:
>
> > you miss the point, the syscall numbers will not nessasarily be consistant
> > from boot to boot so if your code does not check for them it's seriously
> > broken (and remember this is only for stuff in experimental status). The
> > hope is that most if not all of the real checking can end up being done in
> > glibc
>
>
> No, I'm not missing the point.  Try to follow with me here, this isn't
> rocket science.  *NOT* *ALL* *SOFTWARE* *IS* *OR* *WILL* *BE* *USING*
> *DYNAMIC* *SYSCALLS*.  Your scenario is fine if you want to convert all
> existing software to dynamic syscalls.  However, my scenario specifically
> dealt with software that *DOES* *NOT* use dynamic syscalls (and which
> doesn't need to because the syscalls it *does* use have been allocated).
>
> Since people are having such a hard time with this, let me spell it out in
> more detail.  Assume the following scenario:
>
> Linux 2.4.17 + dynamic syscall patch.  Dynamic syscalls start at 240.
>
> Linux 2.4.18 comes out, and now there are two *new* *official* *statically*
> *allocated* syscalls at 240 and 241 (they are SYSGETAMIBLKHEAD and
> SYSSETAMIBLKHEAD).
>
> A new piece of software (or an existing one, doesn't matter) is written to
> take advantage of the new syscalls.  It uses the *predefined* syscall
> numbers and is compiled against 2.4.18.  It relies upon -ENOSYS (as is
> typical for non-dynamic syscalls) to indicate if the kernel doesn't support
> the intended syscalls.
>
> Now, someone without realizing the implications of what's going on, runs
> this new program on a machine running the 2.4.17 + dynamic syscall patch.
>
> BOOM!
>
> So, to reiterate my points.  This *IS* *NOT* *SAFE* unless either A) the
> dynamic syscall number range is officially allocated *before* the patch goes
> into use to avoid these collisions later or B) you switch *all* software to
> using dynamic syscalls (which does have a performance impact on the software
> and which would also require lots of work).
>
>
> > David Lang
> >
> >
> >
> >  On Mon, 24 Dec 2001, Doug Ledford wrote:
> >
> >
> >>Date: Mon, 24 Dec 2001 12:06:19 -0500
> >>From: Doug Ledford <dledford@redhat.com>
> >>To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >>Cc: Keith Owens <kaos@ocs.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
> >>     linux-kernel@vger.kernel.org
> >>Subject: Re: [patch] Assigning syscall numbers for testing
> >>
> >>Alan Cox wrote:
> >>
> >>
> >>>>Well, I'm not going to mess with code, but here's the example.  Say you
> >>>>start at syscall 240 for dynamic registration.  Someone then submits a patch
> >>>>
> >>>>
> >>>The number you start at depends on the kernel you run.
> >>>
> >>>
> >>>
> >>>>modify the base of your patch, but if it has been accepted into any real
> >>>>kernels anywhere, then someone could inadvertently end up running a user
> >>>>space app compiled against Linus' new kernel and that uses the newly
> >>>>allocated syscalls 240 and 241.  If that's run on an older kernel with your
> >>>>
> >>>>
> >>>The code on execution will read the syscall numbers from procfs. It will
> >>>find new numbers and call those. Its a very simple implementation of lazy
> >>>binding. It only breaks if you actually run out of syscalls, and then it
> >>>fails safe.
> >>>
> >>>Alan
> >>>
> >>>
> >>>
> >>No it doesn't.  You are *assuming* that *all* code will check the lazy
> >>syscall bindings.  My example was about code using the predefined syscall
> >>number for new functions on an older kernel where those functions don't
> >>exist, but where they overlap with the older dynamic syscall numbers.  In
> >>short, the patch is safe for code that uses the lazy binding, but it can
> >>still overlap with future syscall numbers and code that doesn't use the lazy
> >>binding but instead uses predefined numbers.
> >>
> >>--
> >>
> >>  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
> >>       Please check my web site for aic7xxx updates/answers before
> >>                       e-mailing me about problems
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>
> >
>
>
>
> --
>
>   Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>        Please check my web site for aic7xxx updates/answers before
>                        e-mailing me about problems
>
