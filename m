Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271769AbRICSgT>; Mon, 3 Sep 2001 14:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRICSgJ>; Mon, 3 Sep 2001 14:36:09 -0400
Received: from t2.redhat.com ([199.183.24.243]:17911 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S271765AbRICSgA>; Mon, 3 Sep 2001 14:36:00 -0400
Message-ID: <3B93CD9D.35ED4F1C@redhat.com>
Date: Mon, 03 Sep 2001 14:36:13 -0400
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup gendisk handling
In-Reply-To: <20010903200504.A30093@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/genhd.c linux/drivers/block/genhd.c
> --- ../master/linux-2.4.10-pre4/drivers/block/genhd.c   Fri Jul 20 02:48:15 2001
> +++ linux/drivers/block/genhd.c Mon Sep  3 19:38:50 2001
> @@ -17,6 +17,75 @@
>  #include <linux/blk.h>
>  #include <linux/init.h>
> 
> +
> +struct gendisk *gendisk_head;
> +
> +void
> +add_gendisk(struct gendisk *gp)
> +{
> +       gp->next = gendisk_head;
> +       gendisk_head = gp;
> +}
> +
> +void
> +del_gendisk(struct gendisk *gp)
> +{
> +       struct gendisk **gpp;
> +
> +       for (gpp = &gendisk_head; *gpp; gpp = &((*gpp)->next))
> +               if (*gpp == gp)
> +                       break;
> +       if (*gpp)
> +               *gpp = (*gpp)->next;
> +}
> +
> +struct gendisk *
> +get_gendisk(kdev_t dev)
> +{
> +       struct gendisk *gp = NULL;
> +       int maj = MAJOR(dev);
> +
> +       for (gp = gendisk_head; gp; gp = gp->next)
> +               if (gp->major == maj)
> +                       return gp;
> +       return NULL;
> +}
> +
> +#ifdef CONFIG_PROC_FS
> +int
> +get_partition_list(char *page, char **start, off_t offset, int count)
> +{
> +       struct gendisk *gp;
> +       char buf[64];
> +       int len, n;
> +
> +       len = sprintf(page, "major minor  #blocks  name\n\n");
> +       for (gp = gendisk_head; gp; gp = gp->next) {
> +               for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
> +                       if (gp->part[n].nr_sects == 0)
> +                               continue;
> +
> +                       len += snprintf(page + len, 63,
> +                                       "%4d  %4d %10d %s\n",
> +                                       gp->major, n, gp->sizes[n],
> +                                       disk_name(gp, n, buf));
> +                       if (len < offset)
> +                               offset -= len, len = 0;
> +                       else if (len >= offset + count)
> +                               goto out;
> +               }
> +       }
> +
> +out:
> +       *start = page + offset;
> +       len -= offset;
> +       if (len < 0)
> +               len = 0;
> +       return len > count ? count : len;
> +}
> +#endif
> +
> +
>  extern int blk_dev_init(void);
>  #ifdef CONFIG_BLK_DEV_DAC960
>  extern void DAC960_Initialize(void);


Hi,

I had a patch similar to this one a while ago (and it got dropped); One
difference is that your patch doesn't 
seem to lock the linked list... so the operation is SMP unsafe (it was
before, but fixing that would be a 
good sideeffect of this patch)

Greetings,
   Arjan van de Ven
