Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUHOGwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUHOGwf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 02:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHOGwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 02:52:31 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:7566 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266509AbUHOGwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 02:52:30 -0400
Message-ID: <411F08D1.7060400@colorfullife.com>
Date: Sun, 15 Aug 2004 08:55:13 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@fsmlabs.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] smp_call_function WARN_ON
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane wrote:

>The WARN_ON() is really only true if you're waiting for the other
>processors.
>
>  
>
Wrong: At least on i386 the code always waits for delivery of the IPI, 
it just doesn't wait for completion of the callback.
Do you need IPIs from irq or bh context? It would be tricky to change 
the current code: an IPI just delivers an interrupt without any payload. 
The global 'call_data' variable contains the description of the IPI and 
accesses to it must be synchronized.

IPIs from BH context do no work either: they can deadlock against the 
tasklist_lock: the first cpu calls read_lock(&tasklist_lock) from 
process context, another cpu calls write_lock_irq(&tasklist_lock), and 
then the first cpu tries smp_call_function() from bh context.

--
    Manfred
