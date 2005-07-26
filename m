Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVGZVcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVGZVcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVGZV3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:29:49 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:63958 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262050AbVGZV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:27:59 -0400
Date: Tue, 26 Jul 2005 17:23:45 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200507261727_MC3-1-A5A1-F8AB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 at 11:13:21 -0700 (PDT), Linus Torvalds wrote:

> Something like the following (totally untested) should make it be
> non-lazy. It's going to slow down normal task switches, but might speed up 
> the "restoring FP context all the time" case.
> 
> Chuck? This should work fine with or without your inline thing. Does it 
> make any difference?

 Now that I am looking at the right output file -- yes, it does (after fixing
one small bug.)  Volanomark set a new record of 6125 messages/sec and the
profile shows almost zero hits in math_state_restore.

 Since fxsave leaves the FPU state intact, there ought to be a better way to do
this but it gets tricky.  Maybe using the TSC to put a timestamp in every thread
save area?

  when saving FPU state:
        put cpu# and timestamp in thread state info
        also store timestamp in per-cpu data

  on task switch:
        compare cpu# and timestamps for next task
        if equal, clear TS and set TS_USEDFPU

  when state becomes invalid for some reason:
        zero cpu's timestamp

But the extra overhead might be too much in many cases.


(Below is what I changed in the original patch, if anyone wants to try it.)

+               if (tsk_used_math(next_p))

should be:

+               if (!tsk_used_math(next_p))

__
Chuck
