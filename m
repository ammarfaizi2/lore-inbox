Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbTGBPJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbTGBPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:09:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14230 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265036AbTGBPJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:09:26 -0400
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
To: dm-devel@sistina.com, Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF471CC3D2.35231415-ON85256D57.00541ED2@pok.ibm.com>
From: "Steve Dobbelstein" <steved@us.ibm.com>
Date: Wed, 2 Jul 2003 10:23:45 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 07/02/2003 11:23:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 02 July 2003 06:00, Joe Thornber wrote:
> dm_swap_table() will now fail for a table with no targets.
> --- diff/drivers/md/dm.c           2003-07-01 15:36:42.000000000 +0100
> +++ source/drivers/md/dm.c         2003-07-02 11:53:22.000000000 +0100
> @@ -664,10 +664,10 @@
>            md->map = t;
>
>            size = dm_table_get_size(t);
> -          set_capacity(md->disk, size);
> -          if (size == 0)
> -                      return 0;
> +          if (!size)
> +                      return -EINVAL;
>
> +          set_capacity(md->disk, size);
>            dm_table_event_callback(md->map, event_callback, md);
>
>            dm_table_get(t);
> @@ -759,8 +759,10 @@
>
>            __unbind(md);
>            r = __bind(md, table);
> -          if (r)
> +          if (r) {
> +                      up_write(&md->lock);
>                        return r;
> +          }
>
>            up_write(&md->lock);
>            return 0;

Why the "if (r)"?  Isn't this just the same as:

            __unbind(md);
            r = __bind(md, table);
            up_write(&md->lock);
            return r;

--
Steve Dobbelstein
steved@us.ibm.com
http://evms.sourceforge.net/



