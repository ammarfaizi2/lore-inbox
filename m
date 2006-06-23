Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWFWQEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWFWQEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWFWQEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:04:01 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15241 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751719AbWFWQD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:03:59 -0400
In-Reply-To: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com>
Subject: Re: [heiko.carstens@de.ibm.com: Re: [PATCH] kprobes for s390 architecture]
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jan Glauber <jan.glauber@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com>
From: Michael Grundy <grundym@us.ibm.com>
Date: Fri, 23 Jun 2006 15:53:54 -0700
X-MIMETrack: Serialize by Router on D01ML065/01/M/IBM(Release 7.0.1 HF4|May 16, 2006) at
 06/23/2006 12:03:55
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Heiko Carstens <heiko.carstens@de.ibm.com> wrote on 06/23/2006 08:03:44 AM:

> This won't solve anything. What Martin probably meant is something like a
poor
> man's stop_machine_run() implemented by using smp_call_function(). This
way
> you synchronize all cpus and when all cpus are in a known state, you
change
> the instruction in question and make sure that serialization happens
before
> cpus leave the handler again... Except for the cpu that called
> smp_call_function() you get the serialization for free, since the last
> instruction of the handler is always an lpsw/lpswe instruction.
>
> Otherwise there is still the possibility that a different cpu is fetching
the
> instruction concurrently while you change it. This doesn't sound very
good,
> especially if you take this paragraph of the Principles of Operation into
> account (p.5-89 of SA22-7832-04):
>
> "It is possible, if another CPU or a channel program concurrently
modifies
> the instruction, for one CPU to recognize the changes to some but not all
bit
> positions of an instruction."

(link to doc for anyone following along at home:
 http://publibz.boulder.ibm.com/epubs/pdf/a2278324.pdf)

On the same page it says "All copies of a prefetched instruction are
discarded
when: * A serializing function is performed" Would something like this in a
smp_call_function do it? :

bcr 15,0

if (*p->addr != breakpoint_instruction)
      *p->addr = breakpoint_instruction;


Alternatively, if we did a compare and swap on that location (serializing
instruction) would that be acceptable?

Thanks
Michael

=========================================
If at first you don't succeed, call in an air strike.

