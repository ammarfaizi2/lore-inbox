Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbULDA2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbULDA2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbULDA2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:28:48 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:43701 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262509AbULDAXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:23:48 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] loopback device can't act as its backing store
To: Andrew Morton <akpm@osdl.org>, franz_pletz@t-online.de, axboe@suse.de,
       linux-kernel@vger.kernel.org, ludoschmidt@web.de
Reply-To: 7eggert@nurfuerspam.de
Date: Sat, 04 Dec 2004 01:25:20 +0100
References: <fa.gge7q0c.1pjgej6@ifi.uio.no> <fa.gbb6job.1um2er1@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1CaNjk-0001Tu-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> +        /* Avoid recursion */
> +        f = file;
> +        while (is_loop_device(f)) {
> +                struct loop_device *l;
> +
> +                if (f->f_mapping->host == lo_file->f_mapping->host)
> +                        goto out_putf;
> +                l = f->f_mapping->host->i_bdev->bd_disk->private_data;
> +                if (l->lo_state == Lo_unbound)
> +                        break;
> +                f = l->lo_backing_file;
> +        }
> 

This seems wrong to me. AFAI can see, this does not address

1) a->b->c->b->... (Maybe it' is catched later after some recursions)
2) the max. recursion problem you mentioned. (Maybe it's catched by
   not having enough loop devices and catching (1), but this may change)


I think the real fix is something like: (guess from this patch, untested)

f = file;
i = MAX_LOOP_CHAIN;
while (is_loop_device(f)) {
        struct loop_device *l;

/* if MAX_LOOP_CHAIN is high, leaving in the old check might be a nice
   shortcut for the common case. Is it?
 */

        if(!--i) goto out_putf;
/* off by one? I don't think so, but check it 'cause it's late. */

        l = f->f_mapping->host->i_bdev->bd_disk->private_data;
        if (l->lo_state == Lo_unbound)
                break;
/* shouldn't we generate an error instead?
   I guess the error will be generated while recursing, but we just
   followed the chain and know the result.
 */
        f = l->lo_backing_file;
}

