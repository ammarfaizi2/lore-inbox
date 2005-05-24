Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVEXJjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVEXJjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVEXJiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:38:25 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:61886 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261973AbVEXJP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:15:59 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091553.E8F18F9F3@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:15:53 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id B721DFB6B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:42 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261152AbVEXGCP (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:02:15 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVEXGCP

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:02:15 -0400

Received: from fmr24.intel.com ([143.183.121.16]:49288 "EHLO

	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP

	id S261152AbVEXGCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:02:09 -0400

Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])

	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j4O6176s012734;

	Tue, 24 May 2005 06:01:07 GMT

Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])

	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j4O5tOoM023909;

	Tue, 24 May 2005 05:55:25 GMT

Received: (from araj@localhost)

	by unix-os.sc.intel.com (8.11.6/8.11.2) id j4O616v13984;

	Mon, 23 May 2005 23:01:06 -0700

Date:	Mon, 23 May 2005 23:01:06 -0700

From: Ashok Raj <ashok.raj@intel.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
	zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
	linux-kernel@vger.kernel.org, rusty@rustycorp.com.au
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64

Message-ID: <20050523230106.A13839@unix-os.sc.intel.com>

References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com> <20050524054617.GA5510@in.ibm.com>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

User-Agent: Mutt/1.2.5.1i

In-Reply-To: <20050524054617.GA5510@in.ibm.com>; from vatsa@in.ibm.com on Tue, May 24, 2005 at 11:16:17AM +0530

X-Scanned-By: MIMEDefang 2.44

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



On Tue, May 24, 2005 at 11:16:17AM +0530, Srivatsa Vaddagiri wrote:
> On Mon, May 23, 2005 at 10:40:46AM -0700, Ashok Raj wrote:
> > Iam not a 100% sure about above either, if the smp_call_function 
> > is started with 3 cpus initially, and 1 just came up, the counts in 
> > the smp_call data struct could be set to 3 as a result of the new cpu 
> > received this broadcast as well, and we might quit earlier in the wait.
> 
> True.

Thanks for confirming. 

I think the window would be a little bit more narrow, but not completely 
closed even if we bring cpu in cli state completely.

> 
> > sending to only relevant cpus removes that ambiquity. 
> 
> Or grab the 'call_lock' before setting the upcoming cpu in the online_map.
> This should also avoid the race when a CPU is coming online.
> 

We do this today in x86_64 case when we setup this upcomming cpu in 
cpu_online_map. But the issue is when we use ipi broadcast, its an ugly
case when we dont know if the new cpu is receiving this as well, and 
we dont have real control there.

i converted to use send_IPI_mask(cpu_online_map, CALL_FUNCTION_VECTOR)
instead of the send_IPI_allbutself(CALL_FUNCTION_VECTOR) in 
__smp_call_function(), apart from taking the call_lock before setting the
bit in online_map.

Since Andi is concerned about tlb flush intr performance in the 8cpu and less
case, iam planning temporarily use a startup cmd or choose this option 
automatically if CONFIG_HOTPLUG_CPU is set for the time being, until we can 
find a clean solution that satisfies everyone.

Cheers,
Ashok Raj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

