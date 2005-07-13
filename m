Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVGMGsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVGMGsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 02:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVGMGsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 02:48:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2185 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262251AbVGMGrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 02:47:47 -0400
Date: Wed, 13 Jul 2005 08:47:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Scott <nathans@sgi.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: RT and XFS
Message-ID: <20050713064739.GD12661@elte.hu>
References: <1121209293.26644.8.camel@dhcp153.mvista.com> <20050713002556.GA980@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713002556.GA980@frodo>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Scott <nathans@sgi.com> wrote:

> On Tue, Jul 12, 2005 at 04:01:32PM -0700, Daniel Walker wrote:
> > 
> > Is there something so odd about the XFS locking, that it can't use the
> > rt_lock ?
> 
> Not that I know of - XFS does use the downgrade_write interface, whose 
> use isn't overly common in the rest of the kernel... maybe that has 
> caused some confusion, dunno.

downgrade_write() wasnt the main problem - the main problem was that for 
PREEMPT_RT i implemented 'strict' semaphores, which are not identical to 
vanilla kernel semaphores. The thing that seemed to impact XFS the most 
is the 'acquirer thread has to release the lock' rule of strict 
semaphores.  Both the XFS logging code and the XFS IO completion code 
seems to release locks in a different context from where the acquire 
happened. It's of course valid upstream behavior, but without these 
extra rules it's hard to do sane priority inheritance. (who do you boost 
if you dont really know who 'owns' the lock?) It might make sense to 
introduce some sort of sem_pass_to(new_owner) interface? For now i 
introduced a compat type, which lets those semaphores fall back to the 
vanilla implementation.

	Ingo
