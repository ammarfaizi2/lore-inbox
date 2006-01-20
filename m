Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWATNUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWATNUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWATNUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:20:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5827 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750943AbWATNUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:20:08 -0500
Date: Fri, 20 Jan 2006 08:20:06 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       ak@suse.de, fastboot@lists.osdl.org
Subject: Re: [PATCH 0/5] stack overflow safe kdump (2.6.15-i386)
Message-ID: <20060120132006.GF4695@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1137417795.2256.83.camel@localhost.localdomain> <20060118015649.GE23143@in.ibm.com> <1137650875.2985.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137650875.2985.39.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 03:07:55PM +0900, Fernando Luis Vazquez Cao wrote:
> > >    -> Regarding the implementation, I have some doubts:
> > >       - Should the NMI vector replaced atomically?
> > >       - Should the NMI watchdog be stopped? Should NMIs be disabled in the crash
> > >         path of each CPU?
> > >       This is important because after replacing the nmi handler the NMI
> > >       watchdog will continue generating interrupts that need to be handled
> > >       properly. If we can avoid this a kdump-specific nmi vector handler
> > >       (ENTRY(crash_nmi)) could be safely used.
> > 
> > Can we have something like per cpu flag which will be set if NMI is received
> > after crash (after replacing the trap vector). If another NMI occurs on 
> > the same cpu and if flag is set, return and don't process it further.
> The problem is that when one CPU crashes in a SMP system and the NMI
> watchdog is enabled, the others will continue receiving NMI from the
> watchdog and will eventually also receive the NMI from the crashing CPU.
> The NMI handler has to be able to process both adequately if we cannot
> stop the NMI watchdog atomically. Even if we used such a flag we would
> need to figure out the originator of the NMI.
> 

Well, once system has crashed we have replaced the NMI callback with
crash_nmi_callback(), I would tend to think that there might not be 
any need to differentiate between various NMIs.

Though disabling other NMIs is the right way to handle it, but if there is
no straight easy way to do that then, even if I executed the
crash_nmi_callback() due to NMI originating from other source than NMI IPI
from crashing cpu, probably should be ok.
