Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbUJZCmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUJZCmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUJZBut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:50:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261930AbUJZBTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:19:25 -0400
Date: Tue, 26 Oct 2004 00:40:09 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Corey Minyard <minyard@acm.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels II
In-Reply-To: <417D786F.4020101@acm.org>
Message-ID: <Pine.LNX.4.58L.0410260031050.10974@blysk.ds.pg.gda.pl>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
 <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl>
 <20041025201758.GG9142@wotan.suse.de> <20041025204144.GA27518@wotan.suse.de>
 <Pine.LNX.4.58L.0410252157440.10974@blysk.ds.pg.gda.pl> <417D786F.4020101@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Corey Minyard wrote:

> If you look at my patch, it does create a shadow index.

 I've noticed, yes.  Actually yours is the right approach as we can't use 
an arbitrary index in the NMI handler -- C register reads from the RTC 
have a side effect of clearing pending interrupts.

> And you need a mutex for SMP systems.  If one processor is handling an 
> NMI, another processor may still be accessing the device.

 Actually this path is meant to be ever accessed by one CPU only (one that
has its LINT1 line enabled), but it may be reached by other ones due to
the NMI watchdog as code does not check if its run by the right processor.  
This probably qualifies as a bug.  Only the watchdog code of the NMI
handler is expected to run everywhere.

> The complexity comes because the claiming of the lock, the CPU that owns 
> the lock, and the index has to be atomic because the NMI handler has to 
> know all these things when the lock is claimed.

 If not the mentioned bug all the hassle wouldn't be needed.

  Maciej
