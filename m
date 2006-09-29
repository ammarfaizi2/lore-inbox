Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWI2WTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWI2WTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWI2WTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:19:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:56464 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750773AbWI2WTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:19:09 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:references;
	b=ZYSNNvXwCerBK8K2F8fbzBaBRNWa9iIQpbniLsOblXWX3FOYi70hS1Roqw6qBBDt8
	dSRxfkUbmIeJcZ9jGDAaA==
Message-ID: <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
Date: Fri, 29 Sep 2006 15:18:52 -0700
From: "Ollie Wild" <aaw@google.com>
To: "Jeff Dike" <jdike@addtoit.com>
Subject: Re: [PATCH 2/2] UML - Don't roll my own random MAC generator
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, dhollis@davehollis.com,
       "Jason Lunz" <lunz@falooley.org>
In-Reply-To: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4360_29040619.1159568332997"
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4360_29040619.1159568332997
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch as provided breaks my build due to a missing semicolon.

Patch attached.

Ollie

On 9/28/06, Jeff Dike <jdike@addtoit.com> wrote:
> Use the existing random_ether_addr() instead of cooking up my own
> version.  Pointed out by Dave Hollis and Jason Lunz.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> ---
>
>  arch/um/drivers/net_kern.c |    4 +---
>  arch/um/drivers/net_user.c |   29 -----------------------------
>  arch/um/include/net_user.h |    2 --
>  3 files changed, 1 insertion(+), 34 deletions(-)
>
> Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c     2006-09-28 12:51:50.000000000 -0400
> +++ linux-2.6.18-mm/arch/um/drivers/net_kern.c  2006-09-28 13:00:58.000000000 -0400
> @@ -309,9 +309,7 @@ static void setup_etheraddr(char *str, u
>         return;
>
>  random:
> -       addr[0] = 0xfe;
> -       addr[1] = 0xfd;
> -       random_mac(addr);
> +       random_ether_addr(addr)
>  }
>
>  static DEFINE_SPINLOCK(devices_lock);
> Index: linux-2.6.18-mm/arch/um/drivers/net_user.c
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/drivers/net_user.c     2006-09-28 12:51:50.000000000 -0400
> +++ linux-2.6.18-mm/arch/um/drivers/net_user.c  2006-09-28 13:00:06.000000000 -0400
> @@ -259,32 +259,3 @@ char *split_if_spec(char *str, ...)
>         va_end(ap);
>         return str;
>  }
> -
> -void random_mac(unsigned char *addr)
> -{
> -       struct timeval tv;
> -       long n;
> -       unsigned int seed;
> -
> -       gettimeofday(&tv, NULL);
> -
> -       /* Assume that 20 bits of microseconds and 12 bits of the pid are
> -        * reasonably unpredictable.
> -        */
> -       seed = tv.tv_usec | (os_getpid() << 20);
> -       srandom(seed);
> -
> -       /* Don't care about endianness here - switching endianness
> -        * just rearranges what are hopefully random numbers.
> -        *
> -        * Assume that RAND_MAX > 65536, so random is called twice and
> -        * we use 16 bits of the result.
> -        */
> -       n = random();
> -       addr[2] = (n >> 8) & 255;
> -       addr[3] = n % 255;
> -
> -       n = random();
> -       addr[4] = (n >> 8) & 255;
> -       addr[5] = n % 255;
> -}
> Index: linux-2.6.18-mm/arch/um/include/net_user.h
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/include/net_user.h     2006-09-28 12:15:48.000000000 -0400
> +++ linux-2.6.18-mm/arch/um/include/net_user.h  2006-09-28 13:01:51.000000000 -0400
> @@ -50,6 +50,4 @@ extern char *split_if_spec(char *str, ..
>
>  extern int dev_netmask(void *d, void *m);
>
> -extern void random_mac(unsigned char *addr);
> -
>  #endif
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

------=_Part_4360_29040619.1159568332997
Content-Type: text/x-patch; name=random_ether_addr.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esp50wda
Content-Disposition: attachment; filename="random_ether_addr.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vZHJpdmVycy9uZXRfa2Vybi5jIGIvYXJjaC91bS9kcml2ZXJz
L25ldF9rZXJuLmMKaW5kZXggMTZhYTU3Mi4uMzAwYTU0YSAxMDA2NDQKLS0tIGEvYXJjaC91bS9k
cml2ZXJzL25ldF9rZXJuLmMKKysrIGIvYXJjaC91bS9kcml2ZXJzL25ldF9rZXJuLmMKQEAgLTMx
MCw3ICszMTAsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cF9ldGhlcmFkZHIoY2hhciAqc3RyLCB1CiAJ
cmV0dXJuOwogCiByYW5kb206Ci0JcmFuZG9tX2V0aGVyX2FkZHIoYWRkcikKKwlyYW5kb21fZXRo
ZXJfYWRkcihhZGRyKTsKIH0KIAogc3RhdGljIERFRklORV9TUElOTE9DSyhkZXZpY2VzX2xvY2sp
Owo=
------=_Part_4360_29040619.1159568332997--
