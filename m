Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbUKVTAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbUKVTAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUKVS7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:59:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44261 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262344AbUKVS4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:56:37 -0500
Message-ID: <41A23662.40305@sgi.com>
Date: Mon, 22 Nov 2004 12:56:34 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andreas Schwab <schwab@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads
References: <41A20AF3.9030408@sgi.com> <20041122162214.GE21861@wotan.suse.de> <jept25yggg.fsf@sykes.suse.de> <20041122165425.GG21861@wotan.suse.de>
In-Reply-To: <20041122165425.GG21861@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Nov 22, 2004 at 05:51:59PM +0100, Andreas Schwab wrote:
> 
>>Andi Kleen <ak@suse.de> writes:
>>
>>
>>>At least in traditional signal semantics you have to call sigaction
>>>or signal in each signal handler to reset the signal. So that 
>>>assumption is not necessarily true.
>>
>>If you use sigaction then you get POSIX semantics, which don't have this
>>problem.
> 
> 
> It's just a common case where Ray's assumption is not true.
> 
> -Andi
> 

True enough.  And in that case the design that I was describing wouldn't
make sigaction() that much more expensive since if you are not in the POSIX
thread environment (more precisely, the thread was not created with
CLONE_SIGHAND) each thread has its own sighand structure and the "global" 
locking mechanisum I had proposed would only require the taking of one 
additional lock.

However, special casing ITIMER_PROF is also a reasonable avenue of approach.
The performance monitor code can also deliver signals to user space when
a sampling buffer overflows, and this can have the same kind of scaling
problem as ITIMER_PROF.  I'll have to do a little research to figure out
how exactly that works, but that signal (SIGIO?) would also be a candidate
for special casing on our platform.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
