Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934264AbWLAH2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934264AbWLAH2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934293AbWLAH2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:28:37 -0500
Received: from 1wt.eu ([62.212.114.60]:13061 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S934264AbWLAH2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:28:36 -0500
Date: Fri, 1 Dec 2006 08:28:16 +0100
From: Willy Tarreau <w@1wt.eu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, ak@suse.de
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Message-ID: <20061201072816.GA16684@1wt.eu>
References: <20061201052653.GB11835@1wt.eu> <23790.1164954762@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23790.1164954762@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 05:32:42PM +1100, Keith Owens wrote:
> Willy Tarreau (on Fri, 1 Dec 2006 06:26:53 +0100) wrote:
> >On Fri, Dec 01, 2006 at 04:14:04PM +1100, Keith Owens wrote:
> >> SuSE's SLES10 ships with gcc 4.1.0.  There is nothing to stop a
> >> distributor from backporting the bug fix from gcc 4.1.1 to 4.1.0, but
> >> this patch would not allow the fixed compiler to build the kernel.
> >
> >Then maybe replace #error with #warning ? It's too dangerous to let people
> >build their kernel with a known broken compiler without being informed.
> 
> Agreed.
> 
> >I think this shows the limit of backports to known broken versions.
> >Providing a full update to 4.1.1 would certainly be cleaner for all
> >customers than backporting 4.1.1 to 4.1.0 and calling it 4.1.0.
> 
> Agreed, but Enterprise customers expect bug fixes, not wholesale
> replacements of critical programs.

Oh, I'm perfectly aware of this. That's in part why I started the hotfix
branch in the past :-) But sometimes, fixes consist in merging all the
patches from the maintenance branch (eg: from 4.1.0 to 4.1.1), and if
this is the case, there would not be much justification not to simply
update the version. In fact, what's really missing is a "fixlevel" in
the packages, to inform the user that 4.1.0 as shipped by the distro
has the same level of fixes as 4.1.1. But this is what the version is
used for today.

> >Another solution would be to be able to check gcc for known bugs in the
> >makefile, just like we check it for specific options. But I don't know
> >how we can check gcc for bad code, especially in cross-compile environments
> 
> It is doable, but it is as ugly as hell.  Note the lack of a
> signed-off-by :)

Yes it's ugly, but at least it's a proposal. We might need something like
this as a more generic solution across all architectures to easily check
for such known problems. It's somewhat comparable to runtime fixups but
here it's build time fixups.

Regards,
Willy

> ---
>  arch/i386/kernel/Makefile |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> Index: linux/arch/i386/kernel/Makefile
> ===================================================================
> --- linux.orig/arch/i386/kernel/Makefile
> +++ linux/arch/i386/kernel/Makefile
> @@ -83,3 +83,19 @@ $(obj)/vsyscall-syms.o: $(src)/vsyscall.
>  k8-y                      += ../../x86_64/kernel/k8.o
>  stacktrace-y		  += ../../x86_64/kernel/stacktrace.o
>  
> +# Some versions of gcc generate invalid code for hpet_timer, depending
> +# on other config options.  Make sure that the generated code is valid.
> +# Invalid versions of gcc generate a tight loop in wait_hpet_tick, with
> +# no 'cmp' instructions.  Extract the generated object code for
> +# wait_hpet_tick, down to the next function then check that the code
> +# contains at least one comparison.
> +
> +ifeq ($(CONFIG_HPET_TIMER),y)
> +$(obj)/built-in.o: $(obj)/.tmp_check_gcc_bug
> +
> +$(obj)/.tmp_check_gcc_bug: $(obj)/time_hpet.o
> +	$(Q)[ -n "`$(OBJDUMP) -Sr $< | grep -A40 '<wait_hpet_tick>:' | sed -e '1d; />:$$/,$$d;' | grep -w cmp`" ] || \
> +		(echo gcc volatile bug detected, fix your gcc; exit 1)
> +	$(Q)touch $@
> +
> +endif
