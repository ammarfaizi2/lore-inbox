Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTBHAxC>; Fri, 7 Feb 2003 19:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbTBHAxB>; Fri, 7 Feb 2003 19:53:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:54525 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id <S266939AbTBHAw7>;
	Fri, 7 Feb 2003 19:52:59 -0500
Date: Fri, 7 Feb 2003 17:02:40 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: jsun@mvista.com
Subject: a race condition in SMP TLB flushing code?
Message-ID: <20030207170240.A27605@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were chasing a bug in MIPS/SMP TLB part, and noticed that
i386 may have a race condition in the same area.

Here is the scenario how it may happen:

cpu A:
        call flush_tlb_mm()
        find out cpu_vm_mask set for cpu B (cpu_mask != 0)

cpu B:
        inside schedule(), calling switch_mm()
        clear cpu_vm_mask bit for current mm, trying
        stop ipi for flushing tlb

cpu A:
        oops, but it is a little too late.  already
        checked cpu_vm_mask, and send an ipi to cpu B for
        flushing tlb anyway.

cpu B:
        get the ipi and (WITHOUT CHECKING cpu_vm_mask again)
        go ahead doing tlb flushing.

I am not sure if any disastrous result will happen, but apparently
an unintended flush has happened.  In MIPS such a hole could
cause two processes using the same TLB entries which yields all kinds
of interesting crashes.

BTW, I am looking at the 2.4.19 kernel.  Please cc your reply to my
email address.  Thanks.

Jun
