Return-Path: <linux-kernel-owner+w=401wt.eu-S1753233AbXACCCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbXACCCc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbXACCCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:02:32 -0500
Received: from nevyn.them.org ([66.93.172.17]:38922 "EHLO nevyn.them.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbXACCCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:02:30 -0500
Date: Tue, 2 Jan 2007 21:02:28 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Contents of core dumps (was: Re: fs/binfmt_elf.c:maydump())
Message-ID: <20070103020228.GA28762@nevyn.them.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060406.140357.14088592.davem@davemloft.net> <20060406221519.GA5453@nevyn.them.org> <20060406.153518.60508780.davem@davemloft.net> <20060406.221807.114721185.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406.221807.114721185.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC, I am not subscribed to lkml.]

On Thu, Apr 06, 2006 at 10:18:07PM -0700, David S. Miller wrote:
> How about something like the following patch?  If it's executable
> and not written to, skip it.  This would skip the main executable
> image and all text segments of the shared libraries mapped in.

I've been going through GDB test failures (... again...) and I'm down
to a respectably small number on x86_64, but this is one of the
remaining ones.  I don't suppose there's been any change since we
discussed this in April?

A refresher for those following along: there's a GDB test that mmaps a
file using MAP_PRIVATE and PROT_WRITE.  It expects the contents to end
up in the core dump.  Right now, they don't.  I can fix the test by
making sure it writes to the mapping, but before I change the test,
I want to raise the question of what _should_ be in a core dump.

I took a peek at what Solaris includes in core dumps.  They offer
(not surprisingly) a pile of configuration options.  The default is
just about everything except for file-backed shared memory and some
symbol table data - it includes text segments, rodata, anonymous shared
memory, file backed mappings, et cetera.  I guess that's another
argument in favor of dumping more.  Then you can control it globally,
per process, et cetera.

http://src.opensolaris.org/source/xref/loficc/crypto/usr/src/uts/common/sys/corectl.h

I also checked an AIX manual since there was a reference to SA_FULLDUMP
in the GDB test:

 By default, the user data, anonymously mapped regions, and vm_infox
 structures are not included in a core dump. This partial core dump
 includes the current thread stack, the thread thrdctx structures, the
 user structure, and the state of the registers at the time of the
 fault. A partial core dump contains sufficient information for a stack
 traceback. The size of a core dump can also be limited by the setrlimit
 or setrlimit64 subroutine.

 To enable a full core dump, set the SA_FULLDUMP flag in the sigaction
 subroutine for the signal that is to generate a full core dump. If this
 flag is set when the core is dumped, the user data section, vm_infox,
 and anonymously mapped region structures are included in the core dump.

Not really sure what that translates to, but it's less than what
Solaris dumps, I think.

Does Linux need knobs for this?

> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 537893a..9ec5c2b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1167,8 +1167,10 @@ static int maydump(struct vm_area_struct
>  	if (vma->vm_flags & VM_SHARED)
>  		return vma->vm_file->f_dentry->d_inode->i_nlink == 0;
>  
> -	/* If it hasn't been written to, don't write it out */
> -	if (!vma->anon_vma)
> +	/* If it is executable and hasn't been written to,
> +	 * don't write it out.
> +	 */
> +	if ((vma->vm_flags & VM_EXEC) && !vma->anon_vma)
>  		return 0;
>  
>  	return 1;
> 
> 

-- 
Daniel Jacobowitz
CodeSourcery
