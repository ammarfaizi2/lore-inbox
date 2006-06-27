Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030643AbWF0PBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030643AbWF0PBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030750AbWF0PBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:01:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38893 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030643AbWF0PBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:01:33 -0400
Message-ID: <44A14844.3010009@zytor.com>
Date: Tue, 27 Jun 2006 08:01:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [klibc 37/43] x86_64 support for klibc
References: <klibc.200606251757.37@tazenda.hos.anvin.org> <p73zmfzt2hx.fsf@verdi.suse.de>
In-Reply-To: <p73zmfzt2hx.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
>> +
>> +#include <asm/signal.h>
>> +/* The x86-64 headers defines NSIG 32, but it's actually 64 */
>> +#undef  _NSIG
>> +#undef  NSIG
>> +#define _NSIG 64
>> +#define NSIG  _NSIG
> 
> If it's really wrong it should be fixed, not workarounded.
> 

It is wrong... include/asm-x86_64/signal.h has cribbed a bit too much 
from i386:

ifdef __KERNEL__
/* Most things should be clean enough to redefine this at will, if care
    is taken to make libc match.  */

#define _NSIG           64
#define _NSIG_BPW       64
#define _NSIG_WORDS     (_NSIG / _NSIG_BPW)

typedef unsigned long old_sigset_t;             /* at least 32 bits */

typedef struct {
         unsigned long sig[_NSIG_WORDS];
} sigset_t;


struct pt_regs;
asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);


#else
/* Here we must cater to libcs that poke about in kernel headers.  */

#define NSIG            32
typedef unsigned long sigset_t;

#endif /* __KERNEL__ */
#endif


I can't remove the workaround just yet, since I have active users of the 
out-of-tree version.  However, I will send you a patch for 
include/asm-x86_64/signal.h.

>> +
>> +/* The x86-64 syscall headers are needlessly inefficient */
>> +
>> +#undef _syscall0
>> +#undef _syscall1
>> +#undef _syscall2
>> +#undef _syscall3
>> +#undef _syscall4
>> +#undef _syscall5
>> +#undef _syscall6
> 
> What do you mean with that?
> 

At one point klibc was using the _syscall() macros, and I observed that 
the x86-64 ones generated extra instructions because of the "movq"s that 
were hard-coded in the patterns (using register variables, one can make 
gcc do any moves that may or may not be necessary.)

However, klibc no longer uses these except on ia64, so I removed 
<klibc/archsys.h> for all other architectures from the tree last night.

	-hpa
