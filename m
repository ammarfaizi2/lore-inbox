Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTB0OOD>; Thu, 27 Feb 2003 09:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTB0OOD>; Thu, 27 Feb 2003 09:14:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17351 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265039AbTB0OOB>; Thu, 27 Feb 2003 09:14:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface
Date: Thu, 27 Feb 2003 08:20:59 -0600
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       vonbrand@eeyore.valparaiso.cl
References: <200302262104.h1QL4aiC001941@eeyore.valparaiso.cl>
In-Reply-To: <200302262104.h1QL4aiC001941@eeyore.valparaiso.cl>
MIME-Version: 1.0
Message-Id: <03022708205903.05199@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 February 2003 15:04, Horst von Brand wrote:
> Joe Thornber <joe@fib011235813.fsnet.co.uk> said:
> > Use the correct size for "name" in register_with_devfs().
> >
> > During Al Viro's devfs cleanup a few versions ago, this function was
> > rewritten, and the "name" string added. The 32-byte size is not large
> > enough to prevent a possible buffer overflow in the sprintf() call,
> > since the hash cell can have a name up to 128 characters.
> >
> > [Kevin Corry]
> >
> > --- diff/drivers/md/dm-ioctl.c	2003-02-26 16:09:42.000000000 +0000
> > +++ source/drivers/md/dm-ioctl.c	2003-02-26 16:09:52.000000000 +0000
> > @@ -173,7 +173,7 @@
> >   */
> >  static int register_with_devfs(struct hash_cell *hc)
> >  {
> > -	char name[32];
> > +	char name[DM_NAME_LEN + strlen(DM_DIR) + 1];
>
> This either makes a large name array or generates a possibly huge array at
> runtime (bad if your stack is < 8KiB).

Would this be better?

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/


--- linux-2.5.60a/drivers/md/dm-ioctl.c	2003/02/13 16:43:26
+++ linux-2.5.60b/drivers/md/dm-ioctl.c	2003/02/27 14:17:00
@@ -173,8 +173,11 @@
  */
 static int register_with_devfs(struct hash_cell *hc)
 {
-	char name[DM_NAME_LEN + strlen(DM_DIR) + 1];
 	struct gendisk *disk = dm_disk(hc->md);
+	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1);
+	if (!name) {
+		return -ENOMEM;
+	}
 
 	sprintf(name, DM_DIR "/%s", hc->name);
 	devfs_register(NULL, name, DEVFS_FL_CURRENT_OWNER,

