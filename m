Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312276AbSCTKfy>; Wed, 20 Mar 2002 05:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312275AbSCTKfo>; Wed, 20 Mar 2002 05:35:44 -0500
Received: from morrison.empeg.co.uk ([193.119.19.130]:43260 "EHLO
	fatboy.internal.empeg.com") by vger.kernel.org with ESMTP
	id <S312274AbSCTKfm>; Wed, 20 Mar 2002 05:35:42 -0500
Message-ID: <004901c1cffa$80567d50$2701230a@electronic>
From: "Peter Hartley" <pdh@utter.chaos.org.uk>
To: "Theodore Tso" <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <006701c1cf6d$d9701230$2701230a@electronic> <20020319191018.A23000@thunk.org>
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
Date: Wed, 20 Mar 2002 10:09:10 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Tue, Mar 19, 2002 at 05:45:24PM -0000, Peter Hartley wrote:
> >  * glibc knows nothing about the new unsigned limits, because
> >    it's compiled against 2.2 headers. So it clips the limit
> >    value to 0x7FFFFFFF to "correct" it before calling the
> >    setrlimit syscall. This is IMO still the Right Thing,
> >    because it's trying to call the old syscall as if to run
> >    a new program on a 2.2 kernel.
>
> Unfortunately, all of my testing was done under systems where the
> glibc was already compiled under 2.4 headers, so I didn't realize that
> glibc would try to be "helpful" and correct the limit used by rlimit.
> (In other words, the e2fsprogs workaround was only worked in the case
> where other programs were losing because they were using the 2.2
> kernel ABI, but the libc was using the 2.4 kernel ABI.  Sigh.)
>
> So obviously, the way I need to fix e2fsprogs is to fork a child
> process, check to see whether or not I can safely call setrlimit, and
> if not, exit without trying to set it.  :-( This is a really dirty
> hack, but I don't see any other way fixing user-land programs that are
> trying to work around this ABI mess.

I don't think you can tell whether it's safe to call setrlimit (unless you
mean having e2fsck call the *syscall* directly, which is icky). The
getrlimit in a 2.2-headered glibc returns 0x7FFFFFFF whether the kernel's
idea of the value is 0x7FFFFFFF or 0xFFFFFFFF. I still like Andreas Dilger's
idea that you only set the limit if it's not already RLIM_INFINITY as
returned by glibc.

If PAM, or something else, has already set the 0x7FFFFFFF value, there
appears to be no way of setting the 0xFFFFFFFF value via a 2.2-headered
glibc :-( and you'd need to go for the syscall :-((

        Peter


