Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWJGGgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWJGGgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 02:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWJGGgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 02:36:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932612AbWJGGgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 02:36:20 -0400
Date: Fri, 6 Oct 2006 23:35:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 1/12] i386: Distinguish absolute symbols
Message-Id: <20061006233547.43888a48.akpm@osdl.org>
In-Reply-To: <20061003170413.GA3164@in.ibm.com>
References: <20061003170032.GA30036@in.ibm.com>
	<20061003170413.GA3164@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 13:04:13 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> Ld knows about 2 kinds of symbols,  absolute and section
> relative.  Section relative symbols symbols change value
> when a section is moved and absolute symbols do not.
> 
> Currently in the linker script we have several labels
> marking the beginning and ending of sections that
> are outside of sections, making them absolute symbols.
> Having a mixture of absolute and section relative
> symbols refereing to the same data is currently harmless
> but it is confusing.
> 
> This must be done carefully as newer revs of ld do not place
> symbols that appear in sections without data and instead
> ld makes those symbols global :(
> 
> My ultimate goal is to build a relocatable kernel.  The
> safest and least intrusive technique is to generate
> relocation entries so the kernel can be relocated at load
> time.  The only penalty would be an increase in the size
> of the kernel binary.  The problem is that if absolute and
> relocatable symbols are not properly specified absolute symbols
> will be relocated or section relative symbols won't be, which
> is fatal.
> 
> The practical motivation is that when generating kernels that
> will run from a reserved area for analyzing what caused
> a kernel panic, it is simpler if you don't need to hard code
> the physical memory location they will run at, especially
> for the distributions.

This patch causes the following warnings:

/opt/crosstool/gcc-4.1.0-glibc-2.3.6/i686-unknown-linux-gnu/bin/i686-unknown-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section `.smp_altinstr_replacement' not in segment
/opt/crosstool/gcc-4.1.0-glibc-2.3.6/i686-unknown-linux-gnu/bin/i686-unknown-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section `.smp_altinstr_replacement' not in segment
/opt/crosstool/gcc-4.1.0-glibc-2.3.6/i686-unknown-linux-gnu/bin/i686-unknown-linux-gnu-ld: vmlinux: warning: allocated section `.smp_altinstr_replacement' not in segment

The patch
i386-force-section-size-to-be-non-zero-to-prevent-a-symbol-becoming-absolute.patch
makes those warnings go away again, but we decided to drop that.

This:

  .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
	*(.smp_altinstr_replacement)
	. = ALIGN(4096);
	__smp_alt_end = .;
  }

looks odd.  What's the point in putting a gap before __smp_alt_end?  Moving
__smp_alt_end to before the ALIGN doesn't prevent the warning.

GNU ld version 2.16.1, gcc-4.1.0, config at
http://userweb.kernel.org/~akpm/config-vmm.txt

