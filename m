Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVA2FRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVA2FRK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 00:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbVA2FRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 00:17:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:44735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262855AbVA2FRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 00:17:05 -0500
Date: Fri, 28 Jan 2005 21:17:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, rohit.seth@intel.com,
       asit.k.mallick@intel.com
Subject: Re: [Discuss][i386] Platform SMIs and their interferance with tsc
 based delay calibration
Message-Id: <20050128211707.28604d58.akpm@osdl.org>
In-Reply-To: <20050128185101.A19117@unix-os.sc.intel.com>
References: <20050128185101.A19117@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't send emails which contain 500-column lines?

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
> Current tsc based delay_calibration can result in significant errors in
> loops_per_jiffy count when the platform events like SMIs (System Management
> Interrupts that are non-maskable) are present.

This seems like an unsolveable problem.

>  Solution:
>  The patch below makes the calibration routine aware of asynchronous events
> like SMIs. We increase the delay calibration time and also identify any
> significant errors (greater than 12.5%) in the calibration and notify it
> to user. Like to know your comments on this.

I find calibrate_delay_tsc() quite confusing.  Are you sure that the
variable names are correct?

 +	tsc_rate_max = (post_end - pre_start) / DELAY_CALIBRATION_TICKS;
 +	tsc_rate_min = (pre_end - post_start) / DELAY_CALIBRATION_TICKS;

that looks strange.  I'm sure it all makes sense if one understands the
algorithm, but it shouldn't be this hard.  Please reissue the patch with
adequate comments which describe what the code is doing.


Shouldn't calibrate_delay_tsc() be __devinit?  (That may generate warnings
from reference_discarded.pl, but they're false positives)


>From a maintainability POV it's not good that x86 is no longer using the
generic calibrate_delay() code.  Can you rework the code so that all
architectures must implement arch_calibrate_delay(), then provide stubs for
all except x86?  After all, other architectures/platforms may have the same
problem.

