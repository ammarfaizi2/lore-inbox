Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVFXBjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVFXBjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVFXBjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:39:09 -0400
Received: from palrel13.hp.com ([156.153.255.238]:60067 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262987AbVFXBij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:38:39 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17083.25625.991516.736507@napali.hpl.hp.com>
Date: Thu, 23 Jun 2005 18:38:33 -0700
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux IA64 <linux-ia64@vger.kernel.org>
Subject: Re: [patch][ia64]Refuse kprobe on ivt code
In-Reply-To: <20050623172832.B26121@unix-os.sc.intel.com>
References: <20050623172832.B26121@unix-os.sc.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do the checking based on the .text.ivt section instead (and add
the necessary labels to vmlinux.S and asm-ia64/sections.h).

Thanks,

	--david

>>>>> On Thu, 23 Jun 2005 17:28:33 -0700, Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> said:

  Anil> Subject: Refuse kprobe insert on IVT code

  Anil> Not safe to insert kprobes on IVT code.

  Anil> This patch checks to see if the address on which Kprobes is
  Anil> being inserted is in ivt code and if it is in ivt code then
  Anil> refuse to register kprobe.

  Anil> Signed-off-by: Anil S Keshavamurthy
  Anil> <anil.s.keshavamurthy@intel.com>

  Anil> ===============================================
  Anil> arch/ia64/kernel/kprobes.c | 13 +++++++++++++ 1 files changed,
  Anil> 13 insertions(+)

  Anil> Index: linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
  Anil> ===================================================================
  Anil> --- linux-2.6.12-mm1.orig/arch/ia64/kernel/kprobes.c +++
  Anil> linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c @@ -263,6 +263,13
  Anil> @@ static inline void get_kprobe_inst(bundl } }
 
  Anil> +/* Returns non-zero if the PC is in the Interrupt Vector
  Anil> Table */ +static inline int in_ivt_code(unsigned long pc) +{ +
  Anil> extern char ia64_ivt[]; + return (pc >= (u_long)ia64_ivt && pc
  Anil> < (u_long)ia64_ivt+32768); +} + static int
  Anil> valid_kprobe_addr(int template, int slot, unsigned long addr)
  Anil> { if ((slot > 2) || ((bundle_encoding[template][1] == L) &&
  Anil> slot > 1)) { @@ -271,6 +278,12 @@ static int
  Anil> valid_kprobe_addr(int templat return -EINVAL; }
 
  Anil> + if (in_ivt_code(addr)) { + printk(KERN_WARNING "Kprobes
  Anil> can't be inserted inside " + "IVT code at 0x%lx\n", addr); +
  Anil> return -EINVAL; + } + if (slot == 1) { printk(KERN_WARNING
  Anil> "Inserting kprobes on slot #1 " "is not supported\n"); - To
  Anil> unsubscribe from this list: send the line "unsubscribe
  Anil> linux-ia64" in the body of a message to
  Anil> majordomo@vger.kernel.org More majordomo info at
  Anil> http://vger.kernel.org/majordomo-info.html
