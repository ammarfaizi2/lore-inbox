Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTFJOZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTFJOZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:25:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10940 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262878AbTFJOZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:25:05 -0400
Date: Tue, 10 Jun 2003 09:38:20 -0500
Subject: Re: Misc 2.5 Fixes: cp-user-cmpci
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
To: dipankar@in.ibm.com
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030610100950.GE2194@in.ibm.com>
Message-Id: <2EA0732F-9B51-11D7-8E3D-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, Jun 10, 2003, at 05:09 US/Central, Dipankar Sarma wrote:
>
> Fix copy/user problems. Not sure why cm_write() needs to do
> acces_ok() on buffer twice. Also __get_user() return value isn't 
> checked
> in trans_ac3().

Hey Dipankar, this file has been fixed in bitkeeper.

>  sound/oss/cmpci.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)
>
> diff -puN sound/oss/cmpci.c~cp-user-cmpci sound/oss/cmpci.c
> --- linux-2.5.70-ds/sound/oss/cmpci.c~cp-user-cmpci	2003-06-08 
> 15:36:16.000000000 +0530
> +++ linux-2.5.70-ds-dipankar/sound/oss/cmpci.c	2003-06-08 
> 20:39:03.000000000 +0530
> @@ -588,7 +588,8 @@ static void trans_ac3(struct cm_state *s
>  	unsigned short *src = (unsigned short *)source;
>
>  	do {
> -		data = (unsigned long) *src++;
> +		__get_user(data, src);
> +		src++;
>  		data <<= 12;			// ok for 16-bit data
>  		if (s->spdif_counter == 2 || s->spdif_counter == 3)
>  			data |= 0x40000000;	// indicate AC-3 raw data

Above you mentioned that __get_user isn't checked, but it clearly 
should be. trans_ac3 has been made to return an error code.

> @@ -1600,9 +1601,9 @@ static ssize_t cm_write(struct file *fil
>  			return -ENXIO;
>  		if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
>  			return ret;
> -		if (!access_ok(VERIFY_READ, buffer, count))
> -			return -EFAULT;
>  	}
> +	if (!access_ok(VERIFY_READ, buffer, count))
> +		return -EFAULT;
>  	ret = 0;
>
>  	while (count > 0) {

Good catch. However if I'm reading it right you still have two 
access_ok calls (the other is a few lines above this patch context).

-- 
Hollis Blanchard
IBM Linux Technology Center

