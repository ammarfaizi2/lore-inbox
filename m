Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVA3BDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVA3BDV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 20:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVA3BDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 20:03:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12525 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261624AbVA3BCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 20:02:33 -0500
Date: Sat, 29 Jan 2005 16:18:21 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org,
       Matthias Koerber <simakoer@cip.informatik.uni-erlangen.de>,
       scott.feldman@intel.com, ganesh.venkatesan@intel.com
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
Message-ID: <20050129181821.GA2128@logos.cnet>
References: <20050128164811.GA8022@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128164811.GA8022@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 05:48:11PM +0100, Michael Gernoth wrote:
> Hi,
> 
> we have about 70 P4 uniprocessor machines (some with Hyperthreading
> capable CPUs) running linux 2.4.29, which are woken up on the weekdays
> by sending a WOL packet to them. The machines all have a E100 nic with
> WOL enabled in the bios. The E100 driver is compiled into the kernel
> and not loaded as a module.
> 
> If the machine which should be woken up is already running (because
> someone switched it on by hand), the WOL packet causes keventd to go
> mad and "use" 100% CPU:
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>     2 root      15   0     0    0    0 R 99.9  0.0 140:50.94 keventd

Probably a task event is rescheduling itself repeatedly? e100 does not seem 
to schedule_task() events directly, so I wonder what is going on.

Can you boot a machine with profile=2, then send the WOL packet causing
keventd to go mad and run:

readprofile | sort -nr +2 | head -20

After a few minutes.

Ganesh, Scott, Jeff, any ideas?

> This can be reproduced on any of the 70 machines by simply sending a WOL
> packet to it, when it's already running... No entry is made in the
> kernel log.
> 
> The dmesg of an affected machine can be found at:
> http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-dmesg
> Our kernel-config is at:
> http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-generic-config
> lspci -vvv is at:
> http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-lspci
> 
> We are using a kernel.org linux 2.4.29 kernel patched with the current
> autofs patch and ACL support.

