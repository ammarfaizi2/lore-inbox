Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUGAB7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUGAB7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 21:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUGAB7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 21:59:10 -0400
Received: from mail.shareable.org ([81.29.64.88]:39085 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263731AbUGAB7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 21:59:04 -0400
Date: Thu, 1 Jul 2004 02:59:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Molton <spyro@f2s.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040701015902.GB1094@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk> <20040630201546.GD31064@mail.shareable.org> <20040630235921.C1496@flint.arm.linux.org.uk> <20040630233014.GC32560@mail.shareable.org> <20040701004847.3b7a173b.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701004847.3b7a173b.spyro@f2s.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:
> > "ge" is a signed comparison, and unsigned is needed here, unless I
> > missed something subtle.  So "bge" and "ldrge" should be "bhi" and "ldrhi".
> 
> technically, I think you're right here.
> 
> in practise, the arm26 address space is too small (64MB) for this to
> ever cause a problem.

No -- there is still a bug.

The bug is that userspace can pass an address like 0x90000000 to the
kernel.  This is possible even on arm26.

If you follow the logic in getuser.S, it won't branch to
__get_user_bad, and it won't execute _either_ of the "ldrlst" or
"ldrge" instructions.

So it'll end up returning the value that happens to be in r1 and/or
r2, and using that for the syscall, instead of the syscall returning
-EFAULT as it should.

In rare cases, that's a security information leakage.  Usually it's
just rubbish.

-- Jamie
