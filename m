Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVF3OOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVF3OOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbVF3OOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:14:04 -0400
Received: from [195.23.16.24] ([195.23.16.24]:20437 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262973AbVF3ONW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:13:22 -0400
Message-ID: <42C3FDED.8080000@grupopie.com>
Date: Thu, 30 Jun 2005 15:13:01 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: prasanna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kprobes: Verify probepoint in register_jprobe()
References: <42C2BD26.7090209@gmail.com>
In-Reply-To: <42C2BD26.7090209@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna wrote:
> [...]
>  int register_jprobe(struct jprobe *jp)
>  {
> -	/* Todo: Verify probepoint is a function entry point */
> +	unsigned long size, offset;
> +	char *modname, namebuf[KSYM_NAME_LEN+1];
> +	
> +	kallsyms_lookup((unsigned long)jp->kp.addr, &size,
> +			&offset, &modname, namebuf);
> +	
> +	if(unlikely(offset))
> +		return -EINVAL;

Hmmm, kallsyms_lookup might return NULL if either the address is not 
found or CONFIG_KALLSYMS is not set, and in this case "offset" is not 
initialized at all before this test.

We should either fail in this case, or accept the address as valid 
without confirmation. I don't have sufficient knowledge about kprobes to 
advise either way, but a test should be made nevertheless (or we could 
just initialize "offset" to 0, if we want to accept the address without 
confirmation).

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
