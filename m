Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310534AbSCPTpV>; Sat, 16 Mar 2002 14:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310539AbSCPTpL>; Sat, 16 Mar 2002 14:45:11 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:41721 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S310534AbSCPTo4>;
	Sat, 16 Mar 2002 14:44:56 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.41057.35660.355874@napali.hpl.hp.com>
Date: Sat, 16 Mar 2002 11:43:29 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <yodaiken@fsmlabs.com>, Paul Mackerras <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161102070.31913-100000@penguin.transmeta.com>
In-Reply-To: <20020316115726.B19495@hq.fsmlabs.com>
	<Pine.LNX.4.33.0203161102070.31913-100000@penguin.transmeta.com>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 16 Mar 2002 11:16:16 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

  >> is there a 64 bit machine with hardware search of pagetables?
  >> Even ibm only has a hardware search of hash tables - which we
  >> agree are simply a means of making your hardware TLB larger and
  >> slower.

  Linus> ia64 does the same mistake, I think.

ia64 has an optional hardware walker which can operate in "hashed"
mode or in "virtually mapped linear page table mode".  If you think
you can do a TLB lookup faster in software, you can turn the walker
off.  Our experience so far is that the hw walker does help
performance significantly.  This is partly because it allows CPU
designers to play some nice tricks, which you can't do once the miss
is exposed to software.  Also, since it's defined as an optional
feature, the hardware doesn't have to deal with the difficult corner
cases.  If it gets "overwhelmed" for one reason or another, it can
simply throw up it's hands and raise a TLB miss fault.

Anyhow, at the moment ia64 linux operates the hardware walker in the
virtually mapped linear page table mode, which allows us to use the
normal Linux page tables for the hardware walker.  However, I think
it's quite possible (perhaps even quite likely) that at some time
during the 2.5 cycle we'll switch the hardware walker into hashed
mode.  At that point, the hardware walker would simply operate as
large in-core TLB.  If Linux had a more flexible page table
abstraction, we could treat the in-core TLB as the primary page table,
but quite frankly, it's not clear at all to me whether and how much of
a win this would be.

	--david
--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/
