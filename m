Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTEFL4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTEFL4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:56:54 -0400
Received: from pointblue.com.pl ([62.89.73.6]:21508 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262601AbTEFL4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:56:10 -0400
Subject: [PATCH]   include/linux/sunrpc/svc.h compilation error
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus <torvalds@transmeta.com>, blues@ds.pg.gda.pl
In-Reply-To: <Pine.LNX.4.51L.0305061205400.1232@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
	 <Pine.LNX.4.51L.0305061205400.1232@piorun.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2
Organization: K4 labs
Message-Id: <1052222558.3873.19.camel@nalesnik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 13:02:38 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 11:08, Pawe³ Go³aszewski wrote:
> That kernel fails for me when building...
> [cut]
> 
> gcc -Wp,-MD,fs/lockd/.clntproc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=clntproc -DKBUILD_MODNAME=lockd -c -o fs/lockd/.tmp_clntproc.o fs/lockd/clntproc.c
> In file included from fs/lockd/clntproc.c:17:
> include/linux/sunrpc/svc.h: In function `svc_take_page': 
> include/linux/sunrpc/svc.h:180: invalid lvalue in assignment
> make[3]: *** [fs/lockd/clntproc.o] Error 1
> make[2]: *** [fs/lockd] Error 2
> make[1]: *** [fs] Error 2
> make: *** [modules] Error 2

Looks like gcc fault, can You Pawel give as gcc version  ?

this patch as reported by Pawel helps:


--- ./include/linux/sunrpc/svc.h.buildfix       Mon May  6 12:45:11 2003
+++ ./include/linux/sunrpc/svc.h        Tue May  6 12:42:13 2003
@@ -176,8 +176,14 @@
 {
        if (rqstp->rq_arghi <= rqstp->rq_argused)
                return -ENOMEM;
+
+       rqstp->rq_arghi--;
+
        rqstp->rq_respages[rqstp->rq_resused++] =
                rqstp->rq_argpages[--rqstp->rq_arghi];
+
+       rqstp->rq_resused++;
+
        return 0;
 }


but still, it looks strange - i am sure it is just an gcc issue

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

