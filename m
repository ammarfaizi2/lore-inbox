Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTEFVoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTEFVoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:44:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:44766 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261998AbTEFVom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:44:42 -0400
Subject: Re: [RFC][Patch] fix for irq_affinity_write_proc v2.5
From: Keith Mannthey <kmannth@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
References: <1052247789.16886.261.camel@dyn9-47-17-180.beaverton.ibm.com> 
	<1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 May 2003 14:58:01 -0700
Message-Id: <1052258283.19335.307.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why should the kernel be enforcing policy here. You have to be root to 
> do this, and root should have the ability to configure apparently stupid
> things because they may find them useful.

  What the kernel does now seems incorrect.  
  With kirqd runnig (irqbalance_disable == 0) the kernel writes an
arbitrary cpu mask to the ioapic.  The kirqd thread only maps the irq to
a single cpu at at time.  Mapping an irq to multiple cpus breaks this
ideal.  A root user could destroy what kirqd is doing for them by trying
to set affinity which writes to the ioapic directly.  Let kirqd manage
the affinity. (NOTE: I suspect that do_irq_balance might not set
affinity until the irq needs to be balance and am looking for a better
thing to do.)     
  Also if a user writes an arbitrary cpu map to the ioapic next time the
irq need to be balanced by kirqd their value will be overwritten.  The
affinity defined in irq_affinity array will still be valid but the
mapping the user wrote to the ioapic will be destroyed.
  This seems to be a loose loose situation.  If users want to do map
irqs to multiple cpus, at the ioapic level, they should user their root
privileges to boot with noirqbalance.  If kirqd is running the should
let it do most of the work. 

Keith  
    

