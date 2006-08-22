Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWHVO1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWHVO1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWHVO1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:27:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751396AbWHVO1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:27:18 -0400
Date: Tue, 22 Aug 2006 07:26:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Greg KH <gregkh@suse.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Lockdep message on workqueue_mutex
Message-Id: <20060822072656.b1a28a85.akpm@osdl.org>
In-Reply-To: <1156250192.2976.47.camel@laptopd505.fenrus.org>
References: <20060822121042.GA29577@osiris.boeblingen.de.ibm.com>
	<1156250192.2976.47.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 14:36:32 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Tue, 2006-08-22 at 14:10 +0200, Heiko Carstens wrote:
> > git commit 9b41ea7289a589993d3daabc61f999b4147872c4 causes the lockdep
> > message below on cpu hotplug (git kernel of today).
> > 
> > We have:
> > 
> > cpu_down (takes cpu_add_remove_lock)
> > [CPU_DOWN_PREPARE]
> > blocking_notifier_call_chain (takes (cpu_chain).rwsem)
> > workqueue_cpu_callback (takes workqueue_mutex)
> > blocking_notifier_call_chain (releases (cpu_chain).rwsem)
> > [CPU_DEAD]
> > blocking_notifier_call_chain (takes (cpu_chain).rwsem)
> >                               ^^^^^^^^^^^^^^^^^^^^^^^
> > -> reverse locking order, since we still hold workqueue_mutex.
> > 
> > But since all of this is protected by the cpu_add_remove_lock this looks
> > legal. Well, at least it's safe as long as no other cpu callback function
> > does anything that will take the workqueue_mutex as well.
> 
> so you're saying this locking is entirely redundant ? ;-)

Nope, not all code paths which access the data which is protected by
workqueue_mutex take cpu_add_remove_lock.

Simplifying it, we have:

	blocking_notifier_call_chain()
	->down_read(cpu_chain.rwsem)
	->workqueue_cpu_callback()
	  ->mutex_lock(workqueue_mutex)
	->up_read(cpu_chain.rwsem)

	blocking_notifier_call_chain()
	->down_read(cpu_chain.rwsem)
	->workqueue_cpu_callback()
	  ->mutex_unlock(workqueue_mutex)
	->up_read(cpu_chain.rwsem)

Which is OK as long as nobody runs cpu_up() or cpu_down() while holding
workqueue_mutex.
