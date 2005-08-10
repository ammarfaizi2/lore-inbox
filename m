Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVHJOMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVHJOMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVHJOMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:12:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16637 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965119AbVHJOMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:12:24 -0400
Subject: Re: [PATCH 4/5] 2.6.13-rc5-mm1, IPMI, use dmi_find_device()
From: Corey Minyard <cminyard@mvista.com>
To: Andrey Panin <pazke@donpac.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <11236699751680@donpac.ru>
References: <11236699751680@donpac.ru>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 09:12:07 -0500
Message-Id: <1123683127.15387.19.camel@i2.minyard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, this patch (along with the patch 3/5) works fine for me and is
an obvious improvement to the IPMI driver.  You will need to remove the
patch named dmi_table-counting-in-ipmi_si_intfc.patch first.

Thanks, Andrey.

-Corey

On Wed, 2005-08-10 at 14:32 +0400, Andrey Panin wrote:
> This patch replaces homebrew DMI scanning code in IPMI System Interface driver
> with dmi_find_device() call.
> 
> Signed-off-by: Andrey Panin <pazke@donpac.ru>
> 
>  drivers/char/ipmi/ipmi_si_intf.c |  105 ++++++---------------------------------
>  1 files changed, 17 insertions(+), 88 deletions(-)
> 
> diff -urdpNX /usr/share/dontdiff linux-2.6.13-rc5-mm1.vanilla/drivers/char/ipmi/ipmi_si_intf.c linux-2.6.13-rc5-mm1/drivers/char/ipmi/ipmi_si_intf.c
> --- linux-2.6.13-rc5-mm1.vanilla/drivers/char/ipmi/ipmi_si_intf.c	2005-08-08 14:32:07.000000000 +0400
> +++ linux-2.6.13-rc5-mm1/drivers/char/ipmi/ipmi_si_intf.c	2005-08-08 11:39:00.000000000 +0400
> @@ -75,6 +75,7 @@ static inline void add_usec_to_timer(str
>  #include <asm/io.h>
>  #include "ipmi_si_sm.h"
>  #include <linux/init.h>
> +#include <linux/dmi.h>
>  
>  /* Measure times between events in the driver. */
>  #undef DEBUG_TIMING
> @@ -1642,22 +1643,15 @@ typedef struct dmi_ipmi_data
>  static dmi_ipmi_data_t dmi_data[SI_MAX_DRIVERS];
>  static int dmi_data_entries;
>  
> -typedef struct dmi_header
> -{
> -	u8	type;
> -	u8	length;
> -	u16	handle;
> -} dmi_header_t;
> -
> -static int decode_dmi(dmi_header_t __iomem *dm, int intf_num)
> +static int __init decode_dmi(struct dmi_header *dm, int intf_num)
>  {
> -	u8		__iomem *data = (u8 __iomem *)dm;
> +	u8 *data = (u8 *)dm;
>  	unsigned long  	base_addr;
>  	u8		reg_spacing;
> -	u8              len = readb(&dm->length);
> +	u8              len = dm->length;
>  	dmi_ipmi_data_t *ipmi_data = dmi_data+intf_num;
>  
> -	ipmi_data->type = readb(&data[4]);
> +	ipmi_data->type = data[4];
>  
>  	memcpy(&base_addr, data+8, sizeof(unsigned long));
>  	if (len >= 0x11) {
> @@ -1672,12 +1666,12 @@ static int decode_dmi(dmi_header_t __iom
>  		}
>  		/* If bit 4 of byte 0x10 is set, then the lsb for the address
>  		   is odd. */
> -		ipmi_data->base_addr = base_addr | ((readb(&data[0x10]) & 0x10) >> 4);
> +		ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
>  
> -		ipmi_data->irq = readb(&data[0x11]);
> +		ipmi_data->irq = data[0x11];
>  
>  		/* The top two bits of byte 0x10 hold the register spacing. */
> -		reg_spacing = (readb(&data[0x10]) & 0xC0) >> 6;
> +		reg_spacing = (data[0x10] & 0xC0) >> 6;
>  		switch(reg_spacing){
>  		case 0x00: /* Byte boundaries */
>  		    ipmi_data->offset = 1;
> @@ -1705,7 +1699,7 @@ static int decode_dmi(dmi_header_t __iom
>  		ipmi_data->offset = 1;
>  	}
>  
> -	ipmi_data->slave_addr = readb(&data[6]);
> +	ipmi_data->slave_addr = data[6];
>  
>  	if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr)) {
>  		dmi_data_entries++;
> @@ -1717,82 +1711,17 @@ static int decode_dmi(dmi_header_t __iom
>  	return -1;
>  }
>  
> -static int dmi_table(u32 base, int len, int num)
> -{
> -	u8 		  __iomem *buf;
> -	struct dmi_header __iomem *dm;
> -	u8 		  __iomem *data;
> -	int 		  i=1;
> -	int		  status=-1;
> -	int               intf_num = 0;
> -
> -	buf = ioremap(base, len);
> -	if(buf==NULL)
> -		return -1;
> -
> -	data = buf;
> -
> -	while(i<num && (data - buf) < len)
> -	{
> -		dm=(dmi_header_t __iomem *)data;
> -
> -		if((data-buf+readb(&dm->length)) >= len)
> -        		break;
> -
> -		if (readb(&dm->type) == 38) {
> -			if (decode_dmi(dm, intf_num) == 0) {
> -				intf_num++;
> -				if (intf_num >= SI_MAX_DRIVERS)
> -					break;
> -			}
> -		}
> -
> -	        data+=readb(&dm->length);
> -		while((data-buf) < len && (readb(data)||readb(data+1)))
> -			data++;
> -		data+=2;
> -		i++;
> -	}
> -	iounmap(buf);
> -
> -	return status;
> -}
> -
> -static inline int dmi_checksum(u8 *buf)
> -{
> -	u8   sum=0;
> -	int  a;
> -
> -	for(a=0; a<15; a++)
> -		sum+=buf[a];
> -	return (sum==0);
> -}
> -
> -static int dmi_decode(void)
> +static void __init dmi_find_bmc(void)
>  {
> -	u8   buf[15];
> -	u32  fp=0xF0000;
> -
> -#ifdef CONFIG_SIMNOW
> -	return -1;
> -#endif
> +	struct dmi_device *dev = NULL;
> +	int intf_num = 0;
>  
> -	while(fp < 0xFFFFF)
> -	{
> -		isa_memcpy_fromio(buf, fp, 15);
> -		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
> -		{
> -			u16 num=buf[13]<<8|buf[12];
> -			u16 len=buf[7]<<8|buf[6];
> -			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
> +	while ((dev = dmi_find_device(DMI_DEV_TYPE_IPMI, NULL, dev))) {
> +		if (intf_num >= SI_MAX_DRIVERS)
> +			break;
>  
> -			if(dmi_table(base, len, num) == 0)
> -				return 0;
> -		}
> -		fp+=16;
> +		decode_dmi((struct dmi_header *) dev->device_data, intf_num++);
>  	}
> -
> -	return -1;
>  }
>  
>  static int try_init_smbios(int intf_num, struct smi_info **new_info)
> @@ -2382,7 +2311,7 @@ static __init int init_ipmi_si(void)
>  	printk(KERN_INFO "IPMI System Interface driver.\n");
>  
>  #ifdef CONFIG_X86
> -	dmi_decode();
> +	dmi_find_bmc();
>  #endif
>  
>  	rv = init_one_smi(0, &(smi_infos[pos]));
> 

