Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131271AbRABSQc>; Tue, 2 Jan 2001 13:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRABSQX>; Tue, 2 Jan 2001 13:16:23 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:25099 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131199AbRABSQN>;
	Tue, 2 Jan 2001 13:16:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: tleete@mountain.net
Date: Tue, 2 Jan 2001 18:44:21 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Re: 2.4.0-testX fails to compile on my Athlon
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <11718F7840A2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Jan 01 at 3:51, Tom Leete wrote:
> Matt Wright wrote:
> > 
> > I've looked for answers to this question before, but all I could find was
> > someone asking a similar question and no replies...
> > 
> > I'm having great trouble getting 2.4.0-testX to compile on my system when
> > I select Athlon/K7 as the Processor Family....
> > 
> > I've attached below the error's I'm getting.... the kernel DOES compile if
> > I select anything else... but I don't have anything else :)
> 
> The problem with SMP+K7 builds is that include/asm-i386/string.h has no
> business using in_interrupt(). That introduces circular dependencies which
> nobody has been able to rearrange away.

I solved it by porting check_asm code from arch/sparc into i386 (I
had to learn check_asm about 'union'), and then replacing 
smp_processor_id() define in smp.h with

#include <asm/asm_offsets.h>
#include <asm/current.h>

#define smp_processor_id() (*(int*)(((unsigned char*)current)+AOFF_task_processor))

So now I still have real spinlocks (so I can debug some problems with
nested console_lock), but inline memcpy...

Unfortunately, real diff is at home... And it has one bad side effect, that
you must rerun 'make dep' manually if you modify task_struct in 
linux/sched.h, as asm/asm_offsets.h -> linux/sched.h dependancy is not
handled by makefiles. But I do not do this modification very often, 
fortunately... Maybe if I placed check_asm somewhere else than where sparc 
tree has it...

For 2.4.0, probably disabling 3DNow in kernel when using SMP is best 
solution, as AFAIK nobody tested correctness of 3DNow code on SMP... Or is
it obviously correct?
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
