Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDBPv>; Fri, 3 Nov 2000 20:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDBPm>; Fri, 3 Nov 2000 20:15:42 -0500
Received: from mta05.mail.au.uu.net ([203.2.192.85]:30640 "EHLO
	mta05.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S129033AbQKDBP2>; Fri, 3 Nov 2000 20:15:28 -0500
Message-ID: <3A0362BD.D6068EDE@valinux.com>
Date: Sat, 04 Nov 2000 12:13:33 +1100
From: Gareth Hughes <gareth@valinux.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, dledford@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: SETFPXREGS fix
In-Reply-To: <20001103174105.C857@athlon.random> <3A034F28.5DB994F4@valinux.com> <20001104020709.D32767@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sat, Nov 04, 2000 at 10:50:00AM +1100, Gareth Hughes wrote:
> >       if ( HAVE_FXSR ) {
> >               if ( __copy_from_user( &tsk->thread.i387.fxsave, (void *)buf,
> >                                       sizeof(struct user_fxsr_struct) ) )
> >                       return -EFAULT;
> >               /* bit 6 and 31-16 must be zero for security reasons */
> >               tsk->thread.i387.fxsave.mxcsr &= 0x0000ffbf;
> >               return 0;
> >       }
> 
> The above doesn't fix the security problem. Put the last byte of the userspace
> structure on an unmapped page and it will return -EFAULT lefting the invalid
> mxcsr value that will corrupt the FPU again.
> 
> The right version of the above is just in linux mailbox.
> 
> The reason I did it more complex at first is because I wanted to go safe,
> I wasn't sure if somebody could SIGCONT the traced task while we was copying
> the data so introducing a race where it was still possible to exploit
> the bug; but as Linus pointed out to me the loop in do_signal prevents that, so
> we can do only one large copy and then fixup (fixing up also in the -EFAULT
> case of course).

Yes, we can certainly mask out the mxcsr value in both cases.  I just
think this makes the code a lot simpler and cleaner as a result - three
partial copies seems over the top.

-- Gareth
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
