Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUDEHse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUDEHse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:48:34 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:27441 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261793AbUDEHsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:48:30 -0400
Date: Mon, 5 Apr 2004 00:46:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040405004646.146ae51c.pj@sgi.com>
In-Reply-To: <20040405000528.513a4af8.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my previous reply to Rusty, I wrote:
> 	    struct cpumap { DECLARE_BITMAP(bits, NR_CPUS); };
> 	    struct cpumask s, d1, d2;
> 	    bitmap_or(s.bits, d1.bits, d2.bits);

Brain dead code alert (as well as a typo alert for the 'cpumap') - that
last line needs to be:

	    bitmap_or(s.bits, d1.bits, d2.bits, NR_CPUS);

Which is why the 60 odd cpumask and nodemask specific operation macros
exist, to avoid having to explicitly specify the bitsize on each call

In other words, I understand that the following three possibilities
exist for coding these masks:

    /* specify bitsize both on declarations and operations */
    struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); };
    struct cpumask s, d1, d2;
    bitmap_or(s.bits, d1.bits, d2.bits, NR_CPUS);	/* explicit bitsize */

or:

    /* specify bitsize on declaration; use specialized operations */
    struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); };
    struct cpumask s, d1, d2;
    cpus_or(s.bits, d1.bits, d2.bits);			/* 'cpu' implies NR_CPUS */

or:

    /* carry the bitsize in the structure [pseudo C alert] */
    struct mask { int nbits = NR_CPUS; DECLARE_BITMAP(bits, NR_CPUS); };
    struct mask s, d1, d2;
    mask_or(s.bits, d1.bits, d2.bits);			/* mask_* ops get size from struct */

Am I missing any choices?  Which do you prefer?

I understand that the kernel currently does the 2nd choice, encoding the
bitsize in the operation name.

My personal preference is to continue doing this 2nd choice.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
