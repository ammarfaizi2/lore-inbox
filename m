Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTFCVI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbTFCVI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 17:08:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1290 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261328AbTFCVI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 17:08:28 -0400
Date: Tue, 3 Jun 2003 22:21:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>, davidm@hpl.hp.com
Subject: Re: no-omit-frame-pointer for sched.c in 2.4-i386
Message-ID: <20030603222152.A18010@flint.arm.linux.org.uk>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	davidm@hpl.hp.com
References: <20030603210617.GE3661@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030603210617.GE3661@werewolf.able.es>; from jamagallon@able.es on Tue, Jun 03, 2003 at 11:06:17PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 11:06:17PM +0200, J.A. Magallon wrote:
> Hi all...
> 
> Any body knows if this still applies:
> 
> kernel/Makefile
> 
> ifneq ($(CONFIG_IA64),y)
> # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
> # needed for x86 only.  Why this used to be enabled for all architectures is beyond
> # me.  I suspect most platforms don't need this, but until we know that for sure
> # I turn this off for IA-64 only.  Andreas Schwab says it's also needed on m68k
> # to get a correct value for the wait-channel (WCHAN in ps). --davidm
> CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
> endif

This comment is not accurate.  It's also needed for ARM so that it can
use the framepointer to walk up the frame pointer list to discovered where
we called schedule from (excluding such stuff as the semaphore
implementation.)

Actually, come to think of it, I suspect its buggy today anyway; GCC 3
has some interesting "features" in that -fno-omit-frame-pointer does
not mean it will not omit it.  Certainly on ARM, we need extra options
to ensure that GCC outputs the frame in a parseable manner.

So yes, something _like_ this is needed.  Maybe the right solution would
be to do something like:

	CFLAGS_sched.o	:= $(EXTRA_CALLTRACE_FLAGS)

and architectures can define EXTRA_CALLTRACE_FLAGS appropriately.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

