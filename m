Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUF3S12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUF3S12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUF3S12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:27:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38407 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266790AbUF3S07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:26:59 -0400
Date: Wed, 30 Jun 2004 19:26:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630192654.B21104@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040630145942.GH29285@mail.shareable.org>; from jamie@shareable.org on Wed, Jun 30, 2004 at 03:59:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 03:59:42PM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > There are two different types of privileged accesses on ARM.  One is the
> > standard load/store instruction, which checks the permissions for the
> > current processor mode.  The other is one which simulates a user mode
> > access to the address.
> > 
> > We use the latter for get_user/put_user/copy_to_user/copy_from_user.
> > 
> > > This means that calling write() with a PROT_NONE region would succeed,
> > > wouldn't it?
> > 
> > No, because the uaccess.h function will fault, and we'll end up returning
> > -EFAULT.
> 
> Ok, that answers my question, thanks.  ARM and ARM26 are fine with PROT_NONE.
> 
> Those are the "ldrlst" instructions in getuser.S, right?
> 
> Here's a question, for ARM only (not ARM26):
> ...........................................
> 
> getuser.S uses "ldrlst", but unlike ARM26 has no TASK_SIZE check and
> matching "ldrge".  If kernel C code uses set_fs(), then get_user()
> _should_ permit reading from kernel addresses.  Will that work on ARM?

Indeed it does - it's all magic.  Firstly, let me explain "ldrlst".  This
is "ldr" + "ls" + "t".  "ldr" = load register.  "ls" = less than (all
instructions are conditional on ARM.)  "t" = the magic which turns this
access into a user mode access.

If the address is larger than the value in TI_ADDR_LIMIT, there's no
point in even trying the access - it will fail, so we just do the "bad
access" handling.  This also happens if the instruction faults and the
fault can not be fixed up.

However, when we have set_fs(KERNEL_DS) in effect, we modify two things.
First is the TI_ADDR_LIMIT, which allows any access through the assembly
check.  The other is the magic - we fiddle with the domain register.

Every translation has a "domain" index associated with it, and each
domain can be in one of three modes: no access, client or manager.

If it's in "no access" mode, nothing can access translations in this
domain.  "client" mode means that the page level permissions are checked
and faults are generated depending on the access mode vs the permission
mode.  "manager" means the page level permissions are not checked at
all, and any access will succeed irrespective of the page level
permissions.

We use three domains - one for user, one for kernel and one for IO.
Normally all three are in client mode.  However, on set_fs(KERNEL_DS)
we switch the kernel domain to manager mode.

This means that the user-mode LDR instructions (ldrt / ldrlst etc)
will not have their page permissions checked, and therefore the access
will succeed - exactly as we require.

> I ask because it's interesting to see that ARM and ARM26 have quite
> different code in getuser.S and putuser.S.  The ARM code is shorter.

ARM26 is completely different - it doesn't have the ability to bypass
permission checks in the "kernel" area of memory.  Therefore, ARM26
has to rely solely on the TI_ADDR_LIMIT check and select the appropriate
instruction to use based upon the suceeding address.

> Here's an optimisation idea, for ARM26 only:
> ...........................................
> 
> Do you need the "strlst" instructions in putuser.S?  They're followed
> by "strge" instructions.

The outcome of the page permission checks are slightly different for the
strt vs str instructions for both the ARM26 cases:

Privileged  T-bit     00      01     10         11
    Y         0       r/w     r/w    r/w        r/w
    Y         1       r/w     read   no access  no access
    N         X       r/w     read   no access  no access

Note: if PAGE_NOT_USER and PAGE_OLD are both clear (iow, young + user
page) we use bit pattern 0x.  If PAGE_NOT_USER, PAGE_OLD, PAGE_READONLY
and PAGE_CLEAN are all clear, we use bit pattern 00.  Otherwise we use
bit pattern 11.

We have a similar difference in kernel-mode vs user-mode accesses for
the ARM case as well - so its all complicated and unless you really
understand this... 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
