Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWKEXdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWKEXdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWKEXdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:33:21 -0500
Received: from mail.suse.de ([195.135.220.2]:41924 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422809AbWKEXdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:33:20 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [Opps] Invalid opcode
Date: Mon, 6 Nov 2006 00:33:05 +0100
User-Agent: KMail/1.9.5
Cc: caglar@pardus.org.tr, linux-kernel@vger.kernel.org,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611052151.14861.caglar@pardus.org.tr> <454E7008.4020200@vmware.com>
In-Reply-To: <454E7008.4020200@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611060033.06100.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 November 2006 00:13, Zachary Amsden wrote:
> S.Çağlar Onur wrote:
> > Hmm, Novell bugzilla seems has similiar issues, 
> > https://bugzilla.novell.com/show_bug.cgi?id=204647 and its duplicated ones 
> > gaves same or similiar panic outputs.
> >
> >   
> >> Previously we avoided converting i386 cpu bootup fully to the new state
> >> machine because it is very fragile, but it's possible that there
> >> is no other choice than to do it properly. Or maybe another kludge
> >> is possible.
> >>     
> 
> Yes, this is some kind of softirq race during init.

Yes, the callbacks run at the wrong time. Unlike modern architectures
i386 doesn't do callback cpu boot callback repeat, but boot all cpus then callback.

But the strange thing is that the BP hits it. Normally the new CPU
hit it because it tried to run a timer interrupt before the callback
ran and initialized all the per CPU state (this happened often
when dual core CPUs were first introduced for some reason)

In this case it looks like the AP managed to queue a tasklet before 
the cpu up callback runs.

I suppose we'll either need to convert i386 really over to standard
cpu_up() or add some additional spinlocks to stop the APs with interrupts
off before the callbacks start to run.

-Andi
