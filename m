Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285366AbRLGE6M>; Thu, 6 Dec 2001 23:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285377AbRLGE6C>; Thu, 6 Dec 2001 23:58:02 -0500
Received: from holomorphy.com ([216.36.33.161]:1668 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285370AbRLGE5t>;
	Thu, 6 Dec 2001 23:57:49 -0500
Date: Thu, 6 Dec 2001 20:57:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: proc_pid_statm
Message-ID: <20011206205746.C818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206134150.A818@holomorphy.com> <3C1040C3.20601@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3C1040C3.20601@wipro.com>; from balbir.singh@wipro.com on Fri, Dec 07, 2001 at 09:38:35AM +0530
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 09:38:35AM +0530, BALBIR SINGH wrote:
> I looked at ELF_ET_DYN_BASE and it is defined differently on
> different architectures. For example on an i386, it is defined
> to be 2GB which is 0x80000000.
> On ia64 it is defined as (TASK_UNMAPPED_BASE + 0x1000000).
> I would *dare* suggest that since all shared libraries are
> mmapped, the correct value to compare against in your patch is
> TASK_UNMAPPED_BASE.

Well, it should be different. My analysis was that the libraries
were loaded above the ELF interpreter. I believe your assessment
is more accurate.

On Fri, Dec 07, 2001 at 09:38:35AM +0530, BALBIR SINGH wrote:
> On my i386, the ldd output and looking at /proc/<pid>/maps
> justifies this.
> 
> ldd -d /bin/ls
>         libtermcap.so.2 => /lib/libtermcap.so.2 (0x4002d000)
>         libc.so.6 => /lib/i686/libc.so.6 (0x40031000)
>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
> 
> 
> ld-linux.so.2 is loaded at TASK_UNMAPPED_BASE. Again, let me
> remind you that I am speculating, so please correct me if u think
> I am wrong.

TASK_UNMAPPED_BASE is what the m68k tree uses as well. I'll roll a
fresh version of the patch using that instead.

Oddly, on i386 the following definitions are used:

include/asm-i386/processor.h:273:#define TASK_UNMAPPED_BASE     (TASK_SIZE / 3)
include/asm-i386/elf.h:58:#define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)

so only one of us can be correct here, and it appears to be you:

include/asm-i386/processor.h:268:#define TASK_SIZE      (PAGE_OFFSET)

and 3*0x40000000 == 0xC0000000 == PAGE_OFFSET

Cheers,
Bill
