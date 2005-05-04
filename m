Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVEDAvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVEDAvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 20:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVEDAvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 20:51:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:33245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261956AbVEDAu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 20:50:57 -0400
Date: Tue, 3 May 2005 17:50:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty races
Message-Id: <20050503175023.627bd904.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0505030923560.10633@dhcp83-105.boston.redhat.com>
References: <Pine.LNX.4.61.0504201227370.13902@dhcp83-105.boston.redhat.com>
	<20050425232251.6ffac97c.akpm@osdl.org>
	<Pine.LNX.4.61.0504260922001.26392@dhcp83-105.boston.redhat.com>
	<20050502232721.19dde63d.akpm@osdl.org>
	<Pine.LNX.4.61.0505030923560.10633@dhcp83-105.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron <jbaron@redhat.com> wrote:
>
> > 
> > I don't see anywhere which takes lock_kernel() on the tty_open() path.
> > 
> 
> fs/char_dev.c:chrdev_open():        
> 
> 	if (filp->f_op->open) {
>                 lock_kernel();
>                 ret = filp->f_op->open(inode,filp);
>                 unlock_kernel();
>         }
> 

hm, we're still doing that.

> > 
> > We want to move away from lock_kernel()-based locking.
> > 
> 
> I completely agree, but unfortunately lock_kernel() is currently used 
> extensively throughout the tty layer. 

Well no - it's being migrated over to use tty_sem.  We shouldn't start
heading in the reverse direction.  Plus your patch reverts part of
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/char/tty_io.c@1.156?nav=index.html|src/|src/drivers|src/drivers/char|hist/drivers/char/tty_io.c
in ways which might be unsafe.

> lock_kernel() is used extensively throughout the tty layer. We can 
> re-write the locking for the layer, but I'd like to see this bug fix in 
> 2.6.12, if that isn't done in time.

Sorry, but AFAICT all you have done is to advocate for the existing patch
without having attempted to fix this problem with tty_sem.  Please try to
come up with a tty_sem-based fix.
