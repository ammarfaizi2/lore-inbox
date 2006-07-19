Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWGSNxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWGSNxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 09:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWGSNxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 09:53:36 -0400
Received: from [195.23.16.24] ([195.23.16.24]:31645 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S964817AbWGSNxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 09:53:35 -0400
Message-ID: <44BE395B.2090001@grupopie.com>
Date: Wed, 19 Jul 2006 14:53:31 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com, chas@cmf.nrl.navy.mil,
       miquel@df.uba.ar, kkeil@suse.de, benh@kernel.crashing.org,
       video4linux-list@redhat.com, rmk+mmc@arm.linux.org.uk,
       Neela.Kolli@engenio.com, jgarzik@pobox.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060719004659.GA30823@lumumba.uhasselt.be>
In-Reply-To: <20060719004659.GA30823@lumumba.uhasselt.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> [...]
> --- a/drivers/char/consolemap.c
> +++ b/drivers/char/consolemap.c
> @@ -192,11 +192,9 @@ static void set_inverse_transl(struct vc
>  	q = p->inverse_translations[i];
>  
>  	if (!q) {
> -		q = p->inverse_translations[i] = (unsigned char *) 
> -			kmalloc(MAX_GLYPH, GFP_KERNEL);
> +		q = p->inverse_translations[i] = kzalloc(MAX_GLYPH, GFP_KERNEL);
>  		if (!q) return;
>  	}
> -	memset(q, 0, MAX_GLYPH);

This changes semantics here. Before, the data pointed by q was always 
cleared whether it was malloc'ed or not. Now it is only cleared if it is 
malloc'ed. I haven't checked the code to find out if this is ok, though.

> @@ -2704,8 +2702,7 @@ static void cardmap_set(struct cardmap *
>  	if (p == NULL || (nr >> p->shift) >= CARDMAP_WIDTH) {
>  		do {
>  			/* need a new top level */
> -			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
> -			memset(np, 0, sizeof(*np));
> +			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
>  			np->ptr[0] = p;
>  			if (p != NULL) {
>  				np->shift = p->shift + CARDMAP_ORDER;
> @@ -2719,8 +2716,7 @@ static void cardmap_set(struct cardmap *
>  	while (p->shift > 0) {
>  		i = (nr >> p->shift) & CARDMAP_MASK;
>  		if (p->ptr[i] == NULL) {
> -			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
> -			memset(np, 0, sizeof(*np));
> +			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
>  			np->shift = p->shift - CARDMAP_ORDER;
>  			np->parent = p;
>  			p->ptr[i] = np;

This is not your fault, but this code is using the return value from 
kmalloc (or kzalloc, now) without checking for NULL.

> diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
> index 76edbb6..71d4743 100644
> --- a/drivers/scsi/megaraid.c
> +++ b/drivers/scsi/megaraid.c
> @@ -4487,8 +4487,7 @@ mega_internal_command(adapter_t *adapter
>  	scmd = &adapter->int_scmd;
>  	memset(scmd, 0, sizeof(Scsi_Cmnd));
>  
> -	sdev = kmalloc(sizeof(struct scsi_device), GFP_KERNEL);
> -	memset(sdev, 0, sizeof(struct scsi_device));
> +	sdev = kzalloc(sizeof(struct scsi_device), GFP_KERNEL);
>  	scmd->device = sdev;
>  
>  	scmd->device->host = adapter->host;

Same here.

> --- a/drivers/video/offb.c
> +++ b/drivers/video/offb.c
> @@ -376,13 +376,12 @@ static void __init offb_init_fb(const ch
>  
>  	size = sizeof(struct fb_info) + sizeof(u32) * 17;
>  
> -	info = kmalloc(size, GFP_ATOMIC);
> +	info = kzalloc(size, GFP_ATOMIC);
>  	
>  	if (info == 0) {

Again, not your fault, but "info == 0"? If you're doing a new version of 
the patch, please change this to NULL or !info, so that we don't confuse 
human readers :)

-- 
Paulo Marques - www.grupopie.com

"I can picture in my mind a world without war, a world
without hate. And I can picture us attacking that world,
because they'd never expect it."
