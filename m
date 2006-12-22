Return-Path: <linux-kernel-owner+w=401wt.eu-S1751830AbWLVSmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWLVSmz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 13:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWLVSmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 13:42:55 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:34461 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbWLVSmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 13:42:54 -0500
Date: Fri, 22 Dec 2006 19:42:24 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222184224.GK31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Thu, Dec 21, 2006 at 04:04:04PM +0800, Zhang, Yanmin wrote:
> I couldn't reproduce it on my EM64T machine. I instrumented function start_kernel and
> didn't find irq was enabled before calling init_IRQ. It'll be better if the reporter could
> instrument function start_kernel to capture which function enables irq.

I can confirm this is a *GENERIC* X86_64 problem:
----
Kernel command line: console=tty0 console=ttyS0,115200 hdb=noprobe root=/dev/md0
init/main.c start_kernel(): interrupts were disabled@525
ide_setup: hdb=noprobe
init/main.c start_kernel(): interrupts were enabled@529
...
start_kernel(): bug: interrupts were enabled early
----
This is on a dell 1950 with a core 2 duo processors.

You have to have ide compiled in, and set ide options to get the irq's enabled,
and then have a setup which will have an irq pending before the irq controller
get's initialized to get the panic. The dell1950 does not panic, the kernel
merely warns.

I am pretty sure the i386 tree has the same problem but I haven't checked yet.
Anyway: the panic is just a way of noticing. The bug is that irq's are enabled
before the irq controller is set up.

But to make the ide_setup/irq bug go away, I think it might be an acceptable
solution to just disable the irq's again after the parse_args, and just to wait
until the SATA tree takes over the IDE tree.

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
