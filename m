Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264600AbRFZOu0>; Tue, 26 Jun 2001 10:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbRFZOuQ>; Tue, 26 Jun 2001 10:50:16 -0400
Received: from [64.64.109.142] ([64.64.109.142]:25095 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S264600AbRFZOuC>; Tue, 26 Jun 2001 10:50:02 -0400
Message-ID: <3B38A0F9.DD3256BD@didntduck.org>
Date: Tue, 26 Jun 2001 10:49:29 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugo Mildenberger <Hugo.Mildenberger@topmail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Questionable SIGSEGV signal handling bug concerning siginfo.si_addr 
 on i386-linux 2.4.2
In-Reply-To: <DIEOJPFHFLBDHJJOIGOHGELNCAAA.Hugo.Mildenberger@topmail.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugo Mildenberger wrote:
> 
> Dear friends,
> 
> I'm working on a library, which is able to map (at least synchronous) kernel
> signals to c++ exceptions in a way, that c++ exception handlers can
> determine reason and location of failure in a very detailed manner. Within
> that context, I detected a surprising difference in the behaviour of my test
> programs, depending on if they have been compiled by gcc-2.9.2 or gcc-3.0.
> When I compiled the program with gcc-3.0, siginfo.si_addr contained an
> address, which was always by a value of +4 too large when compared to the
> original invalid pointer value (e.g.0x1238 versus 0x1234 or 0x4 versus 0x0).
> By contrast, the gcc-2.9.2 compiled program behaved correctly.
> 
> That symptom, as I thought, may have been caused by a subtile processor bug,
> which depends on register usage or instruction ordering. And I tracked it
> down to the following difference in offending instructions (both are located
> in the same routine of my test program and causing the expected SIGSEGV,
> suppose eax would contain a value of 0x1234):
> 
> ->gcc-2.95.2:  807c38a:       dd 00         fldl   (%eax)
> ->gcc-3.0:     806e457:       8b 70 04      mov    0x4(%eax),%esi
> 
> siginfo.si_addr contained a correct value in the first case, but an offset
> of +4 compared to the original eax value in the second case. 

What you are seeing is the correct behavior.  The address in si_addr is
the exact address that caused the page fault (from register %cr2).  It
appears that you were trying to access an element of a structure, where
the structure pointer was in %eax and the offset of the element within
the structure is 4 bytes.  I suggest that if you are trying to find out
if a fault happened inside a structure you check the whole range of
addresses in that structure, because any of them could have faulted.

--

				Brian Gerst
