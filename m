Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbTDRIQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTDRIQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:16:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54790 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262933AbTDRIQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:16:00 -0400
Date: Fri, 18 Apr 2003 09:27:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Kernel<->Userspace API issue
Message-ID: <20030418092755.A25177@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A problem has recently been reported on the ARM lists regarding RT signal
handling.  It appears that there is an issue between glibc and the kernel,
in that glibc has a different idea of the layout of structures passed
from the kernel than the kernel itself.

I think this is a case in point that our policy on "userspace must not
include kernel headers" is completely wrong when it comes to user
space interfaces.  I believe we need is a clear set of defined user
space interface headers which contain the definition of structures and
numbers shared between user space and kernel space.  ie, include/abi
or some such.

No, glibckernheaders (or whatever it is) is NOT the solution - that
just creates yet another set of header files to potentially go out
of sync.

Comments?

On Thu, Apr 17, 2003 at 10:23:51PM -0400, Josh Fryman wrote:
> any insights?  is this an implementation issue, program error, or am i 
> missing some arm-centric trick?  or am i just stupid and doing something
> completely wrong?

Sigh.  glibc seems to have a bug.  This is the kernel's idea of ucontext:

struct ucontext {
        unsigned long     uc_flags;
        struct ucontext  *uc_link;
        stack_t           uc_stack;
        struct sigcontext uc_mcontext;
        sigset_t          uc_sigmask;   /* mask last for extensibility */
};

and glibc's idea:

typedef struct ucontext
  {
    unsigned long int uc_flags;
    struct ucontext *uc_link;
    __sigset_t uc_sigmask;
    stack_t uc_stack;
    mcontext_t uc_mcontext;
    long int uc_filler[5];
  } ucontext_t;

God knows where glibc got this from - it hasn't changed certainly since
2.2 kernels.  I suspect glibc has been wrong for some time.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

