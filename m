Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTEACJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 22:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTEACJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 22:09:07 -0400
Received: from [12.47.58.20] ([12.47.58.20]:22663 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262073AbTEACJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 22:09:01 -0400
Date: Wed, 30 Apr 2003 19:22:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] clustered apic irq affinity fix for i386
Message-Id: <20030430192205.13491d61.akpm@digeo.com>
In-Reply-To: <1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
	<20030430163637.04f06ba6.akpm@digeo.com>
	<1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 02:21:15.0921 (UTC) FILETIME=[57C82810:01C30F88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Mannthey <kmannth@us.ibm.com> wrote:
>
> This should be better. Thanks for the comments. 

Remind me again what the patch actually does?  It seems to be purely adding
debug checks?

Won't it just go BUG if someone boots the kernel and then tries to manually
set affinity?

Seems a bit racy too. setup_ioapic_dest() does:

                        pending_irq_balance_apicid[irq] = mask;
        ==> window here
                        set_ioapic_affinity(irq, mask);

ioapic_lock is not held, so there is a window where
pending_irq_balance_apicid[irq] can be set to some other value and
io_apic_write_affinity() will accidentally go BUG.


Is it not possible to fix set_ioapic_affinity() for real for clustered APIC
mode?  What is involved in that?

