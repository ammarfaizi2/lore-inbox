Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVATUcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVATUcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVATUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:30:15 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:4814 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261931AbVATU1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:27:50 -0500
Message-ID: <41F01415.2010904@kolivas.org>
Date: Fri, 21 Jan 2005 07:27:01 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: utz lehmann <lkml@s2y4n2c.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, joq@io.com, CK Kernel <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt	scheduling
References: <41EEE1B1.9080909@kolivas.org>	 <1106180177.4036.27.camel@segv.aura.of.mankind> <1106243698.719.6.camel@boxen>
In-Reply-To: <1106243698.719.6.camel@boxen>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8834E8ECBF5546F8AC472483"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8834E8ECBF5546F8AC472483
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alexander Nyberg wrote:
>>My simple yield DoS don't work anymore. But i found another way.
>>Running this as SCHED_ISO:
> 
> 
> Yep, bad accounting in queue_iso() which relied on p->array == rq->active
> This fixes it:
> 
> 
> Index: vanilla/kernel/sched.c
> ===================================================================
> --- vanilla.orig/kernel/sched.c	2005-01-20 18:05:59.000000000 +0100
> +++ vanilla/kernel/sched.c	2005-01-20 18:41:26.000000000 +0100
> @@ -2621,15 +2621,19 @@
>  static task_t* queue_iso(runqueue_t *rq, prio_array_t *array)
>  {
>  	task_t *p = list_entry(rq->iso_queue.next, task_t, iso_list);
> -	if (p->prio == MAX_RT_PRIO)
> -		goto out;
> +	prio_array_t *old_array = p->array;
> +	
> +	old_array->nr_active--;
>  	list_del(&p->run_list);
> -	if (list_empty(array->queue + p->prio))
> -		__clear_bit(p->prio, array->bitmap);
> +	if (list_empty(old_array->queue + p->prio))
> +		__clear_bit(p->prio, old_array->bitmap);
> +	
>  	p->prio = MAX_RT_PRIO;
>  	list_add_tail(&p->run_list, array->queue + p->prio);
>  	__set_bit(p->prio, array->bitmap);
> -out:
> +	array->nr_active++;
> +	p->array = array;
> +	
>  	return p;
>  }
>  
> 

Excellent pickup, thanks!

Acked-by: Con Kolivas <kernel@kolivas.org>

--------------enig8834E8ECBF5546F8AC472483
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8BQVZUg7+tp6mRURAgnuAJ4lHv4l18buDNWrMMhxtdeldkGR5ACfUJob
d7KOIcv4709RGVIFruaEED4=
=9ji/
-----END PGP SIGNATURE-----

--------------enig8834E8ECBF5546F8AC472483--
