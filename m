Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275988AbRJPLDm>; Tue, 16 Oct 2001 07:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275989AbRJPLDc>; Tue, 16 Oct 2001 07:03:32 -0400
Received: from ns-muc.aladdin.de ([212.14.90.39]:65285 "EHLO
	ns-muc.ealaddin.com") by vger.kernel.org with ESMTP
	id <S275988AbRJPLDY>; Tue, 16 Oct 2001 07:03:24 -0400
Subject: Re: Very old kernel.
To: Kirill Ratkin <kratkin@yahoo.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.1a (Intl) 17 August 1999
Message-ID: <OFC3A7BB4B.0F6D06D1-ONC1256AE7.003CF18E@aladdin.de>
From: cpg@aladdin.de
Date: Tue, 16 Oct 2001 13:08:25 +0200
X-MIMETrack: Serialize by Router on Venus/MUC/AKS(Release 5.0.4a |July 24, 2000) at 10/16/2001
 01:08:15 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/2001 03:39:06 AM MST Kirill Ratkin wrote:
>
>Hi. Do anybody know how to compile old kernel? (I need
>to compile 2.0.35 verion). I make config and make dep,
>when I do it I see error (during make dep). I found
>this problem as bus error in mkdep binary. I tried to
>take config scripts from 2.4.x kernel and it's ok but
>when I tried to compile I saw many error connected
>with asm statement and function type prefixes (like
>__constant_memcopy). I wouldn't like to install old
>gcc and old binutils. Are there ways to compile old
>kernel with new dev. tools?
>
>Regards,

I did the following change to mkdep.c of the 2.0.39 kernel
to compile it. It's some time ago, it was a problem
with mmap, iirc.

regards,
chris


--- mkdep.c.org Tue Oct  8 18:33:56 1996
+++ mkdep.c     Wed Feb  7 15:24:36 2001
@@ -229,6 +229,8 @@
        int pagesizem1 = getpagesize()-1;
        int fd = open(filename, O_RDONLY);
        struct stat st;
+//     printf("pagesize: %d\n",pagesizem1);
+//     exit (1);

        if (fd < 0) {
                perror("mkdep: open");
@@ -236,6 +238,7 @@
        }
        fstat(fd, &st);
        mapsize = st.st_size + 2*sizeof(unsigned long);
+#if 0
        mapsize = (mapsize+pagesizem1) & ~pagesizem1;
        map = mmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
        if (-1 == (long)map) {
@@ -243,9 +246,20 @@
                close(fd);
                return;
        }
-       close(fd);
        state_machine(map);
        munmap(map, mapsize);
+#else
+       map = malloc(mapsize);
+       if (! map) {
+               perror("mkdep: malloc");
+               close(fd);
+               return;
+       }
+       read (fd,map,st.st_size);
+       state_machine(map);
+       free(map);
+#endif
+       close(fd);
        if (hasdep)
                puts(command);
 }
@@ -254,6 +268,7 @@
 {
        int len;
        char * hpath;
+return(0);

        hpath = getenv("HPATH");
        if (!hpath)



