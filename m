Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318708AbSHERJB>; Mon, 5 Aug 2002 13:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318720AbSHERJB>; Mon, 5 Aug 2002 13:09:01 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:41988 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318708AbSHERJA>; Mon, 5 Aug 2002 13:09:00 -0400
Date: Mon, 5 Aug 2002 18:12:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: arnd@bergmann-dalldorf.de
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 18/18 scsi core changes
Message-ID: <20020805181234.B16035@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	arnd@bergmann-dalldorf.de,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com> <200208052008.35187.arndb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208052008.35187.arndb@de.ibm.com>; from arndb@de.ibm.com on Mon, Aug 05, 2002 at 08:08:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 08:08:35PM +0200, Arnd Bergmann wrote:
> This patch does not look fit for inclusion to me,

It absolutely does not look good for inclusion.

> but appearantly it's
> needed if anyone actually wants to use the new zfcp driver I sent with
> patch 10/18...

the zfcp driver itself is so ugly that I wonder you even show it publically..

> +if [ "$CONFIG_ARCH_S390" != "y" ]; then
>  dep_tristate '7000FASST SCSI support' CONFIG_SCSI_7000FASST $CONFIG_SCSI
>  dep_tristate 'ACARD SCSI support' CONFIG_SCSI_ACARD $CONFIG_SCSI
>  dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI

all these entries want indentation by three spaces.  See
Documentation/CodingStyle.

> +if [ "$CONFIG_ARCH_S390" = "y" ]; then
> +dep_tristate 'IBM z900 FCP host bus adapter driver' CONFIG_ZFCP $CONFIG_QDIO

dito.

>  scsi_unregister(struct Scsi_Host * sh){
>      struct Scsi_Host * shpnt;
>      Scsi_Host_Name *shn;
> +    char name[10];
> +
> +    /* kill error handling thread */
> +    if (sh->hostt->use_new_eh_code
> +        && sh->ehandler != NULL) {
> +            DECLARE_MUTEX_LOCKED(sem);
> +            
> +            sh->eh_notify = &sem;
> +            send_sig(SIGHUP, sh->ehandler, 1);
> +            down(&sem);
> +            sh->eh_notify = NULL;
> +    }
> +   
> +    /* remove proc entry */
> +#ifdef CONFIG_PROC_FS
> +    sprintf(name, "%d", sh->host_no);
> +    remove_proc_entry(name, sh->hostt->proc_dir);
> +#endif

this change actually looks useful.  but I don't think it's suitable for
stable series.

> diff -urN linux-2.4.19-rc3/drivers/scsi/scsi.h linux-2.4.19-s390/drivers/scsi/scsi.h
> --- linux-2.4.19-rc3/drivers/scsi/scsi.h	Tue Jul 30 09:02:28 2002
> +++ linux-2.4.19-s390/drivers/scsi/scsi.h	Tue Jul 30 09:02:55 2002
> @@ -390,6 +390,17 @@
>  #include <asm/pgtable.h>
>  #define CONTIGUOUS_BUFFERS(X,Y) \
>  	(virt_to_phys((X)->b_data+(X)->b_size-1)+1==virt_to_phys((Y)->b_data))
> +#elif defined(CONFIG_ARCH_S390) || defined(CONFIG_ARCH_S390X)
> +#define _CONTIGUOUS_BUFFERS(xd, xs, yd, ys) \
> +     (((xd + xs) == yd) \
> +      && ((xd & PAGE_MASK) == ((yd + ys - 1) & PAGE_MASK)))
> +
> +#define CONTIGUOUS_BUFFERS(X,Y) \
> +	_CONTIGUOUS_BUFFERS( \
> +		(unsigned long)(X)->b_data, \
> +		(unsigned long)(X)->b_size, \
> +		(unsigned long)(Y)->b_data, \
> +		(unsigned long)(Y)->b_size)

This area is going to change heavily with block-highmem in 2.4.20.
Please don't touch it just now.

> +                /*
> +                 * We need to recount the number of
> +                 * scatter-gather segments here - the
> +                 * normal case code assumes this to be
> +                 * correct, as it would be a performance
> +                 * loss to always recount.  Handling
> +                 * errors is always unusual, of course.
> +                 */
> +                recount_segments(SCpnt);

might be worth to get the indentation right, heh?

What is the exact reason to move it around?


