Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317461AbSFRP4C>; Tue, 18 Jun 2002 11:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSFRP4B>; Tue, 18 Jun 2002 11:56:01 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:21490 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S317461AbSFRP4A>; Tue, 18 Jun 2002 11:56:00 -0400
Message-Id: <200206181555.g5IFtuP32608@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: vamsi_krishna@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Multi-threaded core dumps for 2.5.21.
Date: Tue, 18 Jun 2002 09:03:14 -0400
X-Mailer: KMail [version 1.3.1]
References: <200206142310.g5ENADP23772@unix-os.sc.intel.com> <200206181332.g5IDW5r54694@westrelay01.boulder.ibm.com>
In-Reply-To: <200206181332.g5IDW5r54694@westrelay01.boulder.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 June 2002 09:41 am, Vamsi Krishna S. wrote:
> Mark,
>
> You are capturing the registers of the thread dumping core
> twice in this patch. Please apply on top of your patch:

You are so right!  That same code is defined as an inline in elfcore.h, and 
is executed just a few lines down from there.  I'll incorporate this into a 
couple of new patches for a posting later today.

Thanks for the review.

--mgross



>
> --- tcore/fs/binfmt_elf.c.ori	Mon Jun 17 15:02:27 2002
> +++ tcore/fs/binfmt_elf.c	Mon Jun 17 15:02:49 2002
> @@ -1203,22 +1203,6 @@
>
>  	}
>
> -	memset(&prstatus, 0, sizeof(prstatus));
> -	/*
> -	 * This transfers the registers from regs into the standard
> -	 * coredump arrangement, whatever that is.
> -	 */
> -#ifdef ELF_CORE_COPY_REGS
> -	ELF_CORE_COPY_REGS(prstatus.pr_reg, regs)
> -#else
> -	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs))
> -	{
> -		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
> -			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
> -	}
> -	else
> -		*(struct pt_regs *)&prstatus.pr_reg = *regs;
> -#endif
>
>  	 /* capture the status of all other threads */
>  	if (signr) {
>
>
> Same problem is there on the patch you posted for 2.4.18 too, the above
> will apply with a slight offset.
>
> Vamsi Krishna S.
> Linux Technology Center,
> IBM Software Lab, Bangalore.
> Ph: +91 80 5044959
> Internet: vamsi_krishna@in.ibm.com
>
> On Sat, 15 Jun 2002 04:45:56 +0530, mgross wrote:
> > Attached is a re-base of the 2.5.18 patch posted last week.
> >
> > This patch has been tested on my SMP system and seems very stable, so
> > far. I would like very much to see this feature added to the 2.5.x
> > kernels and more milage given to it.
> >
> > For ISV's not having the ability to create core dumps for pthread
> > applications is a strong justification for not using Linux. Now is a good
> > time for Linux support the ISV's WRT core files for multi-threaded
> > applications.
> >
> > To use the core files from multi-threaded applications, created with this
> > patch you may need to strip the objects from /lib/libpthread. For my
> > system 'strip /lib/libpthread-0.9.so makes things good, YMMV.
> >
> > Please apply this patch.
> >
> > --mgross
