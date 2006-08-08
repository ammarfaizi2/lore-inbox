Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWHHApo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWHHApo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWHHApo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:45:44 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:17881 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932465AbWHHApn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:45:43 -0400
Date: Mon, 7 Aug 2006 20:39:59 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
  /usr/src/linux-git/kernel/cpu.c:51
To: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Dave Jones <davej@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200608072042_MC3-1-C764-3AF7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44D7136E.76E4.0078.0@novell.com>

On Mon, 07 Aug 2006 09:18:22 +0100, Jan Beulich wrote:

> >Most likely the CFI annotation for that sysenter path is not complete.
>
> Correct, the return point of sysexit (SYSENTER_RETURN) is still in kernel space,
> but its annotations are invisible to the unwinder. We should make the VDSO be
> treated as user-mode code despite living above PAGE_OFFSET.

Umm, that's already been done?

include/asm-i386/unwind.h::arch_unw_user_mode():
        return info->regs.eip < PAGE_OFFSET
               || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
                    && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
               || info->regs.esp < PAGE_OFFSET;


Could this be the problem?

|ENTRY(sysenter_entry)
|        CFI_STARTPROC simple
|        CFI_DEF_CFA esp, 0
|==>     CFI_REGISTER esp, ebp
|        movl TSS_sysenter_esp0(%esp),%esp
|sysenter_past_esp:

What does that do?  .cfi_register is not documented anywhere, not
even in the gnu.org online documentation for gas.  (I spent 10
minutes googling and found nothing other than the changeset that
added it to gas.)

-- 
Chuck

