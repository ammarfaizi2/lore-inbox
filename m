Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUFKNjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUFKNjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbUFKNjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:39:44 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54915 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263895AbUFKNjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:39:39 -0400
Date: Fri, 11 Jun 2004 22:40:53 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 1/4]Diskdump Update
In-reply-to: <1086954645.2731.23.camel@laptop.fenrus.com>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Message-id: <ABC44FB9B74DDCindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1086954645.2731.23.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Jun 2004 13:50:45 +0200, Arjan van de Ven wrote:

>>  	console_verbose();
>> -	spin_lock_irq(&die_lock);
>> +	if (!crashdump_mode())
>> +		spin_lock_irq(&die_lock);
>
>
>why is this??

It is for safety.
If diskdump dies during dumping, die() is called again.
In such a case, system falls into the deadlock by die_lock.
User cannot't know what happened to diskdump.
By this correction, spin_lock_irq() is skipped and show_registers()
shows stack trace. User may be able to know what happened even if dump
fails.


>
>
>> +#ifndef TRUE
>> +#define TRUE	1
>> +#endif
>> +#ifndef FALSE
>> +#define FALSE	0
>> +#endif
>
>it's kernel convention to just use 0 and !0 

OK.


>
>> +MODULE_PARM(fallback_on_err, "i");
>> +MODULE_PARM(allow_risky_dumps, "i");
>> +MODULE_PARM(block_order, "i");
>> +MODULE_PARM(sample_rate, "i");
>
>please exclusively use the 2.6 module parameter mechanism for new code.

I see. I'll change this code using __setup.



>> +		page = mem_map + nr;
>
>this is not safe for discontig mem and thus broken

Ok, I fix it.

-		page = mem_map + nr;
+		page = pfn_to_page(nr);

I also need fix this.

-	for (nr = 0; nr < max_mapnr; nr++) {
+	for (nr = 0; nr < max_pfn; nr++) {



>> +	/*
>> +	 * Check the checksum of myself
>> +	 */
>> +	spin_trylock(&disk_dump_lock);
>
>you need to handle the failure case of trylock of course

I see, thanks.



>> +#ifdef CONFIG_PROC_FS
>> +static int proc_ioctl(struct inode *inode, struct file *file, unsigned 
>> int cmd, unsigned long param)
>
>
>ehhh this looks evil

Sorry, but would you please explain?



>> diff -Nur linux-2.6.6.org/drivers/block/genhd.c linux-2.6.6/drivers/block
>> /genhd.c
>> --- linux-2.6.6.org/drivers/block/genhd.c	2004-05-10 11:32:29.000000000 
+>> 0900
>> +++ linux-2.6.6/drivers/block/genhd.c	2004-06-09 19:17:46.000000000 +
0900
>> @@ -224,6 +224,8 @@
>>  	return  kobj ? to_disk(kobj) : NULL;
>>  }
>>  
>> +EXPORT_SYMBOL(get_gendisk);
>
>
>this is WRONG. VERY WRONG.

I used get_gendisk() to get gendisk from inode.

	gd = get_gendisk(inode->i_rdev, &part);

But, I can get gendiskd by i_bdev->bd_disk, so this export
is not needed. I remove it.


Best Regards,
Takao Indoh
