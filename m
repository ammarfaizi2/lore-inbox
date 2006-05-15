Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWEOVBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWEOVBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWEOVBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:01:10 -0400
Received: from xenotime.net ([66.160.160.81]:36297 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964833AbWEOVBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:01:09 -0400
Date: Mon, 15 May 2006 14:03:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com, schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 05/16] ehca: common include files
Message-Id: <20060515140337.bad62cc9.rdunlap@xenotime.net>
In-Reply-To: <4468BD5B.1060406@de.ibm.com>
References: <4468BD5B.1060406@de.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 19:41:47 +0200 Heiko J Schick wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   drivers/infiniband/hw/ehca/ehca_iverbs.h |  181 +++++++++++++
>   drivers/infiniband/hw/ehca/ehca_tools.h  |  411 +++++++++++++++++++++++++++++++
>   2 files changed, 592 insertions(+)
> 
> 
> 
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_tools.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_tools.h	2006-05-03 13:44:15.000000000 +0200
> @@ -0,0 +1,411 @@

> +static inline u64 ehca_edeb_filter(const u32 level,
> +				   const u32 id, const u32 line)
> +{
> +	u64 ret = 0;
> +	u32 filenr = 0;
> +	u32 filter_level = 9;
> +	u32 dynamic_level = 0;
> +
> +	/* This is code written for the gcc -O2 optimizer which should colapse
                                                                    collapse
> +	 * to two single ints filter_level is the first level kicked out by
> +	 * compiler means trace everythin below 6. */
                                everything
plus make a real sentence of that, please.

> +}
> +
> +#ifdef EHCA_USE_HCALL_KERNEL
> +#ifdef CONFIG_PPC_PSERIES
> +
> +#include <asm/paca.h>
> +
> +/**
> + * IS_EDEB_ON - Checks if debug is on for the given level.
> + */
> +#define IS_EDEB_ON(level) \
> +    ((ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__) & 0x100000000L)==0)
> +
> +#elif REAL_HCALL
> +
> +
> +#endif
> +#else
> +
> +#endif
> +
> +/**
> + * EDEB - Trace output macro.
> + * @level tracelevel
> + * @format optional format string, use "" if not desired
> + * @args printf like arguments for trace, use %Lx for u64, %x for u32
> + *       %p for pointer
> + */

Use real kernel-doc format here, please.
Parameters at least need a colon (':') after their names, like:

 * @format: optonal format string, use "" if not desired

and test them...

> +#define EDEB(level,format,args...) \
> +	EDEB_P_GENERIC(level,"",format,##args)
> +#define EDEB_ERR(level,format,args...) \
> +	EDEB_P_GENERIC(level,"HCAD_ERROR ",format,##args)
> +#define EDEB_EN(level,format,args...) \
> +	EDEB_P_GENERIC(level,">>>",format,##args)
> +#define EDEB_EX(level,format,args...) \
> +	EDEB_P_GENERIC(level,"<<<",format,##args)
> +
> +/**
> + * EDEB macro to dump a memory block, whose length is n*8 bytes.
      EDEB_DMP

> + * Each line has the following layout:
> + * <format string> adr=X ofs=Y <8 bytes hex> <8 bytes hex>
> + */
> +#define EDEB_DMP(level,adr,len,format,args...) \
> +	do {				       \
> +		unsigned int x;			      \
> +		unsigned int l = (unsigned int)(len); \
> +		unsigned char *deb = (unsigned char*)(adr);	\
> +		for (x = 0; x < l; x += 16) { \
> +		        EDEB(level, format " adr=%p ofs=%04x %016lx %016lx", \
> +			     ##args, deb, x, *((u64 *)&deb[0]), *((u64 *)&deb[8])); \
> +			deb += 16; \
> +		} \
> +	} while (0)
> +
> +/* define a bitmask, little endian version */
> +#define EHCA_BMASK(pos,length) (((pos)<<16)+(length))
> +/* define a bitmask, the ibm way... */
> +#define EHCA_BMASK_IBM(from,to) (((63-to)<<16)+((to)-(from)+1))
> +/* internal function, don't use */
> +#define EHCA_BMASK_SHIFTPOS(mask) (((mask)>>16)&0xffff)
> +/* internal function, don't use */
> +#define EHCA_BMASK_MASK(mask) (0xffffffffffffffffULL >> ((64-(mask))&0xffff))
> +/* return value shifted and masked by mask\n
> + * variable|=HCA_BMASK_SET(MY_MASK,0x4711) ORs the bits in variable\n
> + * variable&=~HCA_BMASK_SET(MY_MASK,-1) clears the bits from the mask
> + * in variable

What are all of those "\n"s up there?  and below?

> +#define EHCA_BMASK_SET(mask,value) \
> +	((EHCA_BMASK_MASK(mask) & ((u64)(value)))<<EHCA_BMASK_SHIFTPOS(mask))
> +/* extract a parameter from value by mask\n
> + * param=EHCA_BMASK_GET(MY_MASK,value)
> + */
> +#define EHCA_BMASK_GET(mask,value) \
> +	( EHCA_BMASK_MASK(mask)& (((u64)(value))>>EHCA_BMASK_SHIFTPOS(mask)))
> +
> +
> +/**
> + * ehca_adr_bad - Handle to be used for adress translation mechanisms,
> + * currently a placeholder.
> + */

Use proper kernel-doc format.

> +static inline int ehca_adr_bad(void *adr)
> +{
> +	return !adr;
> +}
> +
> +/**
> + * ehca2ib_return_code - Returns ib return code corresponding to the given
> + * ehca return code.
> + */

Ditto.

---
~Randy
