Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313716AbSDVJlS>; Mon, 22 Apr 2002 05:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314099AbSDVJlR>; Mon, 22 Apr 2002 05:41:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48905 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313716AbSDVJlQ>; Mon, 22 Apr 2002 05:41:16 -0400
Message-ID: <3CC3CC1C.9030302@evision-ventures.com>
Date: Mon, 22 Apr 2002 10:38:52 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [fakePATCH] non-PCI ide
In-Reply-To: <UTC200204212053.g3LKr5207841.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> A moment ago I compiled 2.5.8 for a non-PCI 486.
> Below a diff that makes it compile (and work),
> modulo other patches that have been posted already.
> 
> diff -u --recursive --new-file ../linux-2.5.8/linux/drivers/ide/ide-proc.c ./linux/drivers/ide/ide-proc.c
> --- ../linux-2.5.8/linux/drivers/ide/ide-proc.c	Tue Apr 16 00:42:05 2002
> +++ ./linux/drivers/ide/ide-proc.c	Sun Apr 21 21:32:10 2002
> @@ -422,7 +422,6 @@
>  static void create_proc_ide_drives(struct ata_channel *hwif)
>  {
>  	int	d;
> -	struct proc_dir_entry *ent;
>  	struct proc_dir_entry *parent = hwif->proc;
>  	char name[64];
>  
> diff -u --recursive --new-file ../linux-2.5.8/linux/drivers/ide/ide.c ./linux/drivers/ide/ide.c
> --- ../linux-2.5.8/linux/drivers/ide/ide.c	Tue Apr 16 00:42:05 2002
> +++ ./linux/drivers/ide/ide.c	Sun Apr 21 21:44:35 2002
> @@ -2701,7 +2701,11 @@
>  
>  void ide_teardown_commandlist(ide_drive_t *drive)
>  {
> -	struct pci_dev *pdev= drive->channel->pci_dev;
> +#ifdef CONFIG_BLK_DEV_IDEPCI
> +	struct pci_dev *pdev = drive->channel->pci_dev;
> +#else
> +	struct pci_dev *pdev = NULL;
> +#endif
>  	struct list_head *entry;
>  
>  	list_for_each(entry, &drive->free_req) {
> @@ -2709,14 +2713,19 @@
>  
>  		list_del(&ar->ar_queue);
>  		kfree(ar->ar_sg_table);
> -		pci_free_consistent(pdev, PRD_SEGMENTS * PRD_BYTES, ar->ar_dmatable_cpu, ar->ar_dmatable);
> +		pci_free_consistent(pdev, PRD_SEGMENTS * PRD_BYTES,
> +				    ar->ar_dmatable_cpu, ar->ar_dmatable);
>  		kfree(ar);
>  	}
>  }
>  
>  int ide_build_commandlist(ide_drive_t *drive)
>  {
> -	struct pci_dev *pdev= drive->channel->pci_dev;
> +#ifdef CONFIG_BLK_DEV_IDEPCI
> +	struct pci_dev *pdev = drive->channel->pci_dev;
> +#else
> +	struct pci_dev *pdev = NULL;
> +#endif
>  	struct ata_request *ar;
>  	ide_tag_info_t *tcq;
>  	int i, err;
> diff -u --recursive --new-file ../linux-2.5.8/linux/include/asm-i386/ide.h ./linux/include/asm-i386/ide.h
> --- ../linux-2.5.8/linux/include/asm-i386/ide.h	Fri Mar 29 12:39:13 2002
> +++ ./linux/include/asm-i386/ide.h	Sun Apr 21 21:26:52 2002
> @@ -75,6 +75,7 @@
>  static __inline__ void ide_init_default_hwifs(void)
>  {
>  #ifndef CONFIG_BLK_DEV_IDEPCI
> +	extern int ide_register_hw(hw_regs_t *hw, struct ata_channel **hwifp);
>  	hw_regs_t hw;
>  	int index;
>  
> Of course this is not a suggestion to put in those #ifdef's,
> this is just to point out that pci_dev is undefined when
> CONFIG_BLK_DEV_IDEPCI is not set. You might consider putting
> something like
> 
>   #ifdef CONFIG_BLK_DEV_IDEPCI
>   #define PCI_DEV(drive) (drive->channel->pci_dev)
>   #else
>   #define PCI_DEV(drive) (NULL)
>   #endif


Well this suggestion is indeed worth consideration.
However Linus is lagging right now a bit in pre patch
generatoin, becouse he apparently spends too much time
on meaningless discussions ;-).

