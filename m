Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUKGQ6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUKGQ6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUKGQ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:58:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:7370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbUKGQ5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:57:44 -0500
Date: Sun, 7 Nov 2004 08:57:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       perex@suse.cz
Subject: Re: Oops in 2.6.10-rc1
In-Reply-To: <418E4705.5020001@g-house.de>
Message-ID: <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
 <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Christian Kujau wrote:
> 
> since i got this oops between 2.6.9 and 2.6.10-rc1 i am still assuming
> that the change was made somewere between 15-Oct-2004 (2.6.9) and
> 22-Oct-2004 (2.6.10-rc1).

Not necessarily. The ALSA merge is the most likely reason for the oops, 
and since ALSA development does not merge with the kernel very often, it 
may be some much older change in the ALSA tree.

You can check the ALSA tree _before_ the merge, by doing (in the current 
tree):

	bk undo -a1.2000.7.2

which should give you a tree without any of "my" stuff, ie it was what 
Jaroslav was working on before he merged it into the standard tree.

(BK revision numbers change on merges, so the above number is not 
necessarily the right one unless you have the current -bk tree. It should 
have a changeset something like:

	ChangeSet@1.2000.7.2, 2004-10-20 20:51:33+02:00, perex@suse.cz
	  Merge suse.cz:/home/perex/bk/linux-sound/linux-sound
	  into suse.cz:/home/perex/bk/linux-sound/work

so that you can double-check).

> http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops.txt

Yup, it's a call through a bad pointer again, and again the EIP value 
can be found in %ecx. But the source of the bug is not clear. The stack 
trace implies "show_stack()", but that function doesn't do any indirect 
calls, so I suspect the frame pointer didn't help in this case. 

And it's not "pci_enable_device()" either (which was there last time too),
since that one calls "pci_enable_device_bars()" at the point it shows in
the stack trace.

Quite frankly, it looks like something smashed the stack, and the fact 
that it happens _around_ when "pci_enable_device()" was called makes me 
seriously suspect the IRQ handler for the device. That's when IRQ routing 
is enabled, so often the interrupts start at that point. And since 
FRAME_POINTER didn't make the stack frame look sane, it's very possible 
that the bogus call isn't due to a real "call", but due to a return from a 
broken stack.

> there was an answer from the alsa-devel folks here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109897024116288&w=2
> 
> "It's a bit dead-lock, because we cannot help you. It seems that
> the pci structure passed to our code is broken. The driver has had
> no changes in initialization for a long time."

I seriously doubt that it's the PCI structure being broken.  It's the ALSA 
merge, almost certainly - it's just that the stack is so confused that 
it's hard to tell where the bug has happened.

And I'll double-check the "regparm" changes, just in case. They change
some irq calling conventions, although none of the involved stuff seems to
be implied here.

A quick suggestion: make sure that there is not some stale object file 
lying around confusing things about memory layout, and do a "make clean" 
and make sure that all old modules are clean too and re-installed. The 
kernel dependencies should be correct, but even then there can be problems 
with clocks that are off a bit etc.

> (still wondering why nobody else has this bug, 1370 is not *that* weird, i
> thought)

Yes, that makes me suspicious, and is one reason why I wonder if it's just 
your tree not being built right.

> PS: if someone could explain me, why the ChangeSet numbers are always
> different: i've used "bk revtool sound/pci/ens1370.c" to find out the
> changes for this file and the suspicious patch reads
> 
>      sound/pci/ens1370.c@1.54.1.1, 2004-10-20....
> 
> in "bk revtool". the changelog however reads:
> 
>      ChangeSet@1.2011, 2004-10-20 08:10:43-07:00, rusty@rustcorp.com.au

There are different revision numbers: there's the revision number for the 
_file_, and there is the revision number for the _change_. 

Also, both (or one) of them can change when a merge occurs, since other 
people may have had different merge histories, and in a distributed 
environment the revision numbers are a lot more fluid than in CVS.

		Linus
