Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135580AbRDSHVG>; Thu, 19 Apr 2001 03:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135581AbRDSHU5>; Thu, 19 Apr 2001 03:20:57 -0400
Received: from [212.150.182.35] ([212.150.182.35]:36366 "EHLO
	exchange.guidelet.com") by vger.kernel.org with ESMTP
	id <S135580AbRDSHUo>; Thu, 19 Apr 2001 03:20:44 -0400
Message-ID: <023c01c0c8a9$a4bb9940$910201c0@zapper>
From: "Alon Ziv" <alonz@nolaviz.org>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Mike Kravetz" <mkravetz@sequent.com>,
        "Ulrich Drepper" <drepper@cygnus.com>,
        "Linus Torvalds" <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0104171200220.933-100000@penguin.transmeta.com> <m33db680h8.fsf@otr.mynet.cygnus.com>
Subject: Re: light weight user level semaphores
Date: Thu, 19 Apr 2001 10:20:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm...
I already started (long ago, and abandoned since due to lack of time :-( )
down another path; I'd like to resurrect it...

My lightweight-semaphores were actually even simpler in userspace:
* the userspace struct was just a signed count and a file handle.
* Uncontended case is exactly like Linus' version (i.e., down() is decl +
js, up() is incl()).
* The contention syscall was (in my implementation) an ioctl on the FH; the
FH was a special one, from a private syscall (although with the new VFS I'd
have written it as just another specialized FS, or even referred into the
SysVsem FS).

So, there is no chance for user corruption of kernel data (as it just ain't
there...); and the contended-case cost is probably equivalent (VFS cost vs.
validation).

Hope I inspired someone...

    -az

----- Original Message -----
From: "Ulrich Drepper" <drepper@redhat.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Mike Kravetz" <mkravetz@sequent.com>; "Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Wednesday, April 18, 2001 21:35
Subject: Re: light weight user level semaphores


> Linus Torvalds <torvalds@transmeta.com> writes:
>
> Sounds good so far.  Some comments.
>
> >  - FS_create is responsible for allocating a shared memory region
> >    at "FS_create()" time.
>
> This is not so great.  The POSIX shared semaphores require that an
> pthread_mutex_t object placed in a shared memory region can be
> initialized to work across process boundaries.  I.e., the FS_create
> function would actually be FS_init.  There is no problem with the
> kernel or the helper code at user level allocating more storage (for
> the waitlist of whatever) but it must not be necessary for the user to
> know about them and place them in share memory themselves.
>
> The situation for non-shared (i.e. intra-process) semaphores are
> easier.  What I didn't understand is your remark about fork.  The
> semaphores should be cloned.  Unless the shared flag is set there
> should be no sharing among processes.
>
>
> The rest seems OK.  Thanks,
>
> --
> ---------------.                          ,-.   1325 Chesapeake Terrace
> Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
> Red Hat          `--' drepper at redhat.com   `------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

