Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbUF3O7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUF3O7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266688AbUF3O7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:59:50 -0400
Received: from mail.shareable.org ([81.29.64.88]:17581 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266686AbUF3O7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:59:48 -0400
Date: Wed, 30 Jun 2004 15:59:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630145942.GH29285@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630091621.A8576@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> There are two different types of privileged accesses on ARM.  One is the
> standard load/store instruction, which checks the permissions for the
> current processor mode.  The other is one which simulates a user mode
> access to the address.
> 
> We use the latter for get_user/put_user/copy_to_user/copy_from_user.
> 
> > This means that calling write() with a PROT_NONE region would succeed,
> > wouldn't it?
> 
> No, because the uaccess.h function will fault, and we'll end up returning
> -EFAULT.

Ok, that answers my question, thanks.  ARM and ARM26 are fine with PROT_NONE.

Those are the "ldrlst" instructions in getuser.S, right?

Here's a question, for ARM only (not ARM26):
...........................................

getuser.S uses "ldrlst", but unlike ARM26 has no TASK_SIZE check and
matching "ldrge".  If kernel C code uses set_fs(), then get_user()
_should_ permit reading from kernel addresses.  Will that work on ARM?

I ask because it's interesting to see that ARM and ARM26 have quite
different code in getuser.S and putuser.S.  The ARM code is shorter.

Here's an optimisation idea, for ARM26 only:
...........................................

Do you need the "strlst" instructions in putuser.S?  They're followed
by "strge" instructions.

For storing, it looks as though the protections set in pgtable.h will
trigger a write fault whether it's a user mode access or not.  Thus
you _might_ be able to shave an instruction or two off each put_user,
by simply doing a single unconditional kernel mode store.  (The check
against TASK_SIZE has already been done).

Just an idea, I don't know ARM26 well enough to know if that'd work.

-- Jamie
