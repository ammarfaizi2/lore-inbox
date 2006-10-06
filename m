Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422883AbWJFTDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbWJFTDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422884AbWJFTDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:03:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49589 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422883AbWJFTDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:03:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org>
	<m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
	<20061005235909.75178c09.akpm@osdl.org>
	<m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
	<20061006183846.GF19756@in.ibm.com>
Date: Fri, 06 Oct 2006 13:01:28 -0600
In-Reply-To: <20061006183846.GF19756@in.ibm.com> (Vivek Goyal's message of
	"Fri, 6 Oct 2006 14:38:46 -0400")
Message-ID: <m1k63dz2t3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Hi Eric,
>
> I have added cld in the regenerated patch below. 
>
> Also one more minor nit. stosb relies on being %es set properly. By the
> time control reaches loader_ok, i could not find %es being set explicitly
> hence I am assuming we are relying on bootloader to set it up for us. 

No my bad.  I was thinking it was %ds, like everything else.

> Maybe we can be little more paranoid and setup the %es before stosb. I
> have done this change too in the attached patch. Pleaese have a look.
> I know little about assembly code.

Looks good to me.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

> In the lazy programmer school of fixes.
>
> I haven't really tested this in any configuration.
> But reading video.S it does use variable in the bootsector.
> It does seem to initialize the variables before use.
> But obviously something is missed.
>
> By zeroing the uninteresting parts of the bootsector just after we
> have determined we are loaded ok.  We should ensure we are
> always in a known state the entire time. 
>
> Andrew if I am right about the cause of your video not working
> when you set an enhanced video mode this should fix your boot
> problem.
>
> Singed-off-by: Eric Biederman <ebiederm@xmission.com>
>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
>
>  arch/i386/boot/setup.S |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff -puN arch/i386/boot/setup.S~i386-set-bootset-to-zero-fix
> arch/i386/boot/setup.S
> --- linux-2.6.18-git17/arch/i386/boot/setup.S~i386-set-bootset-to-zero-fix
> 2006-10-06 12:42:19.000000000 -0400
> +++ linux-2.6.18-git17-root/arch/i386/boot/setup.S 2006-10-06 12:49:37.000000000
> -0400
> @@ -287,6 +287,17 @@ good_sig:
>  loader_panic_mess: .string "Wrong loader, giving up..."
>  
>  loader_ok:
> +# Zero initialize the variables we keep in the bootsector
> +	movw	%cs, %ax			# aka SETUPSEG
> +	subw	$DELTA_INITSEG, %ax		# aka INITSEG
> +	movw	%ax, %es
> +	xorw	%di, %di
> +	xorb	%al, %al
> +	movw	$497, %cx
> +	cld
> +	rep
> +	stosb
> +
>  # Get memory size (extended mem, kB)
>  
>  	xorl	%eax, %eax
> _
