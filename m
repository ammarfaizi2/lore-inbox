Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVHaNvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVHaNvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVHaNvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:51:14 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:25691 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932515AbVHaNvN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:51:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VfKoW5pu1M8kTiPoSAzH3ZI0OZlbIvCKShgUgi8kMeJD54Ee5vq1NOQCjMJVScGjBjiUI511tVBX4NeRiAbvtYJYQRz8iAI6PQO8wSofAfY7ZhDmq1zBZz9Xt2L4hNiMgtgg7rNDJ1ZMa0twHvt2xKloT4vOCBMryGJsAUvOrEM=
Message-ID: <84144f0205083106517f67d057@mail.gmail.com>
Date: Wed, 31 Aug 2005 16:51:08 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
In-Reply-To: <4315A94E.3030901@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp>
	 <84144f0205083103005b791f4d@mail.gmail.com>
	 <4315A94E.3030901@sm.sony.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> How about this ?
> 
>         if (!MSDOS_I(dir)->scan_hints) {
>                 hints  = kcalllo(....);
> 
>                 down
>                 if (MSDOS_I(dir)->scan_hints) {
>                         up
>                         goto already_allocated;
>                 }
>                 if (hints)
>                         MSDOS_I(dir)->scan_hints = hints;
>                 up
>         }
>         return (hints == 0) ? -ENOMEM : 0;
> 
> already_allocated:
>         kfree(hints); /* kfree accepts NULL */
>         return 0;

After finally understanding what you're doing, how about:

static inline int hint_allocate(struct inode *dir)
{
        loff_t *hints;
        int err = 0;

        if (!MSDOS_I(dir)->scan_hints)
                return 0;

        hints = kcalloc(FAT_SCAN_NWAY, sizeof(loff_t), GFP_KERNEL);
        if (!hints)
                err = -ENOMEM;

        down(&MSDOS_I(dir)->scan_lock);
        /*
         * We allocated memory without scan_lock so lets make sure
         * no other thread completed hint_allocate() before us.
         */
        if (!MSDOS_I(dir)->scan_hints) {
                MSDOS_I(dir)->scan_hints = hints;
                hints = NULL;
        }
        up(&MSDOS_I(dir)->scan_lock);

        kfree(hints);
        return err;
}

                                    Pekka
