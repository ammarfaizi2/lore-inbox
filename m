Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVI1XJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVI1XJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVI1XJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:09:51 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:56838 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751208AbVI1XJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:09:49 -0400
Message-ID: <433B21F0.1030103@vmware.com>
Date: Wed, 28 Sep 2005 16:06:24 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/3] Pnp bios gdt fix
References: <200509282143.j8SLh7dY032231@zach-dev.vmware.com>
In-Reply-To: <200509282143.j8SLh7dY032231@zach-dev.vmware.com>
Content-Type: multipart/mixed;
 boundary="------------010704080706080604020501"
X-OriginalArrivalTime: 28 Sep 2005 23:06:24.0343 (UTC) FILETIME=[3F666E70:01C5C481]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010704080706080604020501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Zachary Amsden wrote:

>PnP BIOS for x86 is part of drivers, so I missed it in the initial
>GDT page alignment patch.  Kudos to Andrew for fixing that.
>Unfortunately, fixing the build introduced a kernel panic when
>trying to setup the as of yet unallocated GDTs for the APs.
>This fixes the problem by setting only the BSP's GDT, then copying
>the PnP segments back to the cpu_gdt_table template.
>
>  
>

Bogus patch!  I was just getting lucky and not running PnP BIOS code on 
the AP's -- until now.  Turns out the fix and the bug were much 
simpler.  Please apply this instead.



--------------010704080706080604020501
Content-Type: text/plain;
 name="pnp-bios-gdt-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp-bios-gdt-fix"

PnP BIOS for x86 is part of drivers, so I missed it in the initial
GDT page alignment patch.  Kudos to Andrew for fixing that.
Unfortunately, fixing the build introduced a kernel panic when
trying to setup the as of yet unallocated GDTs for the APs.

I totally misdiagnosed this.  The problem happens only
when NR_CPUS > physical CPUs.  Fix is to ignore missing GDT's.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-rc2/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/pnp/pnpbios/bioscalls.c	2005-09-28 15:57:42.000000000 -0700
+++ linux-2.6.14-rc2/drivers/pnp/pnpbios/bioscalls.c	2005-09-28 15:59:37.000000000 -0700
@@ -537,6 +537,8 @@ void pnpbios_calls_init(union pnp_bios_i
 	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
 	for(i=0; i < NR_CPUS; i++)
 	{
+		if (!get_cpu_gdt_table(i))
+			continue;
 		Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
 		Q_SET_SEL(i, PNP_CS16, header->fields.pm16cseg, 64 * 1024);
 		Q_SET_SEL(i, PNP_DS, header->fields.pm16dseg, 64 * 1024);

--------------010704080706080604020501--
