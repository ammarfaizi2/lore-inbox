Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVBQNCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVBQNCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVBQNCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:02:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31219 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262149AbVBQNBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:01:46 -0500
Message-ID: <421495B3.3050106@mvista.com>
Date: Thu, 17 Feb 2005 05:01:39 -0800
From: Frank Rowand <frowand@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Realtime preempt support for PPC
References: <200502162056.j1GKuIkt005783@localhost.localdomain> <20050217080304.GA21887@elte.hu>
In-Reply-To: <20050217080304.GA21887@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Frank Rowand <frowand@mvista.com> wrote:
> 
> 
>>I have attached a patch to add realtime support for PowerPC (32 bit
>>only). [...]
> 
> 
> two comments:
> 
> - why is us_to_tb needed? It just seems to add alot of unnecessary
>   clutter to the patch, while it's not used anywhere.

Sorry, the usage of us_to_tb got dropped from the patch when I moved
it from one of my development trees to another.  It gets used in
usecs_to_cycles().  The patch to add that is attached below.

Even with the usage of us_to_tb by usecs_to_cycles(), there is a lot
of added clutter for what is accomplished.  I considered a nasty hack
to try to derive the proper value from other sources, but adding
us_to_tb seemed a lot easier to understand.

This patch also adds the dreaded #ifdefs, so I suspect it will not be
the correct implementation long term.  I'm not sure if Manish's patch
included the ARM implementation of usecs_to_cycles() - it is a third
case in the #ifdef.

Performance instrumentation is also going to need mcount() and
_mcount(), which is currently a work in progress.

> 
> - could you submit the drivers/net/ibm_emac/ibm_emac_core.c patch
>   upstream as well?

Yes, I will do that.


> 
> otherwise it looks pretty clean and straightforward.
> 
> 	Ingo


Source: MontaVista Software, Inc.
Signed-off-by: Frank Rowand <frowand@mvista.com>

Index: linux-2.6.10/kernel/latency.c
===================================================================
--- linux-2.6.10.orig/kernel/latency.c
+++ linux-2.6.10/kernel/latency.c
@@ -192,7 +192,11 @@ static unsigned long notrace cycles_to_u

  static cycles_t notrace usecs_to_cycles(unsigned long delta)
  {
+#if defined CONFIG_X86
  	return (cycles_t) delta * (cycles_t) (cpu_khz/1000+1);
+#elif defined(CONFIG_PPC)
+	return delta * us_to_tb;
+#endif
  }

  #ifdef CONFIG_LATENCY_TRACE



Thanks,

-Frank (off to vacation for a couple days)
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

