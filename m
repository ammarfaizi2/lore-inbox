Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSJVM6V>; Tue, 22 Oct 2002 08:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSJVM6V>; Tue, 22 Oct 2002 08:58:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262500AbSJVM6U>;
	Tue, 22 Oct 2002 08:58:20 -0400
Date: Tue, 22 Oct 2002 14:04:28 +0100
From: Matthew Wilcox <willy@debian.org>
To: Erik Andersen <andersen@codepoet.org>, Matthew Wilcox <willy@debian.org>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around duff ABIs
Message-ID: <20021022140428.B27461@parcelfarce.linux.theplanet.co.uk>
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk> <20021020045149.GA27887@codepoet.org> <20021020135109.D5285@parcelfarce.linux.theplanet.co.uk> <20021022044309.GA25172@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021022044309.GA25172@codepoet.org>; from andersen@codepoet.org on Mon, Oct 21, 2002 at 10:43:10PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 10:43:10PM -0600, Erik Andersen wrote:
> I understand the problem very well.  Passing 64 bit stuff via
> syscalls is a major pain in the butt.  But your patch is not just
> changing hppa and mips -- you are breaking the ABI on x86, arm,
> powerpc, etc, etc. etc where it is currently working.  Look very
> closely at your patch.  See those endianness ifdefs?  You are
> adding endianness specific ifdefs into pread, truncate, and
> ftruncate to switch the argument order.  User space is already
> doing that too.  At no time on any architecture is the low stuff
> passed into arg3.  Ergo, your patch is going to break userspace
> where pread and pread64 are now working correctly....

Nope.  Some architectures _do not_ pad 64-bit arguments, others _do_.
On ARM/x86, we currently do use arg3 for the low part of the argument,
but on PPC we use it for the high part because of this sexswapping
crap being done in userspace.

> If you want to change the kernel to passing eliminate 64 bit
> stuff via syscalls, and instead pass pairs of 32bit entities --
> I'm all for that as that would make explicit what user space is
> doing anyways.  But don't break binary compatibility for no
> reason.  Why make both user-space _and_ kernel space add ifdefs
> for endianness?  Make arg3 _always_ contain the hi-bits.

I'd love to move to that model.  But I suspect we need a consensus to
_never_ pass 64-bit quantities across the syscall boundary, and we
aren't going to get it.  So we're going to add more crap every time
someone adds a loff_t ;-(

-- 
Revolutions do not require corporate support.
