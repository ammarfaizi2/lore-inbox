Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbREQTku>; Thu, 17 May 2001 15:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbREQTkk>; Thu, 17 May 2001 15:40:40 -0400
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:12562 "HELO
	zmamail04.zma.compaq.com") by vger.kernel.org with SMTP
	id <S261857AbREQTkX>; Thu, 17 May 2001 15:40:23 -0400
Date: Thu, 17 May 2001 14:35:44 -0400
From: Jay Estabrook <Jay.Estabrook@compaq.com>
To: linux-kernel@vger.kernel.org
Subject: Re: alpha/2.4.x: CPU misdetection, possible miscompilation
Message-ID: <20010517143544.A8396@linux04.mro.cpqcorp.net>
In-Reply-To: <Pine.LNX.4.21.0105161739440.31072-100000@rainbow.studorg.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0105161739440.31072-100000@rainbow.studorg.tuwien.ac.at>; from mike@rainbow.studorg.tuwien.ac.at on Thu, May 17, 2001 at 02:23:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 02:23:03PM +0200, Michael Wildpaner wrote:
> 
> trying to boot any 2.4.x kernel on a Tsunami DP264 alpha with dual EV67,
> we found the following problems:
> 
> CPU misdetection:
> 
> 	On our machine the cpu->type field contains 0x80000000B
> 	(= 2^35 + 11) instead of 0xB (= hwrpb.h: #define EV67_CPU 11).
> 
> 	The spurious high bit leads to false/default values for
> 	on_chip_cache in smp.c:smp_tune_scheduling.
>...
>+/* mask for cpu->type (arbitrary assumption based on #define's in hwrpb.h) */
>+#define CPU_TYPE_MASK 0xFFFFFF
>...
>-	switch (cpu->type)
>+	switch (cpu->type & CPU_TYPE_MASK)

The Alpha Architecture Reference Manual describes the PROCESSOR TYPE field
of the per-CPU slot HWRPB information, as:

	bits	interpretation
	----	--------------
	63-32	minor type
	31-0	major type

so the above patch should have CPU_TYPE_MASK as 0xffffffff (optimistic :-);
or you could just:

	switch ((unsigned int) cpu->type)

like the /proc/cpuinfo printing code in setup.c does.

The "minor type" is usually a reference to the "pass" number of the chip,
and can be ignored.

--Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            Alpha Engineering - LINUX Project
Compaq Computer Corp. - MRO1-2/K20         (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@compaq.com
-----------------------------------------------------------------------------
