Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbULGBLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbULGBLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 20:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbULGBLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 20:11:21 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17870 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261624AbULGBLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 20:11:14 -0500
Subject: [PATCH] 2.6.10-rc2-mm4 panic on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de
In-Reply-To: <200412070022.23645.rjw@sisk.pl>
References: <1102369238.2826.8.camel@dyn318077bld.beaverton.ibm.com>
	 <20041206141515.7f4bd45f.akpm@osdl.org>  <200412070022.23645.rjw@sisk.pl>
Content-Type: multipart/mixed; boundary="=-QTFX5/KmRoCG4Jq0+LPV"
Organization: 
Message-Id: <1102380640.2826.13.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Dec 2004 16:50:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QTFX5/KmRoCG4Jq0+LPV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok !! Here is the patch to fix the problem. It works
fine on my 4-way AMD64 box. 

Rafael, can you verify on yours ?

Problem is with "c - cpu_data" arthimetic. "c" could
be "boot_cpu_data" or "cpu_data".

Andi, is this reasonable ?

Thanks,
Badari


On Mon, 2004-12-06 at 15:22, Rafael J. Wysocki wrote:
> On Monday 06 of December 2004 23:15, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > Hi Andrew,
> > > 
> > > I get following panic while booting 2.6.10-rc2-mm4 on my
> > > 4-way AMD64 box. Is this known or fixed ?
> > 
> > Well it is known now, but not fixed, afaik.
> 
> Well, I reported exactly the same thing some time ago (on a dual-Opteron). :-)  
> It is NUMA-related, or at least SMP-related, apparently, as it does not occur 
> on a UP box ...
> 
> > > Unable to handle kernel paging request at ffffffffd5a4a4fb RIP:
> > > <ffffffff80657607>{numa_add_cpu+7}
> > 
> > Looks like cpu_to_node(cpu) returned garbage, perhaps.
> 
> ... so I guess you are right.
> 
> Greets,
> RJW

--=-QTFX5/KmRoCG4Jq0+LPV
Content-Disposition: attachment; filename=numa_add_cpu_fix.patch
Content-Type: text/plain; name=numa_add_cpu_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/arch/x86_64/kernel/setup.c	2004-12-06 17:47:46.000000000 -0800
+++ linux/arch/x86_64/kernel/setup.c	2004-12-06 17:43:39.000000000 -0800
@@ -947,7 +947,8 @@ void __init identify_cpu(struct cpuinfo_
 	mcheck_init(c);
 #endif
 #ifdef CONFIG_NUMA
-	numa_add_cpu(c - cpu_data);
+	if ( c != &boot_cpu_data ) 
+		numa_add_cpu(c - cpu_data);
 #endif
 }
  

--=-QTFX5/KmRoCG4Jq0+LPV--

