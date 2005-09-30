Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVI3Ipr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVI3Ipr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVI3Ipr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:45:47 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53181 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932577AbVI3Ipq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:45:46 -0400
Message-ID: <433CFB32.4030105@free.fr>
Date: Fri, 30 Sep 2005 10:45:38 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.11) Gecko/20050729
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
CC: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org>	 <433C60B1.8080003@ens-lyon.fr> <20050929155646.757339a9.akpm@osdl.org>	 <433C65F2.4000300@ens-lyon.fr> <6bffcb0e05092916407befe248@mail.gmail.com> <433C7EC9.4000604@ens-lyon.org>
In-Reply-To: <433C7EC9.4000604@ens-lyon.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le 30.09.2005 01:54, Brice Goglin a écrit :
> Le 30.09.2005 01:40, Michal Piotrowski a écrit :
> 
>>It maybe a problem with gentoo gcc.
> 
> 
> I'm seeing the same error with Debian gcc4.
> 
> bgoglin@puligny:/usr/src/linux-mm$ gcc --version
> gcc (GCC) 4.0.1 (Debian 4.0.1-2)
> 
> By the way, the error appears when compiling
>   CC [M]  fs/reiser4/debug.o
> while DEBUG is disabled for REISER4.
> 
> My .config attached
> Note that Alexandre forgot to reenable Reiser4 in the .config he sent.
> 
> Regards,
> Brice

It seems to appear when CONFIG_SMP=N and CONFIG_DEBUG_SPINLOCK=N and
CONFIG_REISER4_DEBUG=N.

In this case, spinlock_t is an empty struct (see
include/linux/spinlock_types.h and
include/linux/spinlock_types_up.h). Then sizeof(spinlock_t) _is_ 0,
and this breaks some code like cassert calls from
fs/reiser4/spin_macros.h line 85 (FIELD is a spinlock_t) :
     82 static inline void spin_ ## NAME ## _init(TYPE *x)      \
     83 {                                                       \

     84         __ODCA("nikita-2987", x != NULL);               \
     85         cassert(sizeof(x->FIELD) != 0);                 \

     86         memset(& x->FIELD, 0, sizeof x->FIELD);         \

     87         spin_lock_init(& x->FIELD.lock);                \

     88 }                                                       \

     89

~~
laurent
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDPPsyUqUFrirTu6IRAlLRAJ4jk3kTaoFKuxE0egg/oTc8DMdtpwCghyR2
kqIhpJdmXai2BKG2ve1BrOU=
=yRrO
-----END PGP SIGNATURE-----
