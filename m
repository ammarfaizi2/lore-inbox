Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVAZOct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVAZOct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVAZOct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:32:49 -0500
Received: from [195.23.16.24] ([195.23.16.24]:59867 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262311AbVAZOci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:32:38 -0500
Message-ID: <41F7A9F6.20804@grupopie.com>
Date: Wed, 26 Jan 2005 14:32:22 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: rusty@rustcorp.com.au, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] modules: add version and srcversion to sysfs
References: <20050119171357.GA16136@lst.de> <20050119172106.GB32702@kroah.com> <20050119213924.GG5508@us.ibm.com> <20050119224016.GA5086@kroah.com> <20050119230350.GA23553@infradead.org> <20050119230855.GA5646@kroah.com> <20050119231559.GA10404@lists.us.dell.com> <20050119234219.GA6294@kroah.com> <20050126060541.GA16017@lists.us.dell.com>
In-Reply-To: <20050126060541.GA16017@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> [...]
>  
> +static char *strdup(const char *str)
> +{
> +	char *s;
> +
> +	if (!str)
> +		return NULL;
> +	s = kmalloc(strlen(str)+1, GFP_KERNEL);
> +	if (!s)
> +		return NULL;
> +	strcpy(s, str);
> +	return s;
> +}
> +

There is already this code in sound/core/memory.c:

char *snd_kmalloc_strdup(const char *string, int flags)
{
	size_t len;
	char *ptr;

	if (!string)
		return NULL;
	len = strlen(string) + 1;
	ptr = _snd_kmalloc(len, flags);
	if (ptr)
		memcpy(ptr, string, len);
	return ptr;
}

and grep'ing the includes for "strdup" gives this:

./linux/netdevice.h:extern char *net_sysctl_strdup(const char *s);
./linux/parser.h:char *match_strdup(substring_t *);
./sound/core.h:char *snd_kmalloc_strdup(const char *string, int flags);

Actually, I've just grep'ed the entire tree and there are about 7 
similar implementations all over the place:

./arch/um/kernel/process_kern.c:char *uml_strdup(char *string)
./drivers/parport/probe.c:static char *strdup(char *str)
./drivers/md/dm-ioctl.c:static inline char *kstrdup(const char *str)
./net/core/sysctl_net_core.c:char *net_sysctl_strdup(const char *s)
./net/sunrpc/svcauth_unix.c:static char *strdup(char *s)
./sound/core/memory.c:char *snd_kmalloc_strdup(const char *string, int 
flags)
./lib/parser.c:char *match_strdup(substring_t *s)

So maybe we should turn this into a library function and modify the 
callers, so that we have only one implementation. The implementation 
from sound/core seems better for a library function, because of the 
flags argument (and it seems a little more eficient too).

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

