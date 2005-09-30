Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVI3JTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVI3JTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 05:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVI3JTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 05:19:35 -0400
Received: from ns1.trc-odintsovo.ru ([213.85.88.5]:34978 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932554AbVI3JTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 05:19:34 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: reiserfs-dev@namesys.com
Subject: Re: 2.6.14-rc2-mm2
Date: Fri, 30 Sep 2005 13:20:37 +0400
User-Agent: KMail/1.8
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050929143732.59d22569.akpm@osdl.org> <433C7EC9.4000604@ens-lyon.org> <433CFB32.4030105@free.fr>
In-Reply-To: <433CFB32.4030105@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509301320.38161.zam@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 September 2005 12:45, Laurent Riffard wrote:
> Le 30.09.2005 01:54, Brice Goglin a écrit :
> > Le 30.09.2005 01:40, Michal Piotrowski a écrit :
> >>It maybe a problem with gentoo gcc.
> >
> > I'm seeing the same error with Debian gcc4.
> >
> > bgoglin@puligny:/usr/src/linux-mm$ gcc --version
> > gcc (GCC) 4.0.1 (Debian 4.0.1-2)
> >
> > By the way, the error appears when compiling
> >   CC [M]  fs/reiser4/debug.o
> > while DEBUG is disabled for REISER4.
> >
> > My .config attached
> > Note that Alexandre forgot to reenable Reiser4 in the .config he sent.
> >
> > Regards,
> > Brice
>
> It seems to appear when CONFIG_SMP=N and CONFIG_DEBUG_SPINLOCK=N and
> CONFIG_REISER4_DEBUG=N.
>
> In this case, spinlock_t is an empty struct (see
> include/linux/spinlock_types.h and
> include/linux/spinlock_types_up.h). Then sizeof(spinlock_t) _is_ 0,
> and this breaks some code like cassert calls from
> fs/reiser4/spin_macros.h line 85 (FIELD is a spinlock_t) :
>      82 static inline void spin_ ## NAME ## _init(TYPE *x)      \
>      83 {                                                       \
>
>      84         __ODCA("nikita-2987", x != NULL);               \
>      85         cassert(sizeof(x->FIELD) != 0);                 \
>
>      86         memset(& x->FIELD, 0, sizeof x->FIELD);         \
>
>      87         spin_lock_init(& x->FIELD.lock);                \
>
>      88 }                                                       \
>
>      89

correct. 

the code will be reworked soon,
a hot fix for now is:
 
-----------------------------------
diff --git a/spin_macros.h b/spin_macros.h
--- a/spin_macros.h
+++ b/spin_macros.h
@@ -82,8 +82,6 @@ typedef struct reiser4_rw_data {
 static inline void spin_ ## NAME ## _init(TYPE *x)				\
 {										\
 	__ODCA("nikita-2987", x != NULL);					\
-	cassert(sizeof(x->FIELD) != 0);						\
-	memset(& x->FIELD, 0, sizeof x->FIELD);					\
 	spin_lock_init(& x->FIELD.lock);					\
 }										\
 										\
@@ -236,7 +234,6 @@ typedef struct { int foo; } NAME ## _spi
 static inline void rw_ ## NAME ## _init(TYPE *x)				\
 {										\
 	__ODCA("nikita-2988", x != NULL);					\
-	memset(& x->FIELD, 0, sizeof x->FIELD);					\
 	rwlock_init(& x->FIELD.lock);						\
 }										\
 										\
-----------------------------------

>
> ~~
> laurent
