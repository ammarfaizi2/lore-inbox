Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUAKLuK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbUAKLuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:50:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4876 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265844AbUAKLuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:50:00 -0500
Date: Sun, 11 Jan 2004 11:49:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA lockups on HP Pavilion laptop
Message-ID: <20040111114956.B1931@flint.arm.linux.org.uk>
Mail-Followup-To: Aubin LaBrosse <arl8778@rit.edu>,
	linux-kernel@vger.kernel.org
References: <1073191980.1505.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073191980.1505.32.camel@localhost.localdomain>; from arl8778@rit.edu on Sat, Jan 03, 2004 at 11:53:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 11:53:00PM -0500, Aubin LaBrosse wrote:
> when the redhat pcmcia script is run, the laptop locks up solid.  sysrq
> is enabled but i have not tried it yet, i'd have to look up the keys and
> what they do.

Alt-Sysrq-Space will give you a summary, if the system is still alive
enough to accept sysrq.

> regardless, i have traced the problem to cardmgr itself,
> cardctl works alright though it can't provide much info on the card.  I
> have pcmcia modularized as is most of the redhat kernel, and the modules
> pcmcia_core, yenta_socket and ds are loaded.  when cardmgr runs, it
> locks the box up when it is inside the adjust_resources function in
> cardmgr.c

I suspect it may be another case where the kernel resource subsystem
doesn't actually know the full story of which ports are in use.
Chances are you're hitting some sort of system management port which
is then causing the system to lock up.

> the way in which i determined that cardmgr was at fault was by running
> it by hand, simply cardmgr -v.  I then traced it down further by adding
> fprintfs to stderr to cardmgr.c - the specific line from which my box
> never returns is 
> 
>  ret = ioctl(fd, DS_ADJUST_RESOURCE_INFO, &al->adj);
> 
> in adjust_resources() in cardmgr.c
> the resource being adjusted is an io-range resource, and it's the second
> one in the linked list that crashes my box, the first one succeeds just
> fine

You could try finding out exactly which IO port(s) are causing the
problem by tweaking your PCMCIA config.opts file, by doing a binary
search in the affected IO region, and then reporting the result here.
The output of dmidecode and lspci -vxxx may also be useful.

Note that PCMCIA performs IO probes using a granularity of 8 bytes,
so there's no point going below that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
