Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTHTUYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbTHTUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:24:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58347 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262246AbTHTUY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:24:28 -0400
Subject: Re: Dumb question: BKL on reboot ?
From: Dave Hansen <haveblue@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Hannes.Reinecke@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030820113520.281fe8bb.davem@redhat.com>
References: <3F434BD1.9050704@suse.de>
	 <20030820112918.0f7ce4fe.akpm@osdl.org>
	 <20030820113520.281fe8bb.davem@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061411024.9371.33.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Aug 2003 13:23:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 11:35, David S. Miller wrote:
> On Wed, 20 Aug 2003 11:29:18 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Where exactly does the rebooting CPU get stuck in machine_restart()?  If
> > someone has done lock_kernel() with local interrupts disabled then yes,
> > it'll deadlock.  But that's unlikely?  Confused.

I thought it was legal to do that.  The normal interrupts-off spinlock
deadlock happens because a thread does a spin_lock() with no irq
disable, then gets interrupted.  The interrupt handler tries to take the
lock, and gets stuck.  

If the BKL is put in that situation, the interrupt handler will see
current->lock_depth > 0, and not actually take the spinlock; it will
just increment the lock_depth.  It won't deadlock.

Or, are you saying that a CPU could have the BKL, and have
stop_this_cpu() called on it?  I guess we could add
release_kernel_lock() to stop_this_cpu().
-- 
Dave Hansen
haveblue@us.ibm.com

