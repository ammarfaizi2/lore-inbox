Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUBOUYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 15:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbUBOUYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 15:24:38 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:40096 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265188AbUBOUYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 15:24:36 -0500
Subject: kthread vs. dm-daemon (was: Oopsing cryptoapi (or loop device?) on
	2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joe Thornber <thornber@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040215194633.A8948@infradead.org>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
Content-Type: text/plain
Message-Id: <1076876668.21968.22.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 21:24:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 15.02.2004 schrieb Christoph Hellwig um 20:46:

> > The only reason, I guess, is that it depends on this very small
> > dm-daemon thing:
> > http://people.sistina.com/~thornber/dm/patches/2.6-unstable/2.6.2/2.6.2-udm1/00016.patch
>
> Well, actually the above code should not enter the kernel tree at all.
> Care to rewrite dm-crypt to use Rusty's kthread code in -mm instead and
> submit a patch to Andrew?  Whenever he merges the kthread stuff to mainline
> he could just include dm-crypt then.

Sure I could.

But kthread is currently not a full replacement for dm-daemon. kthread
provides thread creation and destruction functions. But dm-daemon
additionaly does mainloop handling.

Usually, the dm-daemon client adds some work to a list under a spinlock
and calls dm_daemon_wake. The next time the thread runs it calls the
client work function which usually just grabs the whole list and
processes it.
The client work function can also indicate it wants periodic wakeup
using a return value which is currently used in the multipath target but
it's not sure whether this will be moved to a userspace daemon.

There seems to beg a small race conditition that can appear when using
only wake_up for notifies so dm-daemon uses an additional atomic_t
variable to make sure nothing gets missed. Just see the function
``daemon'' in dm-daemon.c.

Making dm-daemon use the kthread primitives would make dm-daemon a very
small and stupid wrapper. Changing all dm targets to handle worker
thread notification themselves would result in unnecessary code
duplication.

It seems to me that this functionality could perhaps be somehow added to
kthread without changing it too much... ?

I would like to double-check with Joe rushing forward on my own.


