Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUFMEVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUFMEVc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 00:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbUFMEVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 00:21:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:55111 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264998AbUFMEV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 00:21:27 -0400
Date: Sat, 12 Jun 2004 21:20:24 -0700
From: Paul Jackson <pj@sgi.com>
To: Clemens Schwaighofer <schwaigl@eunet.at>
Cc: gullevek@gullevek.org, linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
Message-Id: <20040612212024.0bbec683.pj@sgi.com>
In-Reply-To: <40CBD251.4000601@eunet.at>
References: <40C9AF48.2040807@gullevek.org>
	<20040611062829.574db94f.pj@sgi.com>
	<40CA6835.2070405@eunet.at>
	<20040612034430.72a8207e.pj@sgi.com>
	<40CBC809.3000102@eunet.at>
	<20040612204207.0136b76f.pj@sgi.com>
	<40CBD251.4000601@eunet.at>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | preprocessor output, to see if the (cpumask_t) cast is present.
> |
> 
> yeah I have the cputmask_t here:

No - look to see if the __cast__ is there, the (cpumask_t) term
that was needed in the define of CPU_MASK_NONE:

#define CPU_MASK_NONE                                                   \
((cpumask_t){ {                                                         \
        [0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL                         \
} })

This would be on the preprocessor code that is generated from line
1137 of drivers/perfctr/x86.c, where the error is generated.   This is
the source line that looks like:

	old_mask = perfctr_cpus_forbidden_mask;

The preprocessor output from this line in the x86.i file will look
something like this, hopefully:

   Good:

	old_mask = ((cpumask_t){ { [0 ... (((8)+32 -1)/32)-1] = 0UL } });

Not like this:

   Bad:

	old_mask = { { [0 ... (((8)+32 -1)/32)-1] = 0UL } };

(the '8' varies with your NR_CPUS configuration).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
