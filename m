Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVHaKAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVHaKAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVHaKAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:00:44 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:8624 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750739AbVHaKAo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:00:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BuFnvok/IXDkoU8juAo9VEPRhi/CDVms8lT/ozgs/5ywLkV1LcIuVS/lPan5uBW4BvVL9DklLD4p+oqFbSTTtnPx0xlSw2B2QpW/fhHIFGT14MYf4a4zl53QdiEsW7eE4SwFO102q+O/sX0kV3AIog3CqgUWeTHutCHvZ37ji/o=
Message-ID: <84144f0205083103005b791f4d@mail.gmail.com>
Date: Wed, 31 Aug 2005 13:00:38 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <43156963.8020203@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> +inline
> +static int hint_allocate(struct inode *dir)
> +{
> +       loff_t *hints;
> +       int err = 0;
> +
> +       if (!MSDOS_I(dir)->scan_hints) {
> +               hints = kcalloc(FAT_SCAN_NWAY, sizeof(loff_t), GFP_KERNEL);
> +               if (!hints)
> +                       err = -ENOMEM;

Better to bail out here as...

> +
> +               down(&MSDOS_I(dir)->scan_lock);
> +               if (MSDOS_I(dir)->scan_hints)
> +                       err = -EINVAL;

...you might overwrite -ENOMEM here masking the real problem.

> +               if (!err)
> +                       MSDOS_I(dir)->scan_hints = hints;
> +               up(&MSDOS_I(dir)->scan_lock);
> +               if (err == -EINVAL) {

Gotos would make error handling much cleaner.

> +inline
> +static int hint_index_body(const unsigned char *name, int name_len, int check_null)

Please consider calling this __hint_index() instead as per normal
naming conventions.

> +{
> +       int i;
> +       int val = 0;
> +       unsigned char *p = (unsigned char *) name;
> +       int id = current->pid;
> +
> +       for (i=0; i<name_len; i++) {
> +               if (check_null && !*p) break;

Please put break on separate line. You still have quite a few of these.

> +               val = ((val << 1) & 0xfe) | ((val & 0x80) ? 1 : 0);
> +               val ^= *p;
> +               p ++;
> +       }
> +       id = ((id >> 8) & 0xf) ^ (id & 0xf);
> +       val = (val << 1) | (id & 1);
> +       return val & (FAT_SCAN_NWAY-1);
> +}

                              Pekka
