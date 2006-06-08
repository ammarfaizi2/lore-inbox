Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWFHLCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWFHLCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWFHLCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:02:35 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:28029 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S964822AbWFHLCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:02:34 -0400
Date: Thu, 8 Jun 2006 13:02:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: schwidefsky@de.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       arjan@infradead.org
Subject: Re: 2.6.17-rc5-mm2 link issues on s390
Message-ID: <20060608110222.GA16871@osiris.boeblingen.de.ibm.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EE5A4.7050201@fr.ibm.com> <1149168482.5279.34.camel@localhost> <447EF175.4040608@fr.ibm.com> <20060608072802.GB9416@osiris.boeblingen.de.ibm.com> <4487EA41.3030400@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4487EA41.3030400@fr.ibm.com>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 12:13:37PM +0200, Cedric Le Goater wrote:
> Heiko Carstens wrote:
> 
> > This looks wrong: "b" is a u64 and you write it to something that is an
> > unsigned long. We're going to miss a few bits on 31 bit platforms...
> 
> Indeed. Here's another version protecting the quad macros with __s390x__.
> to be applied on rc6-mm1.
> 
> For the moment, __raw_writeq() is needed by __iowrite64_copy() which is
> protected by CONFIG_64BIT. Some drivers also use it.
> 
> Thanks for reviewing,
> 
> C.

> From: Cedric Le Goater <clg@fr.ibm.com>
> Replace-Subject: s390 adds __raw_writeq required by __iowrite64_copy.
> 
> It also adds all the related quad routines. 
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> 
> ---
>  include/asm-s390/io.h |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> Index: 2.6.17-rc6-mm1/include/asm-s390/io.h
> ===================================================================
> --- 2.6.17-rc6-mm1.orig/include/asm-s390/io.h
> +++ 2.6.17-rc6-mm1/include/asm-s390/io.h
> @@ -86,20 +86,35 @@ extern void iounmap(void *addr);
>  #define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
>  #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
>  #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
> +#ifdef __s390x__
> +#define readq(addr) (*(volatile unsigned long *) __io_virt(addr))
> +#endif

Please use an unsigned long long cast and get rid of the ifdefs...
