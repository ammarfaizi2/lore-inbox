Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTBLKQ5>; Wed, 12 Feb 2003 05:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTBLKQ5>; Wed, 12 Feb 2003 05:16:57 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:12672 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S266987AbTBLKQ4>; Wed, 12 Feb 2003 05:16:56 -0500
Date: Wed, 12 Feb 2003 10:27:41 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212102741.GC10422@bjl1.jlokier.co.uk>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212075048.GA9049@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212075048.GA9049@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> +	/* FIXME should disable preemption here but how can we reenable it? */
> +
> +	enable_sysenter();
> +

Try this:

	1. Disable preemption in do_sys_vm86(), at the same place as
	   disable_sysenter() is called.

	2. Enable preemption in save_v86_state(), and put the call
	   to enable_sysenter() there.

	3. In restore_sigcontext() [signal.c], _iff_ the VM flag
	   is set in the restored context, call disable_sysenter()
	   and also disable preemption.

That should make vm86 simply disable preemption while it is activated.
It is not as nice as actually being preemptible, but safe first,
optimise later.

The return path to vm86 mode has the peculiar property of not doing
the need_resched test, unlike the return path to normal user space,
which is a boon here.

-- Jamie

