Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTBORyo>; Sat, 15 Feb 2003 12:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTBORyo>; Sat, 15 Feb 2003 12:54:44 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:39093 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S264646AbTBORym>; Sat, 15 Feb 2003 12:54:42 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200302151804.TAA04500@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
To: zwane@holomorphy.com (Zwane Mwaikambo)
Date: Sat, 15 Feb 2003 19:04:34 +0100 (MET)
Cc: weigand@immd1.informatik.uni-erlangen.de (Ulrich Weigand),
       linux-kernel@vger.kernel.org (Linux Kernel),
       schwidefsky@de.ibm.com (Martin Schwidefsky)
In-Reply-To: <Pine.LNX.4.50.0302151149150.16012-100000@montezuma.mastecende.com> from "Zwane Mwaikambo" at Feb 15, 2003 11:56:54 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> It would be a bug in the caller, this is a primitive really. If the caller 
> is calling this with random bitmasks they are probably making errors 
> elsewhere too. This is also the behaviour of the Alpha version, which has 
> been around before this patch.

Well, either this is a requirement on the caller or it isn't.  I guess
it is fine to make this requirement, but then ...

> The following cpu_online call only goes as far as avoiding IPI'ing to 
> nonexistent cpus, anything more would be spoonfeeding the caller, i prefer 
> garbage in, garbage out.
> 
> 	for (i = 0; i < NR_CPUS; i++) {
> 		if (cpu_online(i) && ((1UL << i) & mask))
> 			smp_ext_bitcall(i, ec_call_function);
> 	}

... this test is quite pointless as the routine will hang shortly
anyway.  In fact is appears to be rather misleading as it can give
the casual reader the impression that offline CPUs are properly
cared for.  I'd suggest to either

- make the routine really safe by doing something like
    mask &= cpu_online_mask;
  at the beginning

or else

- lose the cpu_online test


But apart from this cosmetic issue, there is still a real problem:
smp_ext_bitcall can fail due to SIGP returning a busy condition;
smp_ext_bitcall_others would have retried until the busy condition
is gone.  This means your version can actually lose signals and
deadlock.  You should do something like

	while (smp_ext_bitcall(i, ec_call_function) == sigp_busy)
		udelay(10);

B.t.w as you are removing the only caller of smp_ext_bitcall_others,
you might as well delete the function itself.

All those comments apply likewise to the s390x version.


Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
