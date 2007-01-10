Return-Path: <linux-kernel-owner+w=401wt.eu-S932720AbXAJFh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbXAJFh7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbXAJFh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:37:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:36068 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932718AbXAJFhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:37:13 -0500
Date: Wed, 10 Jan 2007 11:07:05 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Horms <horms@verge.net.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Kdump documentation update for 2.6.20
Message-ID: <20070110053705.GA4051@in.ibm.com>
Reply-To: mohan@in.ibm.com
References: <20070108075803.GB7889@in.ibm.com> <20070109011846.GB7479@verge.net.au> <20070109144708.GA6924@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109144708.GA6924@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 08:17:08PM +0530, Vivek Goyal wrote:
> 
> Mohan, Can you please check the correctness of ppc64 specific details.
>

Vivek,

My inputs.
 
> > > +   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
> > > +
> > > +If you are using a relocatable kernel (method 2), then use
> > > +following command.
> > >
> > > +   kexec -p <bzImage-of-relocatable-kernel> \
> > > +   --initrd=<initrd-for-relocatable-kernel> \
> > > +   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
> >
> > --args-linux is not needed on ia64, but its kernel is relocatable.
> > I think the important point is that if you are using a bzImage,
> > then you need --args-linux, and basically at this point that
> > means an i386 (or x86_64) relocatable bzImage.
> >
> 
> I am hoping it --args-linux will be required while loading vmlinux on
> IA64? Because this is ELF file specific option. And this interface should
> be common across all the architectures.
> 
> > Then again, I could be wrong, I'm not sure that I understand
> > --args-linux, I just know that I'm not using it :)
> 
> 
> Thanks
> Vivek
> 
> 
> o Kdump documentation update.
> 	- Update details for using relocatable kernel.
> 	- Start using kexec-tools-testing release as it is latest and old
> 	  kexec-tools can't load relocatable bzImage file.
> 	- Also add kdump on ia64 specific details.
> 
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
> 
>  Documentation/kdump/kdump.txt |  221 +++++++++++++++++++++++++++++-------------
>  1 file changed, 153 insertions(+), 68 deletions(-)
> 
> diff -puN Documentation/kdump/kdump.txt~kdump-documentation-update Documentation/kdump/kdump.txt
> --- linux-2.6.20-rc2-mm1-reloc/Documentation/kdump/kdump.txt~kdump-documentation-update	2007-01-08 12:32:55.000000000 +0530
> +++ linux-2.6.20-rc2-mm1-reloc-root/Documentation/kdump/kdump.txt	2007-01-09 19:57:06.000000000 +0530
> @@ -17,7 +17,7 @@ You can use common Linux commands, such
>  memory image to a dump file on the local disk, or across the network to
>  a remote system.
> 
> -Kdump and kexec are currently supported on the x86, x86_64, and ppc64
> +Kdump and kexec are currently supported on the x86, x86_64, ppc64 and IA64
>  architectures.
> 
>  When the system kernel boots, it reserves a small section of memory for
> @@ -54,59 +54,64 @@ memory," in two ways:
>  Setup and Installation
>  ======================
> 
> -Install kexec-tools and the Kdump patch
> ----------------------------------------
> +Install kexec-tools
> +-------------------
> 
>  1) Login as the root user.
> 
>  2) Download the kexec-tools user-space package from the following URL:
> 
> -   http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz
> +http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing-20061214.tar.gz
> 
> -3) Unpack the tarball with the tar command, as follows:
> -
> -   tar xvpzf kexec-tools-1.101.tar.gz
> -
> -4) Download the latest consolidated Kdump patch from the following URL:
> +Note: Latest kexec-tools-testing git tree is available at
> 
> -   http://lse.sourceforge.net/kdump/
> +git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
> +or
> +http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools-testing.git;a=summary
> 
> -   (This location is being used until all the user-space Kdump patches
> -   are integrated with the kexec-tools package.)
> -
> -5) Change to the kexec-tools-1.101 directory, as follows:
> +3) Unpack the tarball with the tar command, as follows:
> 
> -   cd kexec-tools-1.101
> +   tar xvpzf kexec-tools-testing-20061214.tar.gz
> 
> -6) Apply the consolidated patch to the kexec-tools-1.101 source tree
> -   with the patch command, as follows. (Modify the path to the downloaded
> -   patch as necessary.)
> +4) Change to the kexec-tools-1.101 directory, as follows:
> 
> -   patch -p1 < /path-to-kdump-patch/kexec-tools-1.101-kdump.patch
> +   cd kexec-tools-testing-20061214
> 
> -7) Configure the package, as follows:
> +5) Configure the package, as follows:
> 
>     ./configure
> 
> -8) Compile the package, as follows:
> +6) Compile the package, as follows:
> 
>     make
> 
> -9) Install the package, as follows:
> +7) Install the package, as follows:
> 
>     make install
> 
> 
> -Download and build the system and dump-capture kernels
> -------------------------------------------------------
> +Build the system and dump-capture kernels
> +-----------------------------------------
> +There are two possible methods of using Kdump.
> +
> +1) Build a separate custom dump-capture kernel for capturing the
> +   kernel core dump.
> +
> +2) Or use the system kernel binary itself as dump-capture kernel and there is
> +   no need to build a separate dump-capture kernel. This is possible
> +   only with the architecutres which support a relocatable kernel. As
> +   of today i386 and ia64 architectures support relocatable kernel.
> +
> +Building a relocatable kernel is advantageous from the point of view that
> +one does not have to build a second kernel for capturing the dump. But
> +at the same time one might want to build a custom dump capture kernel
> +suitable to his needs.
> 
> -Download the mainline (vanilla) kernel source code (2.6.13-rc1 or newer)
> -from http://www.kernel.org. Two kernels must be built: a system kernel
> -and a dump-capture kernel. Use the following steps to configure these
> -kernels with the necessary kexec and Kdump features:
> +Following are the configuration setting required for system and
> +dump-capture kernels for enabling kdump support.
> 
> -System kernel
> --------------
> +System kernel config options
> +----------------------------
> 
>  1) Enable "kexec system call" in "Processor type and features."
> 
> @@ -132,88 +137,169 @@ System kernel
>     analysis tools require a vmlinux with debug symbols in order to read
>     and analyze a dump file.
> 
> -4) Make and install the kernel and its modules. Update the boot loader
> -   (such as grub, yaboot, or lilo) configuration files as necessary.
> +Dump-capture kernel config options (Arch Independent)
> +-----------------------------------------------------
> 
> -5) Boot the system kernel with the boot parameter "crashkernel=Y@X",
> -   where Y specifies how much memory to reserve for the dump-capture kernel
> -   and X specifies the beginning of this reserved memory. For example,
> -   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
> -   starting at physical address 0x01000000 for the dump-capture kernel.
> +1) Enable "kernel crash dumps" support under "Processor type and
> +   features":
> 
> -   On x86 and x86_64, use "crashkernel=64M@16M".
> +   CONFIG_CRASH_DUMP=y
> 
> -   On ppc64, use "crashkernel=128M@32M".
> +2) Enable "/proc/vmcore support" under "Filesystems" -> "Pseudo filesystems".
> +
> +   CONFIG_PROC_VMCORE=y
> +   (CONFIG_PROC_VMCORE is set by default when CONFIG_CRASH_DUMP is selected.)
> +
> +Dump-capture kernel config options (Arch Dependent, i386)
> +--------------------------------------------------------
> +1) On x86, enable high memory support under "Processor type and
> +   features":
> 
> +   CONFIG_HIGHMEM64G=y
> +   or
> +   CONFIG_HIGHMEM4G
> 
> -The dump-capture kernel
> ------------------------
> +2) On x86 and x86_64, disable symmetric multi-processing support
> +   under "Processor type and features":
> 
> -1) Under "General setup," append "-kdump" to the current string in
> -   "Local version."
> +   CONFIG_SMP=n
> 
> -2) On x86, enable high memory support under "Processor type and
> +   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
> +   when loading the dump-capture kernel, see section "Load the Dump-capture
> +   Kernel".)
> +
> +3) If one wants to build and use a relocatable kernel,
> +   Enable "Build a relocatable kernel" support under "Processor type and
> +   features"
> +
> +   CONFIG_RELOCATABLE=y
> +
> +4) Use a suitable value for "Physical address where the kernel is
> +   loaded" (under "Processor type and features"). This only appears when
> +   "kernel crash dumps" is enabled. A suitable value depends upon
> +   whether kernel is relocatable or not.
> +
> +   If you are using a relocatable kernel use CONFIG_PHYSICAL_START=0x100000
> +   This will compile the kernel for physical address 1MB, but given the fact
> +   kernel is relocatable, it can be run from any physical address hence
> +   kexec boot loader will load it in memory region reserved for dump-capture
> +   kernel.
> +
> +   Otherwise it should be the start of memory region reserved for
> +   second kernel using boot parameter "crashkernel=Y@X". Here X is
> +   start of memory region reserved for dump-capture kernel.
> +   Generally X is 16MB (0x1000000). So you can set
> +   CONFIG_PHYSICAL_START=0x1000000
> +
> +5) Make and install the kernel and its modules. DO NOT add this kernel
> +   to the boot loader configuration files.
> +
> +Dump-capture kernel config options (Arch Dependent, x86_64)
> +----------------------------------------------------------
> +1) On x86, enable high memory support under "Processor type and
>     features":
> 
>     CONFIG_HIGHMEM64G=y
>     or
>     CONFIG_HIGHMEM4G
> 
> -3) On x86 and x86_64, disable symmetric multi-processing support
> +2) On x86 and x86_64, disable symmetric multi-processing support
>     under "Processor type and features":
> 
>     CONFIG_SMP=n
> +
>     (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
>     when loading the dump-capture kernel, see section "Load the Dump-capture
>     Kernel".)
> 
> -4) On ppc64, disable NUMA support and enable EMBEDDED support:
> +3) Use a suitable value for "Physical address where the kernel is
> +   loaded" (under "Processor type and features"). This only appears when
> +   "kernel crash dumps" is enabled. By default this value is 0x1000000
> +   (16MB). It should be the same as X in the "crashkernel=Y@X" boot
> +   parameter.
> +
> +   For x86_64, normally "CONFIG_PHYSICAL_START=0x1000000".
> +
> +4) Make and install the kernel and its modules. DO NOT add this kernel
> +   to the boot loader configuration files.
> +
> +Dump-capture kernel config options (Arch Dependent, ppc64)
> +----------------------------------------------------------
> +
> +1) On ppc64, disable NUMA support and enable EMBEDDED support:
> 
It is not true, kdump on ppc64 works with NUMA and EEH enabled. So the
user need not disable NUMA and enable EMBEDDED support to make kdump
work on PPC64.

>     CONFIG_NUMA=n
>     CONFIG_EMBEDDED=y
>     CONFIG_EEH=N for the dump-capture kernel
> 
> -5) Enable "kernel crash dumps" support under "Processor type and
> -   features":
> -
> -   CONFIG_CRASH_DUMP=y
> -
> -6) Use a suitable value for "Physical address where the kernel is
> +2) Use a suitable value for "Physical address where the kernel is
>     loaded" (under "Processor type and features"). This only appears when
>     "kernel crash dumps" is enabled. By default this value is 0x1000000
>     (16MB). It should be the same as X in the "crashkernel=Y@X" boot
>     parameter discussed above.

Should we mention the above paragraph?
Why can not we specify by default PPC64 kdump kernel is loaded at 32MB?

Regards,
Mohan.
