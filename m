Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUDJItg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 04:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDJItg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 04:49:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45318 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261988AbUDJIte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 04:49:34 -0400
Date: Sat, 10 Apr 2004 09:49:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       aarnold@elsa.de
Subject: Re: [BUG 2.2/2.4/2.6] broken memsets in net/sk_mca.c (multicast)
Message-ID: <20040410094924.C32143@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
	aarnold@elsa.de
References: <20040410102040.022ffb3c.khali@linux-fr.org> <20040410014040.48cb037b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040410014040.48cb037b.akpm@osdl.org>; from akpm@osdl.org on Sat, Apr 10, 2004 at 01:40:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 01:40:40AM -0700, Andrew Morton wrote:
> Jean Delvare <khali@linux-fr.org> wrote:
> > I just found two very weird memsets in drivers/net/sk_mca.c.
> 
> yup.

Erm...

> --- 25/drivers/net/sk_mca.c~sk_mca-multicast-fix	2004-04-10 01:37:06.739989760 -0700
> +++ 25-akpm/drivers/net/sk_mca.c	2004-04-10 01:38:33.684772144 -0700
> @@ -996,14 +996,12 @@ static void skmca_set_multicast_list(str
>  	else
>  		block.Mode &= ~LANCE_INIT_PROM;
>  
> -	if (dev->flags & IFF_ALLMULTI) {	/* get all multicasts */
> -		memset(block.LAdrF, 8, 0xff);
> -	} else {		/* get selected/no multicasts */
> -
> +	memset(block.LAdrF, 0xff, sizeof(block.LAdrF));

Initialise the whole of block.LAdrF to all-bits-set, and then...

> +	if (!(dev->flags & IFF_ALLMULTI)) {
> +		/* get selected/no multicasts */
>  		struct dev_mc_list *mptr;
>  		int code;
>  
> -		memset(block.LAdrF, 8, 0x00);
>  		for (mptr = dev->mc_list; mptr != NULL; mptr = mptr->next) {
>  			code = GetHash(mptr->dmi_addr);
>  			block.LAdrF[(code >> 3) & 7] |= 1 << (code & 7);

Set bits, which are already set from the previous memset.

Surely this can't be right?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
