Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWGJKPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWGJKPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGJKPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:15:54 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:60139 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1751398AbWGJKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:15:54 -0400
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe kdump
	(2.6.18-rc1-i386) - safe_smp_processor_id
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Keith Owens <kaos@ocs.com.au>
Cc: akpm@osdl.org, James.Bottomley@steeleye.com,
       "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <5742.1152520068@ocs3.ocs.com.au>
References: <5742.1152520068@ocs3.ocs.com.au>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Mon, 10 Jul 2006 19:15:50 +0900
Message-Id: <1152526550.3003.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

Thank you for the comments.

On Mon, 2006-07-10 at 18:27 +1000, Keith Owens wrote:
> Fernando Luis Vazquez Cao (on Mon, 10 Jul 2006 16:50:52 +0900) wrote:
> >On the event of a stack overflow critical data that usually resides at
> >the bottom of the stack is likely to be stomped and, consequently, its
> >use should be avoided.
> >
> >In particular, in the i386 and IA64 architectures the macro
> >smp_processor_id ultimately makes use of the "cpu" member of struct
> >thread_info which resides at the bottom of the stack. x86_64, on the
> >other hand, is not affected by this problem because it benefits from
> >the use of the PDA infrastructure.
> >
> >To circumvent this problem I suggest implementing
> >"safe_smp_processor_id()" (it already exists in x86_64) for i386 and
> >IA64 and use it as a replacement for smp_processor_id in the reboot path
> >to the dump capture kernel. This is a possible implementation for i386.
> 
> I agree with avoiding the use of thread_info when the stack might be
> corrupt.  However your patch results in reading apic data and scanning
> NR_CPU sized tables for each IPI that is sent, which will slow down the
> sending of all IPIs, not just dump.
This patch only affects IPIs sent using send_IPI_allbutself which is
rarely called, so the impact in performance should be negligible.

> It would be far cheaper to define
> a per-cpu variable containing the logical cpu number, set that variable
> once as each cpu is brought up and just read it in cases where you
> might not trust the integrity of struct thread_info.  safe_smp_processor_id()
> resolves to just a read of the per cpu variable.
But to read a per-cpu variable you need to index the corresponding array
with processor id of the current CPU (see code below), but that is
precisely what we are trying to figure out. Anyway as
send_IPI_allbutself is not a fast path (correct if this assumption is
wrong) the current implementation of safe_smp_processor_id should be
fine.

#define get_cpu_var(var) (*({ preempt_disable();
&__get_cpu_var(var); }))
#define __get_cpu_var(var) per_cpu(var, smp_processor_id())

Am I missing something obvious?

Regards,

Fernando

