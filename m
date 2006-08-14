Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWHNSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWHNSNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWHNSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:13:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:46489 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751578AbWHNSNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:13:09 -0400
Date: Mon, 14 Aug 2006 14:11:18 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060814181118.GB2519@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060807235727.GM16231@redhat.com> <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com> <20060809200642.GD7861@redhat.com> <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com> <20060810131323.GB9888@in.ibm.com> <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com> <20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E0AD1D.1040408@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:04:29AM -0700, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >On Thu, Aug 10, 2006 at 02:09:58PM -0600, Eric W. Biederman wrote:
> >>>I just reserved memory at non 2MB aligned location 65MB@15MB so that
> >>>kernel is loaded at 16MB and other smaller segments below the compressed
> >>>image, then I can successfully booted into the kdump kernel.
> >>:)
> >>
> >>>So basically kexec on panic path seems to be clean except stomping issue.
> >>>May be bzImage program header should reflect right "MemSize" which
> >>>takes into account extra memory space calculations.
> >>Yes.  That sounds like the right thing to do.  
> >>
> >>I remember trying to compute a good memsize when I created the bzImage
> >>header but it is completely possible I missed some part of the
> >>calculation or assumed that the kernels .bss section would always be
> >>larger than what I needed for decompression.
> >>
> 
> Could someone please describe the intended semantics of this MemSize 
> header, *and* its intended usage?
>

Now and ELF header(attached to bzImage) is being used to describe
the kernel executable. One program header of PT_LOAD type is being
created. The "p_filesz" field of program header is basically 
describing the vmlinux file size and "p_memsz" is giving how
much memory will be consumed by kernel image at load time.

Ideally "p_memsz" should be "p_memsz" summation of all the program
headers of vmlinux file but I guess in this case we are stretching the
ELF specification a little bit and also taking into the account the
additional memory which will be used by decompressor and decompression
logic by the time execution is transferred to the actual kernel.

The intended usage is currently kexec/kdump. While pre-loading a 
kernel in memory, kexec creates multiple segments and puts various
data into it. (like kernel image, initrd, parameters etc.) Kexec
needs to know how much memory is being used by the loaded kernel so 
that it can place another segment after kernel at a safe distance.
By reading "p_memsz" from ELF header, kexec can determine it.

Currently problem we are facing in kdump case is that parameter
segment (command line and other bootloader parameters) is being
placed immediately after kernel which gets stomped over by decompressor
code and kernel boot fails.

Normal boot never faces this problem as parameter segment is always
loaded below where kernel image is loaded.

Thanks
Vivek

