Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132311AbQKDBHt>; Fri, 3 Nov 2000 20:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132284AbQKDBHj>; Fri, 3 Nov 2000 20:07:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32548 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131880AbQKDBH2>; Fri, 3 Nov 2000 20:07:28 -0500
Date: Sat, 4 Nov 2000 02:07:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gareth Hughes <gareth@valinux.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, dledford@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: SETFPXREGS fix
Message-ID: <20001104020709.D32767@athlon.random>
In-Reply-To: <20001103174105.C857@athlon.random> <3A034F28.5DB994F4@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A034F28.5DB994F4@valinux.com>; from gareth@valinux.com on Sat, Nov 04, 2000 at 10:50:00AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 10:50:00AM +1100, Gareth Hughes wrote:
> 	if ( HAVE_FXSR ) {
> 		if ( __copy_from_user( &tsk->thread.i387.fxsave, (void *)buf,
> 					sizeof(struct user_fxsr_struct) ) )
> 			return -EFAULT;
> 		/* bit 6 and 31-16 must be zero for security reasons */
> 		tsk->thread.i387.fxsave.mxcsr &= 0x0000ffbf;
> 		return 0;
> 	}

The above doesn't fix the security problem. Put the last byte of the userspace
structure on an unmapped page and it will return -EFAULT lefting the invalid
mxcsr value that will corrupt the FPU again.

The right version of the above is just in linux mailbox.

The reason I did it more complex at first is because I wanted to go safe,
I wasn't sure if somebody could SIGCONT the traced task while we was copying
the data so introducing a race where it was still possible to exploit
the bug; but as Linus pointed out to me the loop in do_signal prevents that, so
we can do only one large copy and then fixup (fixing up also in the -EFAULT
case of course).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
