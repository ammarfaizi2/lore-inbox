Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSKMTOR>; Wed, 13 Nov 2002 14:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSKMTOR>; Wed, 13 Nov 2002 14:14:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:47800 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261393AbSKMTOQ>;
	Wed, 13 Nov 2002 14:14:16 -0500
Message-ID: <3DD2A61E.F0647BD4@digeo.com>
Date: Wed, 13 Nov 2002 11:21:02 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kronos@kronoz.cjb.net
CC: lord@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5.47] Unable to load XFS module
References: <20021113184805.GA777@dreamland.darkstar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2002 19:21:02.0215 (UTC) FILETIME=[CDD7F170:01C28B49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kronos wrote:
> 
> Hi,
> I'm playing with kernel 2.5.47. XFS support is compiled as module and at
> boot time, while mounting /home, I get this:
> 
> insmod /lib/modules/2.5.47/kernel/fs/xfs/xfs.o failed
> 
> Then, trying to modprobe xfs by hand:
> 
> /lib/modules/2.5.47/kernel/fs/xfs/xfs.o: unresolved symbol page_states__per_cpu
> /lib/modules/2.5.47/kernel/fs/xfs/xfs.o: insmod /lib/modules/2.5.47/kernel/fs/xfs/xfs.o failed
> /lib/modules/2.5.47/kernel/fs/xfs/xfs.o: insmod xfs failed
> 

You'll need to disable module symbol versioning, or apply this
patch from Rusty:



 include/asm-generic/percpu.h |    6 ++++++
 1 files changed, 6 insertions(+)

--- 25/include/asm-generic/percpu.h~genksyms-fix	Wed Nov 13 00:57:06 2002
+++ 25-akpm/include/asm-generic/percpu.h	Wed Nov 13 00:57:06 2002
@@ -35,4 +35,10 @@ extern unsigned long __per_cpu_offset[NR
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
 
+/* Genksyms can't follow the percpu declaration.  Give it a fake one. */
+#ifdef __GENKSYMS__
+#undef DEFINE_PER_CPU
+#define DEFINE_PER_CPU(type, name) type name##__per_cpu
+#endif /*__GENKSYMS__*/
+
 #endif /* _ASM_GENERIC_PERCPU_H_ */

_
