Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUGBKuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUGBKuG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 06:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUGBKuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 06:50:06 -0400
Received: from ozlabs.org ([203.10.76.45]:7361 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261563AbUGBKuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:50:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16613.15510.325099.273419@cargo.ozlabs.ibm.com>
Date: Fri, 2 Jul 2004 20:44:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
In-Reply-To: <20040701160614.I21634@forte.austin.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com>
	<16610.39955.554139.858593@cargo.ozlabs.ibm.com>
	<20040701160614.I21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas@austin.ibm.com writes:

> Yes, but rtasd starts up late in the book process.  Most of the 
> "interesting" manipulations with firmware are old history by then,
> and thus, any firmware errors encountered during the boot were never 
> logged.

It all makes a lot more sense with the change to set ppc_md.log_error
to pSeries_log_error.  I do wonder why we need a ppc_md function
pointer for that though, given how pSeries-specific the error log
format is.

> If the parms aren't set up, then the rtas_error_log_max is zero,
> and, as a result, the message is never logged.  By initializing
> rtas_error_log_max to the correct non-zero value, the errors can 
> get logged.

This looks to me like the setting of rtas_error_log_max should be done
much earlier, in pSeries_init_early, say.  Shouldn't we be using the
rtas_error_log_max variable in __fetch_rtas_last_error, too, rather
than the constant RTAS_ERROR_LOG_MAX?

> -- So the decision was wisely made to move this all to user-space. 
> But what shall the communications link between user-space and kernel be? 
> Somebody, somewhere,  I know not who or why, decided that they should 
> go into syslog.  And so here we are.

Netlink is the usual solution to this sort of problem.  I think it
would be reasonable to printk RTAS error events with a severity of
fatal and maybe even of error.  Warnings and events should just get
sent to rtasd.

Oh, and it would be useful to have a comment in the code that calls
__fetch_rtas_last_error that says that we are only calling it if the
RTAS call could not perform its function due to a hardware error.  In
other words the -1 return isn't a generic "didn't work" code but more
specifically a "hardware error" code.

Paul.
