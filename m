Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752049AbWFWU5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbWFWU5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbWFWU5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:57:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:26304 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752049AbWFWU5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:57:00 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rt1 - mm_struct leak
Date: Fri, 23 Jun 2006 13:56:56 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060618070641.GA6759@elte.hu>
In-Reply-To: <20060618070641.GA6759@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231356.56267.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 00:06, Ingo Molnar wrote:
> i have released the 2.6.17-rt1 tree, which can be downloaded from the
> usual place:

I was given a test case to run that seemed to cause the machine to run the 
OOM-killer after a bunch of iterations.  The test was run like:

$ for ((i=0;i<50000;i++)); do ./test; done

and somewhere in there, the LowFree would drop very low and the test and the 
bash shell running it would get killed.  And then since that didn't free up 
much memory, the machine would become very unresponsive and would have to be 
rebooted.

I don't have the source for the test myself and I am still trying to reproduce 
it, but from what I have gathered, there is a problem cleaning up after 
tasks.  I monitored the machine with slabtop while running the loop and found 
that the size-32, pgd, pgm, and mm_struct slabs caches were constantly 
growing while task_struct stayed where it should be.  At one point, there 
were  127 task_structs and 3530 mm_structs.

I am still trying to figure out what is going on here, but I thought I might 
throw this out there to see if anyone else has seen anything like this.  And 
possibly pointers for how to track it down.  Right now I am trying to trace 
down a possible mismatch between mmget and mmput in the process exit code.  I 
will let you know what I find.

--Vernon
