Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVEDBN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVEDBN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 21:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVEDBN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 21:13:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64228 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261964AbVEDBNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 21:13:02 -0400
Date: Tue, 3 May 2005 21:13:37 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty races
In-Reply-To: <20050503175023.627bd904.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505032101540.22921@dhcp83-105.boston.redhat.com>
References: <Pine.LNX.4.61.0504201227370.13902@dhcp83-105.boston.redhat.com>
 <20050425232251.6ffac97c.akpm@osdl.org> <Pine.LNX.4.61.0504260922001.26392@dhcp83-105.boston.redhat.com>
 <20050502232721.19dde63d.akpm@osdl.org> <Pine.LNX.4.61.0505030923560.10633@dhcp83-105.boston.redhat.com>
 <20050503175023.627bd904.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 May 2005, Andrew Morton wrote:

> > > We want to move away from lock_kernel()-based locking.
> > > 
> > 
> > I completely agree, but unfortunately lock_kernel() is currently used 
> > extensively throughout the tty layer. 
> 
> Well no - it's being migrated over to use tty_sem.  We shouldn't start
> heading in the reverse direction.  Plus your patch reverts part of
> http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/char/tty_io.c@1.156?nav=index.html|src/|src/drivers|src/drivers/char|hist/drivers/char/tty_io.c
> in ways which might be unsafe.
> 

The patch I proposed does not add any lock_kernel() based locking. The 
only locking it adds is more tty_sem based locking to cover the 
driver->open() method. I agree though that it relies on the BKL for 
correctness.

Indeed, that is precisely that patch which introduced the problems I've 
pointed out.

> > lock_kernel() is used extensively throughout the tty layer. We can 
> > re-write the locking for the layer, but I'd like to see this bug fix in 
> > 2.6.12, if that isn't done in time.
> 
> Sorry, but AFAICT all you have done is to advocate for the existing patch
> without having attempted to fix this problem with tty_sem.  Please try to
> come up with a tty_sem-based fix.
> 

The patch I proposed fixes the open vs. open race using the tty_sem. The 
open vs. close race is closed by removing locking. Less locking seems 
better to me. 

If you're still not happy, I'll wrap the close path in the tty_sem...

thanks,

-Jason


