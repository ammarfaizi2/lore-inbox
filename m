Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTGBJVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTGBJVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:21:14 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:61969 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262165AbTGBJVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:21:12 -0400
Date: Wed, 2 Jul 2003 19:35:16 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Thomas Spatzier <TSPAT@de.ibm.com>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: crypto API and IBM z990 hardware support
In-Reply-To: <OF1BACB1D3.F4409038-ONC1256D57.00247A0A-C1256D57.002701D8@de.ibm.com>
Message-ID: <Mutt.LNX.4.44.0307021913540.31308-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Thomas Spatzier wrote:

> Hello James,
> 
> I'm currently looking at the crypto API and considering adding support for
> new hardware instructions implemented in the IBM z990 architecture. Since I
> found your name in most of the files I find it appropriate to ask for your
> opinion on how to integrate the new code (from a design point of view).
> z990 provides hardware support for AES, DES and SHA. The problem is, that
> the respective instructions might not be implemented on all z990 systems
> (export restrictions etc). Hence, a check must be run to test whether the
> instruction set is present, and if not, a fall-back to the current software
> implementation must be taken.

Are there any details available on how all of this is implemented?  Are 
these instructions synchronous?

> I basically have two solutions in mind: (1)
> to integrate the new code into the current crypto files; add some #ifdef s
> to prevent the code from being compiled when building a non-z990 kernel;
> add some ifs for runtime check.

No, the core crypto code should not be altered with #ifdefs to handle some 
arch specific issue.

> (2) include the new code into an arch/s390/crypto directory. The
> advantage of (1) is that there are no seperate crypto directories, the
> code doesn't drift apart. Furthermore, it's probably the best solution
> with respect to the kernel module loader. On the other hand, the
> hardware support is very arch-specific, which would fit in option (2).
> (2) however has the disadvantage that there are multiple crypto modules;
> the user has to select one to load -> must have different names for one
> algorithm. What is your opinion on this subject?

The plan is to provide crypto/arch/ subdirectories where arch optimized 
versions of the crypto algorithms are implemented, and built automatically 
(via configuration defaults) instead of the generic C versions.

So, there might be:

crypto/aes.c
crypto/arch/i386/aes.s

where on i386, aes.s would be built into aes.o and aes.c would not be 
built.

The simple solution for you might be something like:

crypto/aes.c -> aes.o
crypto/arch/s390/aes_z990.c -> aes_z990.o

and the administrator of the system could configure modprobe.conf to alias 
aes to aes_z990 if the latter is supported in hardware.


- James
-- 
James Morris
<jmorris@intercode.com.au>

