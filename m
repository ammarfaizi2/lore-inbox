Return-Path: <linux-kernel-owner+w=401wt.eu-S965093AbWLMTl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWLMTl2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWLMTl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:41:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36021 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965093AbWLMTl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:41:27 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
Date: Wed, 13 Dec 2006 12:41:10 -0700
In-Reply-To: <1166018020.27217.805.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Wed, 13 Dec 2006 14:53:40 +0100")
Message-ID: <m1lklbport.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> [due to a broken libata in current -git I've not been able to test this patch
> enough]
>
>
> This patch adds an "allowed_affinity" mask to each interrupt, in addition to the
> existing actual affinity mask. In addition this new mask is exported to
> userspace
> in a similar way as the actual affinity is exported. (this is so that irqbalance
> can find out about the restriction and take it into account)
>
> The purpose for having this mask is to allow for the situation where interrupts
> just can't or shouldn't go to all cpus; one example is the "per cpu" IRQ thing 
> that powerpc and others have. Another soon-to-come example is MSIX devices that
> can generate a different MSI interrupt for each cpu; in that case the MSI needs
> to
> be strictly constrained to it's designated cpu.

I don't like this.  If we really have constraints that limit which cpus
we can handle a irqs on we should be taking advantage of them to make
the data structure smaller, not making it bigger. 

This feels like a forced fit.  To fit the situations you describe
into allowed_affinity you have to throw away information.  Such
as the fact it is a NUMA node or a MSI-X interrupt.

In addition the cases I can think of allowed_affinity is the wrong
name.  suggested_affinity sounds like what you are trying to implement
and when it is merely a suggestion and not a hard limit it doesn't
make sense to export like this.

The restriction with MSIX is that we want the irq that describes
the flow of data and the user space process that consumes that flow of
data scheduled on the same cpu.  Yes this is mostly one per cpu but it
is not strictly one per cpu so allowed cpus doesn't make sense in that
case.

The more I think about describing what we are schedule, we are
scheduling a more or less periodic realtime process don't we already
have schedulers in the kernel to schedule this kind of thing?  Don't
we want to take into consideration the cache penalty of migration
before we decided to move the irq to another cpu?

Anyway if we are going to start exporting this kind of information
please let's export the whole context and export it in a way that
applications besides irqbalance can take advantage of.  Otherwise
we are just committing to support a wide kernel/user space interface
for the purposes of a single application and that seems ridiculous.

Eric
