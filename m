Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130299AbQLYHrV>; Mon, 25 Dec 2000 02:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130755AbQLYHrM>; Mon, 25 Dec 2000 02:47:12 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:36363 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S130299AbQLYHq7>; Mon, 25 Dec 2000 02:46:59 -0500
Message-ID: <3A46F4D8.9060605@redhat.com>
Date: Mon, 25 Dec 2000 01:18:48 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: the list <linux-kernel@vger.kernel.org>
Subject: sysmips call and glibc atomic set
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with a vr4181 target and started digging into the atomic 
test and set stuff in the kernel and glibc. The first problem I had was 
that the glibc code assumes that all mips III targets implement the mips 
III ISA (funny assumption, no?) but the vr4181 doesn't include the 
miltiprocessor oriented LL/SC operations for atomic test and set.

So I started looking at the glibc code (yes, I know this is the kernel 
list... I'm getting there I promise) and notice the following operations:

   __asm__ __volatile__
     (".set	mips2\n\t"
      "/* Inline spinlock test & set */\n\t"
      "1:\n\t"
      "ll	%0,%3\n\t"
      ".set	push\n\t"
      ".set	noreorder\n\t"
      "bnez	%0,2f\n\t"
      " li	%1,1\n\t"
      ".set	pop\n\t"
      "sc	%1,%2\n\t"
      "beqz	%1,1b\n"
      "2:\n\t"
      "/* End spinlock test & set */"
      : "=&r" (ret), "=&r" (temp), "=m" (*spinlock)
      : "m" (*spinlock)
      : "memory");

The significant code here being the 'll' and 'sc' operations which are 
supposed to ensure that the operation is atomic.

QUESTION 1) Will this _ALWAYS_ work from user land? I realize the 
operations are temporally close, but isn't there the possibility that an 
interrupt occurs in the meantime?

Of course none of this code applies to my case anyway, since the vr4181 
doesn't implement these ops. So once I hack^H^H^H^Hadjust glibc to use 
the 'mips1' implementation, it uses the sysmips system call. regard :

_test_and_set (int *p, int v) __THROW
{
   return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
}

So then I looked at the kernel and find the code below. The system I'm 
working with is expressedly uniprocessor and doesn't have any swap, so 
it looks like the initial caveats are met, but it looks to me like there 
could be some confusion if the value of *arg1 at entry looks like 
-ENOSYS or something like that.

QUESTION 2) Wouldn't it be better to pass back the initial value of 
*arg1 in *arg3 and return zero or negative error code?

	case MIPS_ATOMIC_SET: {
		/* This is broken in case of page faults and SMP ...
		    Risc/OS faults after maximum 20 tries with EAGAIN.  */
		unsigned int tmp;

		p = (int *) arg1;
		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
		if (errno)
			return errno;
		errno = 0;
		save_and_cli(flags);
		errno |= __get_user(tmp, p);
		errno |= __put_user(arg2, p);
		restore_flags(flags);

		if (errno)
			return tmp;

		return tmp;             /* This is broken ...  */
         }

QUESTION 3) I notice that the code for this particular case of sysmips 
has changed recently. The old code looked more like the 'll/sc' version 
of glibc above. I would think that the 'll/sc' code would be better on 
SMP systems. Is there a good reason why this reverted?

Sorry For the Long Post (tm)! Thanks In Advance! Merry Xmas!

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
