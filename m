Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUETJp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUETJp1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUETJp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 05:45:27 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:53247 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265025AbUETJpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 05:45:25 -0400
Date: Thu, 20 May 2004 02:51:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: castet.matthieu@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
Message-Id: <20040520025140.02e13b73.pj@sgi.com>
In-Reply-To: <200405192245.07235.jeffpc@optonline.net>
References: <40AB8CDF.8060408@free.fr>
	<200405192245.07235.jeffpc@optonline.net>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:
> but on nosmp machine if the cpu!=0 this procude a BUG();

The line you refer to here is, I believe, in include/linux/cpumask.h:

  #ifdef CONFIG_SMP
    ...
  #else
    ...
  #define cpu_online(cpu)    ({ BUG_ON((cpu) != 0); 1; })
    ...
  #endif

Any thoughts on whether that BUG() is serving any useful purpose?

I'm of a mind to have the non-SMP case of cpu_online(cpu) simply
respond true (1) hardcoded:

  #define cpu_online(cpu)    (1)

Or at least remove the BUG and have it respond true iff cpu == 0:

  #define cpu_online(cpu)    ((cpu) == 0)

While theoretically correct, that BUG() is, so far as I know, of
no redeeming social value.  And it wastes a few bytes of kernel
text space each time cpu_online() is used on an SMP, and causes
the occassional confusion, as in this case.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
