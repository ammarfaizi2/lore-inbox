Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUINNSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUINNSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269371AbUINNSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:18:04 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:24509 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269344AbUINNPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:15:09 -0400
Subject: Re: [patch] sched, tty: fix scheduling latencies in tty_io.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040914122748.GA6846@elte.hu>
References: <20040914101904.GD24622@elte.hu>
	 <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu>
	 <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <1095159217.16572.29.camel@localhost.localdomain>
	 <20040914120016.GA5422@elte.hu>
	 <1095160687.16572.34.camel@localhost.localdomain>
	 <20040914122748.GA6846@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095163891.16520.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 13:11:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 13:27, Ingo Molnar wrote:
> would it be a sufficient fix to grab some sort of tty_sem mutex in the
> places where the patch drops the BKL - or are there other entry paths to
> this code?

There are a whole load of entry points. I've been trying to document all
the ldisc layer stuff as I fix the basic bugs in it. A semaphore isnt
sufficient because some of the entry points have to be multi-entry so
you'd need to go modify all the ldisc internals (I think that will have
to happen eventually). It also relies on it for read v write locking
still.

So far all I've fixed is the vfs/ldisc locking to ensure that open/close
and other events are properly sequenced. I've not yet finished tackling
the ldisc/driver cases where driver->close() completes and the ldisc
calls the driver still.

At that point its at least then down to the drivers to get fixed.

