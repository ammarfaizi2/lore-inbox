Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVCJSpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVCJSpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVCJSmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:42:49 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:42838 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262772AbVCJSgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:36:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=IlLj6MbWvj7lFaSICPJtkQQP0hICHlT7cEGsLFPeoL3FpmV/rZp0Hbm5CSrMzcL8ZM+g8t78IhZYqWY8ME2OjJutb8l/zz2+IJVxLYDT1egjkGDprHQ09rUI/JjTkCgWTPXhpd/eupSVCzooV/gov737H5SNSYMQgL+LxB0oaKo=
Message-ID: <61d439b05031010367db84aaf@mail.gmail.com>
Date: Thu, 10 Mar 2005 19:36:35 +0100
From: Jordi Brinquez <jordi.brinquez@gmail.com>
Reply-To: Jordi Brinquez <jordi.brinquez@gmail.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Errors in sigaction struct definition
Cc: Xavi Martorell <xavim@ac.upc.edu>,
       =?ISO-8859-1?Q?Jordi_Br=EDnquez?= <jbrinx@terra.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a problem while using sigaction structure because of problems
on definition of that structure.

I found it on version 2.6.10 but it was confirmed on version 2.6.8 and
2.6.11 (so probably on other 2.6.x versions)

Extract from /include/asm-i386/signal.h (lines 142-172)

#ifdef __KERNEL__
struct old_sigaction {
    __sighandler_t sa_handler;
    old_sigset_t sa_mask;
    unsigned long sa_flags;
    __sigrestore_t sa_restorer;
};

struct sigaction {
    __sighandler_t sa_handler;
    unsigned long sa_flags;
    __sigrestore_t sa_restorer;
    sigset_t sa_mask;       /* mask last for extensibility */
};

struct k_sigaction {
    struct sigaction sa;
};
#else
/* Here we must cater to libcs that poke about in kernel headers.  */

struct sigaction {
    union {
      __sighandler_t _sa_handler;
      void (*_sa_sigaction)(int, struct siginfo *, void *);
    } _u;
    sigset_t sa_mask;
    unsigned long sa_flags;
    void (*sa_restorer)(void);
};

As you can see the order of the fields in sigaction struct defined
under __KERNEL__ is:
    sa_handler;
    sa_flags;
    sa_restorer;
    sa_mask;
and the order of the fields of the section for the user code is:
    union {...} _u;
    sa_mask;
    sa_flags;
    sa_restorer;

The order is not the same.

Now if we look at the routine that manages the sigaction
(rt_sigaction) we have the following code:

Extract from /kernel/signal.c (lines 2545-2573)

#ifdef __ARCH_WANT_SYS_RT_SIGACTION
asmlinkage long
sys_rt_sigaction(int sig,
         const struct sigaction __user *act,
         struct sigaction __user *oact,
         size_t sigsetsize)
{
    struct k_sigaction new_sa, old_sa;
    int ret = -EINVAL;

    /* XXX: Don't preclude handling different sized sigset_t's.  */
    if (sigsetsize != sizeof(sigset_t))
        goto out;

    if (act) {
        if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
            return -EFAULT;
    }

    ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);

    if (!ret && oact) {
        if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
            return -EFAULT;
    }
out:
    return ret;
}
#endif /* __ARCH_WANT_SYS_RT_SIGACTION */

As you can see the algorithm that copies the values from user struct
to kernel struct is copy_from_user (and copy to_user) so because the
diferent definition of the structures the data goes corrupted.

To solve that problem there are two solutions:

- Reorder the fields on user structure (easy solution)
- Change the copy_to_user and copy_from_user for code using __put_user
and __get_user

I think that implementing both can prevent future problems.

Greets,

Jordi
