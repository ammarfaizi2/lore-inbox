Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUDJOtF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 10:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUDJOtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 10:49:05 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:35857 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262044AbUDJOtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 10:49:01 -0400
Date: Sat, 10 Apr 2004 16:49:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.2/2.4/2.6] broken memsets in net/sk_mca.c (multicast)
Message-Id: <20040410164910.40ff8bb3.khali@linux-fr.org>
In-Reply-To: <20040410015936.5ad35c73.akpm@osdl.org>
References: <20040410102040.022ffb3c.khali@linux-fr.org>
	<20040410014040.48cb037b.akpm@osdl.org>
	<20040410094924.C32143@flint.arm.linux.org.uk>
	<20040410015936.5ad35c73.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- 25/drivers/net/sk_mca.c~sk_mca-multicast-fix	2004-04-10 01:42:29.464928112 -0700
> +++ 25-akpm/drivers/net/sk_mca.c	2004-04-10 01:57:20.106530008 -0700
> @@ -997,13 +997,13 @@ static void skmca_set_multicast_list(str
>  		block.Mode &= ~LANCE_INIT_PROM;
>  
>  	if (dev->flags & IFF_ALLMULTI) {	/* get all multicasts */
> -		memset(block.LAdrF, 8, 0xff);
> +		memset(block.LAdrF, 0xff, sizeof(block.LAdrF));
>  	} else {		/* get selected/no multicasts */
>  
>  		struct dev_mc_list *mptr;
>  		int code;
>  
> -		memset(block.LAdrF, 8, 0x00);
> +		memset(block.LAdrF, 0, sizeof(block.LAdrF));
>  		for (mptr = dev->mc_list; mptr != NULL; mptr = mptr->next) {
>  			code = GetHash(mptr->dmi_addr);
>  			block.LAdrF[(code >> 3) & 7] |= 1 << (code & 7);
> 

Looks better ;)

While you're at it, please consider the following misc changes:

1* In net/sk_mca.h:
#define CSR3_BSWAP_OFF     0	/* Bit 2 = 0 -> no byte swap         */
#define CSR3_BSWAP_ON      0	/* Bit 2 = 1 -> byte swap            */
The second define should obviously read 4, not 0. It's harmess because
the define isn't used anywhere, but still...

2* Alfred Arnold's alternate e-mail address, aarnold at elsa.de, looks
dead. Maybe you could remove it from the two drivers it appears in:
net/ibmlana.c and net/sk_mca.c. The first address still works. Quoting
Alfred: "ELSA (my old employer) went bankrupt about two years ago, you
may remove this address or replace it with my current work address:
alfred.arnold at lancom.de".

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
