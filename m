Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422789AbWCXJ1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbWCXJ1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWCXJ1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:27:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:64730 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422789AbWCXJ1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:27:49 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Kill machine numbers
Date: Fri, 24 Mar 2006 10:27:38 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       cbe-oss-dev@ozlabs.org, "Machida, Hiroyuki" <machida@sm.sony.co.jp>
References: <1143178947.4257.78.camel@localhost.localdomain>
In-Reply-To: <1143178947.4257.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603241027.39836.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 06:42, Benjamin Herrenschmidt wrote:
> -                       if (strstr(p, RELOC("IBM,CPB")))
> -                               return PLATFORM_CELL;

> +int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
> +{
> +       const char* cp;
> +       unsigned long cplen, l;
> +
> +       cp = of_get_flat_dt_prop(node, "compatible", &cplen);
> +       if (cp == NULL)
> +               return 0;
> +       while (cplen > 0) {
> +               if (strncasecmp(cp, compat, strlen(compat)) == 0)
> +                       return 1;
> +               l = strlen(cp) + 1;
> +               cp += l;
> +               cplen -= l;
> +       }
> +
> +       return 0;
> +}

> +static int __init cell_probe(void)
>  {
> -       if (platform != PLATFORM_CELL)
> +       unsigned long root = of_get_flat_dt_root();
> +       if (!of_flat_dt_is_compatible(root, "IBM,CPB"))
>                 return 0;
>  

Unfortunately, this breaks cell detection. The string in our current
hardware is 'IBM,CPBW-1.0', for reasons you don't want to know.
We just relied on strstr being able to scan for everything starting
with 'IBM,CPB'.

For even more obscure reasons, our future firmware is planned
to no no longer claim compatibility with that but rather with
'CBEA' _and_ 'IBM,CBEA'.

At this point, the issue is getting really complicated, as CBEA
was meant to be a generic identifier for all systems based on
that architecture extension, but we probably want to have different
machine_description data for e.g. IBM and Sony hardware, so they
should check for different values.

As soon as I get to the office, I'll try to do a patch that at
least 

- restores the current functionality by checking for 'IBM,CPBW-1.0'
- also checks for 'IBM,CBEA' so we don't break on future IBM systems

but we should make sure we come to a solution that is practical
to all system vendors that are participating in Linux support.

	Arnd <><
