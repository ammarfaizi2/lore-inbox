Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKCXwP>; Fri, 3 Nov 2000 18:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131828AbQKCXwG>; Fri, 3 Nov 2000 18:52:06 -0500
Received: from mta01.mail.au.uu.net ([203.2.192.81]:1271 "EHLO
	mta01.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S129066AbQKCXvw>; Fri, 3 Nov 2000 18:51:52 -0500
Message-ID: <3A034F28.5DB994F4@valinux.com>
Date: Sat, 04 Nov 2000 10:50:00 +1100
From: Gareth Hughes <gareth@valinux.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, dledford@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: SETFPXREGS fix
In-Reply-To: <20001103174105.C857@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> --- 2.4.0-test10/arch/i386/kernel/i387.c        Thu Nov  2 20:58:58 2000
> +++ PIII/arch/i386/kernel/i387.c        Thu Nov  2 18:44:36 2000
> @@ -440,8 +436,25 @@
>  int set_fpxregs( struct task_struct *tsk, struct user_fxsr_struct *buf )
>  {
>         if ( HAVE_FXSR ) {
> -               __copy_from_user( &tsk->thread.i387.fxsave, (void *)buf,
> -                                 sizeof(struct user_fxsr_struct) );
> +               long mxcsr;
> +
> +               if (__copy_from_user(&tsk->thread.i387.fxsave, (void *)buf,
> +                                    (long) &((struct user_fxsr_struct *)
> +                                             0)->mxcsr))
> +                       return -EFAULT;
> +               if (__get_user(mxcsr,
> +                              &((struct user_fxsr_struct *) buf)->mxcsr))
> +                       return -EFAULT;
> +               /* bit 6 and 31-16 must be zero for security reasons */
> +               mxcsr &= 0xffbf;
> +               tsk->thread.i387.fxsave.mxcsr = mxcsr;
> +               if (__copy_from_user(&tsk->thread.i387.fxsave.reserved,
> +                                    &((struct user_fxsr_struct *)
> +                                      buf)->reserved,
> +                                    sizeof(struct user_fxsr_struct)-
> +                                    (long) &((struct user_fxsr_struct *)
> +                                             0)->reserved))
> +                       return -EFAULT;
>                 return 0;
>         } else {
>                 return -EIO;

Why do all three copies?  Why not copy it once and mask out the mxcsr
value when it's in tsk->thread.i387.fxsave.mxcsr?  Seems to be an overly
complex fix.

	if ( HAVE_FXSR ) {
		if ( __copy_from_user( &tsk->thread.i387.fxsave, (void *)buf,
					sizeof(struct user_fxsr_struct) ) )
			return -EFAULT;
		/* bit 6 and 31-16 must be zero for security reasons */
		tsk->thread.i387.fxsave.mxcsr &= 0x0000ffbf;
		return 0;
	}

-- Gareth
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
