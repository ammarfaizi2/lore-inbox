Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265012AbTGBOIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbTGBOIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:08:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:44489 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265012AbTGBOIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:08:16 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: dm-devel@sistina.com, Joe Thornber <thornber@sistina.com>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Date: Wed, 2 Jul 2003 09:17:12 -0500
User-Agent: KMail/1.5
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030702085951.GB410@fib011235813.fsnet.co.uk> <20030702110044.GE6243@fib011235813.fsnet.co.uk>
In-Reply-To: <20030702110044.GE6243@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307020917.12337.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This definitely seems to make more sense.

On Wednesday 02 July 2003 06:00, Joe Thornber wrote:
> dm_swap_table() will now fail for a table with no targets.
> --- diff/drivers/md/dm.c	2003-07-01 15:36:42.000000000 +0100
> +++ source/drivers/md/dm.c	2003-07-02 11:53:22.000000000 +0100
> @@ -664,10 +664,10 @@
>  	md->map = t;
>
>  	size = dm_table_get_size(t);
> -	set_capacity(md->disk, size);
> -	if (size == 0)
> -		return 0;
> +	if (!size)
> +		return -EINVAL;
>
> +	set_capacity(md->disk, size);
>  	dm_table_event_callback(md->map, event_callback, md);
>
>  	dm_table_get(t);
> @@ -759,8 +759,10 @@
>
>  	__unbind(md);
>  	r = __bind(md, table);
> -	if (r)
> +	if (r) {
> +		up_write(&md->lock);
>  		return r;
> +	}
>
>  	up_write(&md->lock);
>  	return 0;
>

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

