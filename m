Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314472AbSDWWHr>; Tue, 23 Apr 2002 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315351AbSDWWHq>; Tue, 23 Apr 2002 18:07:46 -0400
Received: from fmr01.intel.com ([192.55.52.18]:20947 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S314472AbSDWWHp>;
	Tue, 23 Apr 2002 18:07:45 -0400
Message-ID: <9287DC1579B0D411AA2F009027F44C3F171C1AC9@FMSMSX41>
From: "Saxena, Sunil" <sunil.saxena@intel.com>
To: "'Andi Kleen'" <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Initial process CPU state was Re: SSE related security hole
Date: Tue, 23 Apr 2002 15:07:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The correct sequence for initializing MMX/SSE/SSE2 CPU state (I exchanged
mail with Linus) is:

	memset(&fxsave, 0, sizeof(struct i387_fxsave_struct));
	fxsave.cwd = 0x37f;
	fxsave.mxcsr = 0x1f80;

	fxrstor(&fxsave);

The above is architectural feature and you can expect this to work in the
future.   Intel will work to document this in our Monthly Specification
Updates and update "IA-32 Intel(R) Architecture Software Developer Manual"s.

Thanks
Sunil

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Monday, April 22, 2002 3:51 PM
To: Saxena, Sunil
Cc: linux-kernel@vger.kernel.org
Subject: Initial process CPU state was Re: SSE related security hole


"Saxena, Sunil" <sunil.saxena@intel.com> writes:

Hallo Sunil,

> We recognized that there is a discrepancy in the individual instruction
> descriptions in Vol 2 where it is indicated that the instruction would
> generate a UD#. We will be rectifying this discrepancy in the next
revision
> of Vol 2 as well as via the monthly Specification Updates.

Could you quickly describe what the Intel recommended way is to clear
the whole CPU at the beginning of a process? Is there a better way
than "save state with fxsave at bootup and restore into each
new process"? After all it would be a bit unfortunate to have
instructions which are transparently tolerant to new CPU state
(fxsave/fxrstor 
for context switching), but no matching way to clear the same state for 
security reasons.  Using the bootup FXSAVE image would make linux
depend on the BIOS for this (so in the worst case when the bios 
doesn't clear e.g. the XMM registers or some future registers each 
process could see the state of some previous boot after a warm boot) 

Another way would be to do a fxsave after clearing of known state (x87,MMX,
SSE) at OS bootup and then afterwards set all the so far reserved parts of
the 
FXSAVE image to zero. Then restore this image later into each new process.
This would avoid any BIOS/direct warmboot dependencies.  It would work 
assuming that all future IA32 state can be safely initialized with zeroes
via FXRSTOR. Is this a safe assumption?

Thanks, 
-Andi
