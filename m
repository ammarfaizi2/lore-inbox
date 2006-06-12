Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751974AbWFLNls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbWFLNls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 09:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWFLNls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 09:41:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54178 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751974AbWFLNls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 09:41:48 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-mm2
Date: Mon, 12 Jun 2006 15:41:29 +0200
User-Agent: KMail/1.9.3
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060610092412.66dd109f.akpm@osdl.org> <p73irn6sh9q.fsf@verdi.suse.de> <20060612130723.GA17463@elte.hu>
In-Reply-To: <20060612130723.GA17463@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121541.29753.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i think you are right - but if someone goes the trouble of implementing 
> per-arch support for local increments then i'm not against it. (except 
> if the generated code is grossly inefficient) There are architectures 
> where cli/sti hurts alot.

I was refering to asm-generic/local.h

> 
> In any case, on x86 we should switch to a cli/sti implementation indeed 

x86 doesn't need it IMHO - as long as the RMW is atomic as seen by the local
CPU it's ok to use a stale per CPU variable here. So using raw_smp_processor_id()
for this is ok.

> 
> Although on x86_64 we'd probably be pretty OK if all per-cpu variables 
> were in the PDA and were thus at a constant %gs-relative offset. But for 
> now we only have data_offset in the PDA so there's one more unnecessary 
> indirection.

I looked at this some time ago. The problem is that it would require
new relocation types implemented in the assembler/linker. So I kept
the current implementation.

But even the current code is ok because the access is atomic towards
the local CPU. If it's out of date by two cycles on preempt it doesn't
matter much.

-Andi
