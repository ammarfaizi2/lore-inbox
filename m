Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263409AbRFAINg>; Fri, 1 Jun 2001 04:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263412AbRFAIN0>; Fri, 1 Jun 2001 04:13:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2203 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263409AbRFAINQ>;
	Fri, 1 Jun 2001 04:13:16 -0400
Message-ID: <3B174E97.60DAA03E@mandrakesoft.com>
Date: Fri, 01 Jun 2001 04:13:11 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
Cc: groudier@club-internet.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@redhat.com
Subject: Re: [PATCH] sym53c8xx timer and smp fixes
In-Reply-To: <3B16EF26.2F44BE3F@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
>  spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
> +spinlock_t sym53c8xx_host_lock = SPIN_LOCK_UNLOCKED;
>  #define        NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
>  #define        NCR_UNLOCK_DRIVER(flags)   spin_unlock_irqrestore(&sym53c8xx_lock,flags)
> +#define        NCR_LOCK_HOSTS(flags)     spin_lock_irqsave(&sym53c8xx_host_lock, flags)
> +#define        NCR_UNLOCK_HOSTS(flags)   spin_unlock_irqrestore(&sym53c8xx_host_lock,flags)
> 
>  #define NCR_INIT_LOCK_NCB(np)      spin_lock_init(&np->smp_lock);
>  #define        NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
> @@ -650,6 +655,8 @@
> 
>  #define        NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
>  #define        NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
> +#define        NCR_LOCK_HOSTS(flags)     do { save_flags(flags); cli(); } while (0)
> +#define        NCR_UNLOCK_HOSTS(flags)   do { restore_flags(flags); } while (0)
> 
>  #define        NCR_INIT_LOCK_NCB(np)      do { } while (0)
>  #define        NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
> @@ -695,7 +702,7 @@

so, this driver is mixed spinlocks and save/restore_flags?  Any chance
this can be converted to all spinlocks?

>  #ifdef SCSI_NCR_DYNAMIC_DMA_MAPPING
> -       if (pci_set_dma_mask(pdev, (dma_addr_t) (0xffffffffUL))) {
> +       if (!pci_dma_supported(pdev, (dma_addr_t) (0xffffffffUL))) {

totally wrong.  you are going backwards.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
