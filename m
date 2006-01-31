Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWAaWZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWAaWZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWAaWZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:25:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751564AbWAaWZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:25:06 -0500
Date: Tue, 31 Jan 2006 14:27:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tvec_bases too large for per-cpu data
Message-Id: <20060131142708.2b995f7c.akpm@osdl.org>
In-Reply-To: <43DDDFDD.76F0.0078.0@novell.com>
References: <43CE4C98.76F0.0078.0@novell.com>
	<20060120232500.07f0803a.akpm@osdl.org>
	<43D4BE7F.76F0.0078.0@novell.com>
	<20060123025702.1f116e70.akpm@osdl.org>
	<43DDDFDD.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> Hopefully attached revised patch addresses all concerns mentioned (except that it intentionally continues to not use
> alloc_percpu()).

This remains unaddressed:


+#ifdef CONFIG_NUMA
+			base = kmalloc_node(sizeof(*base), GFP_KERNEL, cpu_to_node(cpu));
+			if (!base)
+				/* Just in case, fall back to normal allocation. */
+#endif
+				base = kmalloc(sizeof(*base), GFP_KERNEL);
+			if (!base)
+				return -ENOMEM;


If we cannot allocate memory on this node for this CPU (wildly unlikely,
btw) we face a choice.  Either

a) Allocate memory from some other node, making the machine mysteriously
   run slower for the remainder of its uptime or

b) Fail the CPU bringup.

I think b) is better - it tells the operator that something went wrong, so
some sort of corrective action can be taken.  I suspect that most operators
would prefer that to having the kernel secretly make their machine run
slower.

