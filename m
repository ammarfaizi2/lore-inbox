Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUHJBfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUHJBfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUHJBfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:35:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267387AbUHJBbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:31:21 -0400
Date: Mon, 9 Aug 2004 21:28:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mike Becher <Mike.Becher@lrz-muenchen.de>
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com, bjorn.helgaas@hp.com
Subject: Re: ptrace problem on ia64 with kernel 2.4.26
Message-ID: <20040810002808.GA9121@logos.cnet>
References: <Pine.LNX.4.58.0408050827430.7618@lxmbe01.lrz.lrz-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408050827430.7618@lxmbe01.lrz.lrz-muenchen.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Woh, I've got no clue, but I believe the check you are hitting is:

ia64/kernel/ptrace.c sys_ptrace():

        /* read the word at location addr in the USER area. */
        case PTRACE_PEEKUSR: {
                unsigned long tmp;
                                                                                      
                ret = -EIO;
                if ((addr & 3) || addr < 0 ||
                    addr > sizeof(struct user) - 3)
                        break;
		***********************************
                                                                                      
                tmp = 0;  /* Default return condition */
                if(addr < FRAME_SIZE*sizeof(long))
                        tmp = getreg(child, addr);
                if(addr >= (long) &dummy->u_debugreg[0] &&
                   addr <= (long) &dummy->u_debugreg[7]){
                        addr -= (long) &dummy->u_debugreg[0];
                        addr = addr >> 2;
                        tmp = child->thread.debugreg[addr];
                }
                ret = put_user(tmp,(unsigned long *) data);
                break;
        }

Can you show us the address which is being passed to successful ptrace's 
and to the failed ones?

Bjorn, David?


On Thu, Aug 05, 2004 at 12:06:08PM +0200, Mike Becher wrote:
> Hi,
> 
> on our Linux IA64 cluster we got the problem that tools like strace, gdb, 
> ddd, and other debugging tools, which depend on ptrace system call, don't
> work after some days of uptime of a node. I have searched already in the 
> web about information relating to that problem but haven't found any answer. 
> 
> description:
> ------------
> On a node that got the problem (when it runs longer than 3 days) strace 
> produce this output:
>   [mibe@lxsrv154]# strace /bin/true
>   execve("/bin/true", ["/bin/true"], [/* 38 vars */]) = 0
>   upeek: ptrace(PTRACE_PEEKUSER, ... ): Input/output error
> Instead on a `younger' node or fresh booted node strace works fine.
> 
> To find out what is differnt I have used also the `utrace' tool
> (http://www.gelato.unsw.edu.au/IA64wiki/utrace) with a small
> modification to peek info about register r4.
> 
> diff utrace.c.orig utrace.c
> 62c62
> <   long scnum, result, error, val;
> ---
> >   long scnum, result, result_r4, error, val;
> 74a75
> >   result_r4 = ptrace (PTRACE_PEEKUSER, child_pid, PT_R4, 0);
> 
> With this register starts the critical area of ptrace for debuggers
> when problem exists. They all don't do their work because they cannot
> gather information about some registers like r4, r5, r6, r7.
> Also it doesn't work for user `root'.
> Whether in messages files nor in /proc filesystem nor with dmesg I
> have found any info that can give me a hint what has changed. 
> 
> configuration:
> --------------
> We use the following configuration:
> * kernel 2.4.26 (vanilla kernel) with 
>   - official linux-2.4.26-ia64-040510.diff.bz2 (11-May-2004 11:18)
>   - EXPORT_SYMBOL_NOVERS(iosapic_fixup_pci_interrupt) in
>     linux-2.4.26/arch/ia64/kernel/ia64_ksyms.c
>   - commented out 
>      printk(KERN_WARNING "%s(%d): floating-point assist...)
>     in linux-2.4.26/arch/ia64/kernel/traps.c
>   - BitKeeper patch which fixes x86 "clear_cpu()" macro.
>     on line 34 to >>> asm volatile("fnclex ; fwait");
> * openafs 1.2.11
> * Myrinet driver GM build ID is "1.6.4_Linux_and_AIX
> * PVFS 1.6.2 with pvfs-1.6.2-01292004.patch
> * following modules are loaded:
>   [mibe@lxsrv154 ia64]# lsmod
>   Module                  Size  Used by    Tainted: PF
>   pvfs                  147336   7
>   imb                    43024   0
>   gm                    620176   1  (autoclean)
>   libafs-2.4.26.mp     1296528   2
>   e1000                 170976   1
>   nls_iso8859-1           6000   1  (autoclean)
>   nls_cp437               7680   1  (autoclean)
>   usbkbd                  9040   0  (unused)
>   ehci-hcd               54872   0  (unused)
>   usb-uhci               66888   0  (unused)
>   usbcore               182800   1  [usbkbd ehci-hcd usb-uhci]
>   aacraid                95512   7
>   sd_mod                 33856  14
> 
> Hope someone can help me to solve this problem.
> 
> best regards,
>   Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
