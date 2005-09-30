Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVI3KLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVI3KLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 06:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVI3KLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 06:11:04 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:26253 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964975AbVI3KLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 06:11:02 -0400
Message-ID: <433D0F32.8070303@free.fr>
Date: Fri, 30 Sep 2005 12:10:58 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.11) Gecko/20050729
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Alexander Zarochentsev <zam@namesys.com>
CC: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org> <433C7EC9.4000604@ens-lyon.org> <433CFB32.4030105@free.fr> <200509301320.38161.zam@namesys.com>
In-Reply-To: <200509301320.38161.zam@namesys.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le 30.09.2005 11:20, Alexander Zarochentsev a écrit :
> On Friday 30 September 2005 12:45, Laurent Riffard wrote:
> 
>>Le 30.09.2005 01:54, Brice Goglin a écrit :
>>
>>>Le 30.09.2005 01:40, Michal Piotrowski a écrit :
>>>
>>>>It maybe a problem with gentoo gcc.
>>>
>>>I'm seeing the same error with Debian gcc4.
>>>
>>>bgoglin@puligny:/usr/src/linux-mm$ gcc --version
>>>gcc (GCC) 4.0.1 (Debian 4.0.1-2)
>>>
>>>By the way, the error appears when compiling
>>>  CC [M]  fs/reiser4/debug.o
>>>while DEBUG is disabled for REISER4.
>>>
>>>My .config attached
>>>Note that Alexandre forgot to reenable Reiser4 in the .config he sent.
>>>
>>>Regards,
>>>Brice
>>
>>It seems to appear when CONFIG_SMP=N and CONFIG_DEBUG_SPINLOCK=N and
>>CONFIG_REISER4_DEBUG=N.
>>
>>In this case, spinlock_t is an empty struct (see
>>include/linux/spinlock_types.h and
>>include/linux/spinlock_types_up.h). Then sizeof(spinlock_t) _is_ 0,
>>and this breaks some code like cassert calls from
>>fs/reiser4/spin_macros.h line 85 (FIELD is a spinlock_t) :
>>     82 static inline void spin_ ## NAME ## _init(TYPE *x)      \
>>     83 {                                                       \
>>
>>     84         __ODCA("nikita-2987", x != NULL);               \
>>     85         cassert(sizeof(x->FIELD) != 0);                 \
>>
>>     86         memset(& x->FIELD, 0, sizeof x->FIELD);         \
>>
>>     87         spin_lock_init(& x->FIELD.lock);                \
>>
>>     88 }                                                       \
>>
>>     89
> 
> 
> correct. 
> 
> the code will be reworked soon,
> a hot fix for now is:
>  
> -----------------------------------
> diff --git a/spin_macros.h b/spin_macros.h
> --- a/spin_macros.h
> +++ b/spin_macros.h
> @@ -82,8 +82,6 @@ typedef struct reiser4_rw_data {
>  static inline void spin_ ## NAME ## _init(TYPE *x)				\
>  {										\
>  	__ODCA("nikita-2987", x != NULL);					\
> -	cassert(sizeof(x->FIELD) != 0);						\
> -	memset(& x->FIELD, 0, sizeof x->FIELD);					\
>  	spin_lock_init(& x->FIELD.lock);					\
>  }										\
>  										\
> @@ -236,7 +234,6 @@ typedef struct { int foo; } NAME ## _spi
>  static inline void rw_ ## NAME ## _init(TYPE *x)				\
>  {										\
>  	__ODCA("nikita-2988", x != NULL);					\
> -	memset(& x->FIELD, 0, sizeof x->FIELD);					\
>  	rwlock_init(& x->FIELD.lock);						\
>  }										\
>  										\
> -----------------------------------
> 
> 
>>~~
>>laurent

Ok, compiled and booted.

[root@antares ~]# cat /proc/version
Linux version 2.6.14-rc2-mm2 (laurent@antares.localdomain) (gcc
version 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0)) #6 Fri
Sep 30 11:30:02 CEST 2005

thanks
~~
laurent
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDPQ8xUqUFrirTu6IRAnigAKCqJp+eGSvmwRw+VdZcKi7qdgX2zQCfcQFT
h03UuogYvijwfM6nZpdUF0Q=
=W6Cj
-----END PGP SIGNATURE-----
