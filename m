Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSKNDe2>; Wed, 13 Nov 2002 22:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSKNDe2>; Wed, 13 Nov 2002 22:34:28 -0500
Received: from [195.223.140.107] ([195.223.140.107]:17809 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262492AbSKNDe1>;
	Wed, 13 Nov 2002 22:34:27 -0500
Date: Thu, 14 Nov 2002 04:41:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: i386 Linux kernel DoS (clarification)
Message-ID: <20021114034108.GW31697@dualathlon.random>
References: <76D1FF66BB6@vcnet.vc.cvut.cz> <1037224095.11979.156.camel@irongate.swansea.linux.org.uk> <20021113215115.GA1827@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113215115.GA1827@vana>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 10:51:15PM +0100, Petr Vandrovec wrote:
> On Wed, Nov 13, 2002 at 09:48:15PM +0000, Alan Cox wrote:
> > On Wed, 2002-11-13 at 21:18, Petr Vandrovec wrote:
> > > >     pushfl          # We get a different stack layout with call
> > > >                 # gates, which has to be cleaned up later..
> > > > +   andl $~0x4500, (%esp)   # Clear NT since we are doing an iret
> > > 
> > > this will clear 'D' and 'T' in caller after we do
> > > iret (if lcall7 returns, of course). I'm not sure that callers
> > 
> > You can adjust that if you want, I copied it about - clearing D is fine,
> > in fact it may let us avoid the cld
> 
> Hi,
>    your original code just behaved as my old code: run modprobe successfully,
> and then die. Problem is that copy of eflags on stack is totally unimportant
> to us: current value in eflags is what matters. So this is minimal
> patch which works here: NT, DF and TF are now cleared only for kernel,
> and when we return back from lcall, userspace has its old values.
> 
>    Optimization left to readed is creating SAVE_ALL_NOCLD, and using this
> one in lcall7 and lcall27.
> 
>    With patch below my machine survived test. Unfortunately I do not
> have patched kernel with linux-abi to test whether lcall7 still works
> correctly.
> 						Best regards,
> 							Petr Vandrovec
> 							vandrove@vc.cvut.cz
> 
> 
> --- linux-2.5.47.dist/arch/i386/kernel/entry.S	2002-11-11 12:26:04.000000000 +0100
> +++ linux-2.5.47/arch/i386/kernel/entry.S	2002-11-13 22:40:19.000000000 +0100
> @@ -66,7 +66,9 @@
>  OLDSS		= 0x38
>  
>  CF_MASK		= 0x00000001
> +TF_MASK		= 0x00000100
>  IF_MASK		= 0x00000200
> +DF_MASK		= 0x00000400
>  NT_MASK		= 0x00004000
>  VM_MASK		= 0x00020000
>  
> @@ -132,6 +134,9 @@
>  	movl CS(%esp), %edx	# this is eip..
>  	movl EFLAGS(%esp), %ecx	# and this is cs..
>  	movl %eax,EFLAGS(%esp)	#
> +	andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
> +	pushl %eax
> +	popfl
>  	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
>  	movl %ecx,CS(%esp)	#
>  	movl %esp, %ebx
> @@ -154,6 +159,9 @@
>  	movl CS(%esp), %edx	# this is eip..
>  	movl EFLAGS(%esp), %ecx	# and this is cs..
>  	movl %eax,EFLAGS(%esp)	#
> +	andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
> +	pushl %eax
> +	popfl
>  	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
>  	movl %ecx,CS(%esp)	#
>  	movl %esp, %ebx

this is needed too in addition to the patch I posted in the other thread
to avoid lcall to set NT (my patch only avoids ptrace to set NT and we
need both of them to forbid nt to be set while running in kernel space).

Andrea
