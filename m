Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTAXUxZ>; Fri, 24 Jan 2003 15:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbTAXUxZ>; Fri, 24 Jan 2003 15:53:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:15578 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265675AbTAXUxX>;
	Fri, 24 Jan 2003 15:53:23 -0500
Date: Fri, 24 Jan 2003 13:21:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       schulz@uni-mannheim.de
Subject: Re: [PATCH] to support hookable flush_tlb* functions
Message-Id: <20030124132136.765a420d.akpm@digeo.com>
In-Reply-To: <1043418252.3e314c8d0278a@rumms.uni-mannheim.de>
References: <1043418252.3e314c8d0278a@rumms.uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 21:02:28.0946 (UTC) FILETIME=[E78F6320:01C2C3EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@rumms.uni-mannheim.de> wrote:
>
> Hello,
> 
> with this mail I send a patch that allows kernel modules to hook into the
> different flush_tlb* functions defined in <asm/tlbflush.h> or <asm/pgtable.h> in
> order to synchronize devices TLBs.

Looks sensible enough.

A few coding-style nits:

	+typedef struct tlb_hook_struct {
	+...
	+} tlb_hook_t;

typedefs are unpopular.  Please just use

	struct tlb_hook {
		...
	};

+static inline void flush_tlb_hook( void )

extraneous whitespace - Linus style is flush_tlb_hook(void)

+	while( hook )

	while (hook)

+	{
+		if( hook->flush_tlb )

		if (hook->flush_tlb)

+			hook->flush_tlb( );

			hook->flush_tlb();

etc...



The unregister_hook implementation is racy - the hook could be in use on
another CPU.  That's OK - we have the RCU infrastructure which will allow
hooks to be torn down safely.  And nice people who can help others who are
using that code.

> The i386 patch also includes some cleanups by renaming __flush_tlb_* to
> local_flush_tlb_*.

That makes plenty of sense.

> I hope some time this patches will make it into the kernel sources. (perhaps
> even into 2.6.x ?)

Well the big questions are: where are the drivers for these devices?  When
can we expect to see significant demand for these devices?  Will there be
significant demand across the lifetime of the 2.6 kernel?

BTW, when you say "low latency NICs that will implement direct user space DMA
transfers to not pinned user pages", what do you mean by "not pinned"?

