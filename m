Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132703AbRAXPis>; Wed, 24 Jan 2001 10:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbRAXPil>; Wed, 24 Jan 2001 10:38:41 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:57984 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132130AbRAXPib>; Wed, 24 Jan 2001 10:38:31 -0500
Message-ID: <3A6EF8AC.DFC50D37@uow.edu.au>
Date: Thu, 25 Jan 2001 02:45:48 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <3A6C5058.C5AA7681@zaralinux.com> <3A6CB620.469A15A9@Home.net> <3A6ED16E.E8343678@innominate.de> <20010124082929.A1970@xi.linuxpower.cx> <3A6EE767.9BD35AC9@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> I don't know much about the history of this bug but it's quite clear
> it's deliberately inserted:
> 
>         void * kmalloc (size_t size, int flags)
>                 <if allocation succeeds, exit>
>                 BUG(); // too big size
>                 return NULL;
> 

I sent the below patch to Linus earlier today.  I didn't copy
any mailing list because it's a bit security-related.  Oh well.

If wmem_max is set to > 256kbytes, an application can
set SO_SNDBUF on a unix domain stream socket to >256k
and do a write() of >256k.  unix_stream_sendmsg()
then tries to kmalloc >128k and the kernel dies.

I don't like the idea of simply returning NULL from kmalloc in
this case, because an application which does

	setsockopt(fd, SOL_SOCKET, SO_SNDBUF, 256kbytes);
	write(fd, buf, 256kbytes);

will work perfectly well, until someone increases wmem_max
to greater than 256k.  This administrative action will
cause the above application to mysteriously start failing.




--- linux-2.4.1-pre10/include/linux/slab.h	Mon Jan  1 18:29:35 2001
+++ linux-akpm/include/linux/slab.h	Wed Jan 24 12:29:34 2001
@@ -75,6 +75,9 @@
 extern kmem_cache_t	*fs_cachep;
 extern kmem_cache_t	*sigact_cachep;
 
+/* Largest kmalloc which we support */
+extern size_t kmalloc_max;
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
--- linux-2.4.1-pre10/mm/slab.c	Tue Jan 23 19:28:16 2001
+++ linux-akpm/mm/slab.c	Wed Jan 24 12:57:47 2001
@@ -360,6 +360,9 @@
 /* Place maintainer for reaping. */
 static kmem_cache_t *clock_searchp = &cache_cache;
 
+/* Largest kmalloc which we support */
+size_t kmalloc_max;
+
 #define cache_chain (cache_cache.next)
 
 #ifdef CONFIG_SMP
@@ -455,6 +458,7 @@
 			      SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sizes->cs_dmacachep)
 			BUG();
+		kmalloc_max = sizes->cs_size;
 		sizes++;
 	} while (sizes->cs_size);
 }
--- linux-2.4.1-pre10/kernel/ksyms.c	Tue Jan 23 19:28:16 2001
+++ linux-akpm/kernel/ksyms.c	Wed Jan 24 12:17:28 2001
@@ -104,6 +104,7 @@
 EXPORT_SYMBOL(kmem_cache_alloc);
 EXPORT_SYMBOL(kmem_cache_free);
 EXPORT_SYMBOL(kmalloc);
+EXPORT_SYMBOL(kmalloc_max);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
--- linux-2.4.1-pre10/net/unix/af_unix.c	Tue Jan 23 19:28:16 2001
+++ linux-akpm/net/unix/af_unix.c	Wed Jan 24 12:57:35 2001
@@ -1319,6 +1319,10 @@
 		if (size > sk->sndbuf/2 - 16)
 			size = sk->sndbuf/2 - 16;
 
+		/* Avoid oversized kmallocs */
+		if (size > kmalloc_max / 2 - 16)
+			size = kmalloc_max / 2 - 16;
+
 		/*
 		 *	Keep to page sized kmalloc()'s as various people
 		 *	have suggested. Big mallocs stress the vm too
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
