Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVBYPkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVBYPkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVBYPkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:40:22 -0500
Received: from relay.axxeo.de ([213.239.199.237]:42916 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262729AbVBYPj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:39:59 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: Xterm Hangs - Possible scheduler defect?
Date: Fri, 25 Feb 2005 16:39:50 +0100
User-Agent: KMail/1.7.1
Cc: "Chad N. Tindel" <chad@tindel.net>, Paulo Marques <pmarques@grupopie.com>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050224075756.GA18639@calma.pair.com> <200502250151.41793.ioe-lkml@axxeo.de> <421F4042.3020302@nortel.com>
In-Reply-To: <421F4042.3020302@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502251639.50238.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Ingo Oeser wrote:
> > Stupid applications can starve other applications for a while, but not
> > forever, because the kernel is still running and deciding.
>
> Not so.
>
>
>
> task 1: sched_rr, priority 1, takes mutex
> task 2: sched_rr, priority 2, cpu hog, infinite loop
> task 3: sched_rr, priority 99, tries to get mutex
>
> And now tasks 1 and 3 are starved forever.  Arguably bad application
> design, but it demonstrates a case where applications can starve other
> applications.

You are right.
 
In "If a SCHED_RR process has been running for a time period  equal  to  or 
longer  than  the  time quantum,  it  will  be  put at the end of the list for
its priority" I missed the "for its priority" part.

You would need to change the priority of task 1 until it releases the
mutex. Ideally the owner gets the maximum priority of
his and all the waiters on it, until it releases his mutex, where he regains
its old priority after release of mutex. But this priority elevation happens
only, if he is runnable. If not, he gets his old priority back, until he is 
runnable.

But then again you just need to grab a mutex shared with a high priority
task and consume CPU.

Since this behavior is not defined in POSIX AFAIK, you just have
to write your applications properly or use SCHED_OTHER for CPU hogging.


Regards

Ingo Oeser

