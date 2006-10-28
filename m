Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWJ1Qtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWJ1Qtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 12:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWJ1Qtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 12:49:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751061AbWJ1Qty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 12:49:54 -0400
Date: Sat, 28 Oct 2006 09:49:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, ego@in.ibm.com,
       vatsa@in.ibm.com,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>, shai@scalex86.org
Subject: Re: [rfc] [patch] mm: Slab - Eliminate lock_cpu_hotplug from slab
Message-Id: <20061028094931.65a0f218.akpm@osdl.org>
In-Reply-To: <20061028011919.GA4653@localhost.localdomain>
References: <20061028011919.GA4653@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 18:19:19 -0700
Ravikiran G Thirumalai <kiran@scalex86.org> wrote:

> Another note.  Looks like a cpu hotplug event can send  CPU_UP_CANCELED to
> a registered subsystem even if the subsystem did not receive CPU_UP_PREPARE.
> This could be due to a subsystem registered for notification earlier than
> the current subsystem crapping out with NOTIFY_BAD. Badness can occur with
> in the CPU_UP_CANCELED code path at slab if this happens (The same would
> apply for workqueue.c as well).

yup, cancellation doesn't work at present.

>  To overcome this, we might have to use either
> a) a per subsystem flag and avoid handling of CPU_UP_CANCELED, or
> b) Use a special notifier events like LOCK_ACQUIRE/RELEASE as Gautham was
>    using in his experiments, or
> c) Do not send CPU_UP_CANCELED to a subsystem which did not receive
>    CPU_UP_PREPARE.
> 
> I would prefer c).

c) would work.  I guess we could do that by simply counting the number of
called handlers rather than having to record state within each one.

It would require changes to the notifier_chain API, but I think the changes
are needed - the problem is general.  Something like:


int __raw_notifier_call_chain(struct raw_notifier_head *nh,
		unsigned long val, void *v, unsigned nr_to_call, int *nr_called);

int raw_notifier_call_chain(struct raw_notifier_head *nh,
		unsigned long val, void *v)
{
	return __raw_notifier_call_chain(nh, val, v, -1, NULL);
}


