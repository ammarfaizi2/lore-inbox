Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314061AbSDQE6o>; Wed, 17 Apr 2002 00:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314063AbSDQE6n>; Wed, 17 Apr 2002 00:58:43 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:6304 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S314061AbSDQE6m>;
	Wed, 17 Apr 2002 00:58:42 -0400
Date: Tue, 16 Apr 2002 21:59:08 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adam Kropelin <akropel1@rochester.rr.com>, Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <2635845054.1018994347@[10.10.2.3]>
In-Reply-To: <20020417024707.GA24105@www.kroptech.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xquad_portio is indeed only for CONFIG_MULTIQUAD. However, you
shouldn't need the #ifdef's in the code to make this work -
clustered_apic_mode isn't a variable at all, it's a magic
trick that's actually 1 or 0 depending on CONFIG_MULTIQUAD.

Look at 2.5.8 virgin, it has the same code.

M.

--On Tuesday, April 16, 2002 10:47 PM -0400 Adam Kropelin
<akropel1@rochester.rr.com> wrote:

> On Mon, Apr 15, 2002 at 10:19:24PM -0400, Frank Davis wrote:
>> Hello all,
>>   While a 'make bzImage', I received the following compile error:
>> Regards,
>> Frank
>> 
>> smpboot.c:1008: parse error before `0'
>> smpboot.c: In function `smp_boot_cpus':
>> smpboot.c:1023: invalid lvalue in assignment
>> make[1]: *** [smpboot.o] Error 1
>> make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
>> make: *** [_dir_arch/i386/kernel] Error 2
> 
> There's an optimization in io.h for !CONFIG_MULTIQUAD which doesn't seem
> to have been carried through all the way...
> 
> The following patch seems logical, but I'm no expert. In particular, I'm
> not sure if the ioremapping bit ever needs to be run when
> !CONFIG_MULTIQUAD...
> 
> --Adam
> 
> --- linux-2.5.8-dj1-virgin/arch/i386/kernel/smpboot.c	Tue Apr 16 16:21:24
> 2002 +++ linux-2.5.8-dj1+smpboot-fix/arch/i386/kernel/smpboot.c	Tue Apr
> 16 21:12:13 2002 @@ -1004,8 +1004,11 @@
>  extern int prof_counter[NR_CPUS];
>  
>  static int boot_cpu_logical_apicid;
> +
>  /* Where the IO area was mapped on multiquad, always 0 otherwise */
> +#ifdef CONFIG_MULTIQUAD
>  void *xquad_portio = NULL;
> +#endif
>  
>  int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
>  
> @@ -1013,6 +1016,7 @@
>  {
>  	int apicid, cpu, bit;
>  
> +#ifdef CONFIG_MULTIQUAD
>          if (clustered_apic_mode && (numnodes > 1)) {
>                  printk("Remapping cross-quad port I/O for %d quads\n",
>  			numnodes);
> @@ -1022,6 +1026,7 @@
>                  xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
>  			numnodes * XQUAD_PORTIO_LEN);
>          }
> +#endif
>  
>  #ifdef CONFIG_MTRR
>  	/*  Must be done before other processors booted  */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


