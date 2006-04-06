Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWDFUPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWDFUPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWDFUPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:15:51 -0400
Received: from xenotime.net ([66.160.160.81]:49871 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751267AbWDFUPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:15:51 -0400
Date: Thu, 6 Apr 2006 13:18:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jzb@aexorsyst.com
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: [PATCH] mpparse: prevent table index out-of-bounds
Message-Id: <20060406131805.d6eb0fe7.rdunlap@xenotime.net>
In-Reply-To: <200604060918.45185.jzb@aexorsyst.com>
References: <200603212005.58274.jzb@aexorsyst.com>
	<200603251036.40379.jzb@aexorsyst.com>
	<20060405120742.ee9af120.rdunlap@xenotime.net>
	<200604060918.45185.jzb@aexorsyst.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 09:18:45 -0700 John Z. Bohach wrote:

Re: mem= causes oops (was Re: BIOS causes (exposes?) modprobe (load_module) kernel oops)

> I found the root cause, but don't know if its worth fixing.  If the board has more than
> 32 PCI busses on it, the mptable bus array will overwrite its bounds for the PCI busses,
> and stomp on anything that's after it.  In this case, what got stomped on is the PAGE_KERNEL_EXEC
> variable, which changed the bit-field settings for the page tables (cleared the 'present' bit,
> and screwed up the rest), hence accounting for the page fault.

Well, > 32 busses or just one busid value >= 32.

> This can only happen if there are more than 32 PCI busses, so I'd say its an _extremely_ rare
> condition on a desktop system.  At any rate, the fix would simply be to change the value of the
> #define in the mptable.h header file (I forget which exactly, but its easy to find) from 32 to 256.
> The side effect of that is that the kernel data area would grow, and mostly be a total waste,
> since I can't fathom a desktop system with more than 32 PCI busses.  On arch's where more than
> 32 PCI busses are likely, the #define is already 256.

I think that the kernel init code should detect and prevent the
data corruption.  Here's a patch to do that, by ignoring busses
whose busid value is too large.
~~~


From: Randy Dunlap <rdunlap@xenotime.net>

Prevent possible table overflow and unknown data corruption.
Code is in an __init section so it will be discarded after init.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/kernel/mpparse.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- linux-2617-rc1.orig/arch/i386/kernel/mpparse.c
+++ linux-2617-rc1/arch/i386/kernel/mpparse.c
@@ -249,6 +249,13 @@ static void __init MP_bus_info (struct m
 
 	mpc_oem_bus_info(m, str, translation_table[mpc_record]);
 
+	if (m->mpc_busid >= MAX_MP_BUSSES) {
+		printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
+			" is too large, max. supported is %d\n",
+			m->mpc_busid, str, MAX_MP_BUSSES - 1);
+		return;
+	}
+
 	if (strncmp(str, BUSTYPE_ISA, sizeof(BUSTYPE_ISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
 	} else if (strncmp(str, BUSTYPE_EISA, sizeof(BUSTYPE_EISA)-1) == 0) {

---
