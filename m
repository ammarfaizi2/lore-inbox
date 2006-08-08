Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWHHGtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWHHGtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWHHGtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:49:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:64965 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932269AbWHHGtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:49:42 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at  /usr/src/linux-git/kernel/cpu.c:51
Date: Tue, 8 Aug 2006 08:49:37 +0200
User-Agent: KMail/1.9.3
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Dave Jones" <davej@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200608072042_MC3-1-C764-3AF7@compuserve.com> <44D84D1F.76E4.0078.0@novell.com>
In-Reply-To: <44D84D1F.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080849.38012.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >include/asm-i386/unwind.h::arch_unw_user_mode():
> >        return info->regs.eip < PAGE_OFFSET
> >               || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
> >                    && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
> >               || info->regs.esp < PAGE_OFFSET;
> 
> Hmm, indeed. Then I'm unclear what the problem might be here.

That code will check for the vsyscall page, but sysenter_entry isn't 
in the vsyscall page, but in the kernel proper.

So it means the EIP never actually reached the vsyscall page. It should
have gone up another level, but didn't.

-Andi

> 
> >Could this be the problem?
> >
> >|ENTRY(sysenter_entry)
> >|        CFI_STARTPROC simple
> >|        CFI_DEF_CFA esp, 0
> >|==>     CFI_REGISTER esp, ebp
> >|        movl TSS_sysenter_esp0(%esp),%esp
> >|sysenter_past_esp:
