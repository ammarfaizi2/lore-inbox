Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTABAmy>; Wed, 1 Jan 2003 19:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbTABAmy>; Wed, 1 Jan 2003 19:42:54 -0500
Received: from ns.netrox.net ([64.118.231.130]:33023 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S265243AbTABAmx>;
	Wed, 1 Jan 2003 19:42:53 -0500
Subject: Re: Does cli() need to be called before reading avenrun?
From: Robert Love <rml@tech9.net>
To: Peter Benie <Peter.Benie@mvhi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15891.35418.412034.594225@server.axiom.internal>
References: <15891.35418.412034.594225@server.axiom.internal>
Content-Type: text/plain
Organization: 
Message-Id: <1041468799.1126.8.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 01 Jan 2003 19:53:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-01 at 19:39, Peter Benie wrote:
> In kernel 2.4, in sys_sysinfo(), the code reads:
> 
>    cli();
>    val.uptime = jiffies / HZ;
> 
>    val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
>    val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
>    val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
> 
>    val.procs = nr_threads-1;
>    sti();
> 
> In loadavg_read_proc, the code is in essence the same, except that it
> isn't wrapped in cli/sti.  
> 
> Is there a reason for the cli?

Interrupts off protects the reading of avenrun[] - it is only written to
from the timer interrupt, so you can safely read it when interrupts are
disabled.

The reason we need some sort of protection is that there are the three
array entries, so we need to make sure we read all three atomically (not
that its a huge deal if we do not).

So I guess the proc code needs to disable interrupts, too.  I am on my
laptop and only have a 2.5 tree - sure it is not disabled somewhere in
there?

Note in 2.5 we replaced the cli() with a read_lock() on xtime_lock.

	Robert Love

