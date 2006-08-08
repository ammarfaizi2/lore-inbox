Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWHHGf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWHHGf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWHHGf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:35:56 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:44982
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751250AbWHHGfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:35:55 -0400
Message-Id: <44D84D1F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 08 Aug 2006 07:36:47 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Dave Jones" <davej@redhat.com>,
       "Andi Kleen" <ak@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at 
	/usr/src/linux-git/kernel/cpu.c:51
References: <200608072042_MC3-1-C764-3AF7@compuserve.com>
In-Reply-To: <200608072042_MC3-1-C764-3AF7@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Chuck Ebbert <76306.1226@compuserve.com> 08.08.06 02:39 >>>
>In-Reply-To: <44D7136E.76E4.0078.0@novell.com>
>
>On Mon, 07 Aug 2006 09:18:22 +0100, Jan Beulich wrote:
>
>> >Most likely the CFI annotation for that sysenter path is not complete.
>>
>> Correct, the return point of sysexit (SYSENTER_RETURN) is still in kernel space,
>> but its annotations are invisible to the unwinder. We should make the VDSO be
>> treated as user-mode code despite living above PAGE_OFFSET.
>
>Umm, that's already been done?
>
>include/asm-i386/unwind.h::arch_unw_user_mode():
>        return info->regs.eip < PAGE_OFFSET
>               || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
>                    && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
>               || info->regs.esp < PAGE_OFFSET;

Hmm, indeed. Then I'm unclear what the problem might be here.

>Could this be the problem?
>
>|ENTRY(sysenter_entry)
>|        CFI_STARTPROC simple
>|        CFI_DEF_CFA esp, 0
>|==>     CFI_REGISTER esp, ebp
>|        movl TSS_sysenter_esp0(%esp),%esp
>|sysenter_past_esp:

Clearly not. That is the way the user stack gets communicated to the kernel,
and it would cause problems at earliest in the next outer frame (which is in
user mode, so we don't care anyway). And I know I saw it unwind properly
through the sysenter code in other cases in the past.

>What does that do?  .cfi_register is not documented anywhere, not
>even in the gnu.org online documentation for gas.  (I spent 10
>minutes googling and found nothing other than the changeset that
>added it to gas.)

.cfi_register is the directive equivalent to DW_CFA_register, saying that
on register is spilled to another (rather than to memory) - see the Dwarf2
(or Dwarf3) specification for details.

Jan
