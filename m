Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUC1TsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUC1TsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:48:12 -0500
Received: from ns.suse.de ([195.135.220.2]:5277 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262398AbUC1TsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:48:03 -0500
To: "Ivan Godard" <igodard@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel support for peer-to-peer protection models...
References: <048e01c413b3$3c3cae60$fc82c23f@pc21.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Mar 2004 07:29:11 +0100
In-Reply-To: <048e01c413b3$3c3cae60$fc82c23f@pc21.suse.lists.linux.kernel>
Message-ID: <p73y8pm951k.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ivan Godard" <igodard@pacbell.net> writes:

> We're a processor startup with a new architecture that we will be porting
> Linux to. The bulk of the port will be straightforward (well, you know what
> I mean), except for the protection model supported by the hardware.  How
> would you extend/mod the kernel if you had hardware that:
> 
> 1) had a large number of distinguishable address spaces

Large or unlimited? If not unlimited you may still run into
problems when you give each process such an address space.
Limiting the number of processes is probably not an option.

> 2) any running code had two of these (code and data environment) it could
> use arbitrarily, but access to addresses in others was arbitrarily protected
> 3) flat, unified virtual addresses (64 bit) so that pointers, including
> inter-space pointers, have the same representation in all spaces

You mean Address 0 is only accessible from Address space 0, but not 
from Space 1 ?

Maybe you can give each process an different address range, but AFAIK
the only people who have done this before are users of non MMU architectures.
It will probably require som changes in the portable part of the code.
Also porting glibc's ld.so to this will be likely no-fun.

> 4) no "supervisor mode"
> 5) inter-space references require grant of access (transitive) by the
> accessed space; grants can be entire space or any contiguous subspace

Sounds like the only sane way to handle (4) would be to give the kernel
an own address space with the necessary grants to access everything.
However this will require an address space switch for every system call.
But there is no way around it, linux requires a "shared" kernel mapping
at least for part of the kernel memory ("lowmem")

Overall it sounds like your architecture is not very well suited to 
run Linux.

> 10) Drivers can have their own individual space(s) distinct from those of
> the kernel and the apps. Buggy drivers cannot crash the kernel.

At least you would need to use your own drivers (I believe the IBM
iSeries and s390/VM port does it kind of). If your CPU has generic PCI
slots this will be a lot of work. Without it it will be lots of work too,
but at least the number of drivers required is limited.

> Is this model so alien to the existing Kernel that the best approach is to

It is definitely alien.


-Andi
