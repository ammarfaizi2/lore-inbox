Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270601AbTGNMhq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270619AbTGNMho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:37:44 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15182 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270601AbTGNMZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:25:13 -0400
Date: Mon, 14 Jul 2003 08:40:00 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: sizeof (siginfo_t) problem
Message-ID: <20030714084000.J15481@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When siginfo_t was added, the intent obviously was that its size
be 128 bytes on all arches.
This is true on all 32-bit arches and what glibc has in its siginfo_t
definition on all arches:
# if __WORDSIZE == 64
#  define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 4)
# else
#  define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 3)
# endif

typedef struct siginfo
  {
    int si_signo;               /* Signal number.  */
    int si_errno;               /* If non-zero, an errno value associated with
                                   this signal, as defined in <errno.h>.  */
    int si_code;                /* Signal code.  */

    union
      {
        int _pad[__SI_PAD_SIZE];
...
        struct
          {
            void *si_addr;      /* Faulting insn/memory ref.  */
          } _sigfault;
...
      } _sifields;
  } siginfo_t;

The kernel unfortunately does this right on sparc64 and alpha from 64-bit
arches only; ia64, s390x, ppc64 etc. got it wrong.

This is a bad problem, since e.g. sigwaitinfo(3) is supported ABI,
and apps - as they are compiled against glibc headers, not kernel ones -
will thus reserve on the stack 8 bytes less than the kernel fills
(this is hidden in copy_siginfo_to_user, so usually only if si_code >= 0
all 136 bytes will be copied).
Note that glibc had such siginfo_t definitions from the beggining,
ie. it is not something changed recently. E.g. on s390x,
such definition was already in -r1.1 checkin in March 2001, x86_64/ia64
never had its own siginfo.h but used a generic one which had the
above __SI_PAD_SIZE definition since early 2000 (x86_64 was added in 2001,
ia64 about 5 months later than that change).

I have noticed this on s390x in a different place:
MD_FALLBACK_FRAME_STATE_FOR in gcc, in order to unwind through
signal frames, needs to locate ucontext, and looking at
stack pointer + 8 + sizeof(siginfo_t) (which works on s390 32-bit)
did not work at all, everything was shifted by 8 bytes.
This though means that the kernel siginfo_t change cannot be done
just in asm-*/siginfo.h headers - at least places where siginfo_t
is present within some structures ever visible to userland a dummy
8 byte pad needs to be inserted.

	Jakub
