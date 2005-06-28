Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVF1OWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVF1OWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVF1OUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:20:54 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:62628 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261600AbVF1OTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:19:00 -0400
Date: Tue, 28 Jun 2005 08:22:24 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel()
 calls
In-Reply-To: <20050627050206.GA2139@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0506271305290.12042@montezuma.fsmlabs.com>
References: <20050618002021.GA2892@us.ibm.com>
 <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
 <20050627050206.GA2139@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Sun, 26 Jun 2005, Paul E. McKenney wrote:

> How does the following look for NMI-RCU documentation?

That looks good, there is just one bit i'm not entirely sure about and i'd 
appreciate it if you could entertain me for a bit;

Answer to Quick Quiz

        Why might the rcu_dereference() be necessary on Alpha, given
        that the code reference by the pointer is read-only?

        Answer: The caller to set_nmi_callback() might well have
                initialized some data that is to be used by the
                new NMI handler.  In this case, the rcu_dereference()
                would be needed, because otherwise a CPU that received
                an NMI just after the new handler was set might see
                the pointer to the new NMI handler, but the old
                pre-initialized version of the handler's data.

Reading that i would think the general programming model for this would 
be;

setup data
write barrier
setup callback

Isn't that still required considering the following scenario;

CPU0			CPU1
setup data		<NMI>
setup callback		...
...			call callback

on i386, interrupts are data synchronising events, however if we happen to 
take an interrupt right when the data is being setup we won't synchronise 
with respect to that data. This could be achieved via the explicit write 
barrier after data setup or rcu_dereference in the NMI handler. Or perhaps 
i'm missing something?

Thanks!
	Zwane

