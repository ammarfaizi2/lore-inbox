Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286203AbRLJJiP>; Mon, 10 Dec 2001 04:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286204AbRLJJiG>; Mon, 10 Dec 2001 04:38:06 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:34569 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S286203AbRLJJhr>;
	Mon, 10 Dec 2001 04:37:47 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112100937.fBA9bdh109019@saturn.cs.uml.edu>
Subject: Re: [PATCH] proc-based cpu affinity user interface
To: rml@tech9.net (Robert Love)
Date: Mon, 10 Dec 2001 04:37:39 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        colpatch@us.ibm.com (Matthew Dobson), linux-kernel@vger.kernel.org
In-Reply-To: <1007973633.874.38.camel@phantasy> from "Robert Love" at Dec 10, 2001 03:40:32 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
> On Mon, 2001-12-10 at 03:33, Albert D. Cahalan wrote:

>> It looks like you are limiting the number of CPUs to sizeof(long).
>> Must you? Using "%lx" would be better in any case. Considering that
>> you may outgrow the format, maybe this info doesn't belong in the
>> /proc/*/stat files at all. For "ps" usage, a simple flag to indicate
>> if the process is locked to a CPU would be OK. There are 3 cases
>> of interest:
>
> We already limit it... we use cpus_allowed and cpus_runnable which are
> unsigned long.

Those can be changed without screwing up user code. You need to
be very careful about what you put in /proc, because user apps
will come to rely on whatever you choose.

Look at what happened with signals in /proc/*/stat. They were
originally reported as "%lu", just like you did. Then the kernel
was extended to support more than 32 signals on 32-bit hardware.
The format was briefly changed to be 16 hex chars, but this
broke lots of stuff. So now /proc/*/stat just reports the low
numbered signals as it did before, and /proc/*/status has the
rest of the signals.

So let's predict:

Around 2.5.42, IBM will have 60-way x86 or 80-way ppc64.
Then the kernel will be hacked to report a hex string of
arbitrary length, and user apps will die left and right.
Somebody will then hack things back to decimal, reporting
only the low sizeof(long)*8 processors in /proc/*/stat.
Any additional processors may be found as a hex string in
/proc/*/status, with the /proc/*/stat data useless on a
system with very many processors.


