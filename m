Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbTILVkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbTILVkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:40:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:9965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261599AbTILVjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:39:54 -0400
Subject: Re: FYI: dbt testing on 2.6.0-test4-mm4 fails
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Olien <dmo@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mary Edie Meredith <maryedie@osdl.org>
In-Reply-To: <20030903170716.GA23487@osdl.org>
References: <20030903170716.GA23487@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063402792.10866.37.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Sep 2003 14:39:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I have isolated which patch is causing the dpt2 test failures.
The O_SYNC-speedup-nolock-fix.patch appears to be causing the
problem.

2.6.0-test5 passes the dbt2-tier1 STP test.
2.6.0-test5 + O_SYNC-speedup-2.patch (plm #2134) passes.
2.6.0-test5 + O_SYNC-speedup-2.patch + O_SYNC-speedup-nolock-fix.patch
(plm #2135) FAILS.

Dave Olien and I have added some debug output to try and catch writes()
that are returning 0, but the debug output does not seem to match the
errors we are getting from the dbt2 test runs.  We get kernel debug
output on zero byte writes on regular files not on raw files which the
dbt2 test uses.

Any ideas on why/how this patch could be causing problems?

Thanks,

Daniel



On Wed, 2003-09-03 at 10:07, Dave Olien wrote:
> Andrew,
> 
> I'm just mailing you this to keep you informed, Daniel McNeil and
> I are investigating a failure of the dbt database workload test on
> 2.6.0-test4-mm4.
> 
> The failure MAY have begun as early as 2.6.0-test4.  We were able
> to test on test4 only after I generated a patch to raw_open() for that
> kernel version.  The database test4 failure LOOKS the same as the
> test4-mm4 failure.  But we haven't investigated it as closely there yet.
> We know test3 worked OK.  We may try some of the test3-mm patches to
> see if something happened on one of those patches.
> 
> In the test4-mm4 case, the kernel doesn't oops or hang. Instead, the
> database software detects a failure of some sort.  We've done an
> strace on the database processes, and in one of them we see the following
> output:
> 
> _llseek(38, 8192, [8192], SEEK_SET) = 0
> write(38, "\0\0\0\0\4\3\1\0\7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192)                     = 0
> 
> A seek on file descriptor 38 to offset 8192, followed by a write of 8k.
> The write returns with 0 bytes written.
> 
> Immediately after this, we can see this process writing to the error
> log a message indicating an error has been detected.
> 
> File descriptor 38 is for the file /dev/raw/raw1.  This is the
> transaction log file for the database.  This is early in itialization
> of the database, so it's initializing the transaction log file.

