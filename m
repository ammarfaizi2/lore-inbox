Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbTB1Ox0>; Fri, 28 Feb 2003 09:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267934AbTB1Ox0>; Fri, 28 Feb 2003 09:53:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:19107 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267925AbTB1OxZ>; Fri, 28 Feb 2003 09:53:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Joe Perches <joe@perches.com>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface
Date: Fri, 28 Feb 2003 08:59:25 -0600
X-Mailer: KMail [version 1.2]
References: <OF06EBF3D5.39937A14-ON87256CDB.004FD627@us.ibm.com>
In-Reply-To: <OF06EBF3D5.39937A14-ON87256CDB.004FD627@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Message-Id: <03022808592509.05199@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 February 2003 08:32, you wrote:
> On Thu, 2003-02-27 at 14:05, Kevin Corry wrote:
> > Unfortunately, Linus seems to have committed that patch already. So here
> > is a patch to fix just that line.
> >
> > Thanks for catching that.
>
> Third time, strlen isn't necessary, it can be done at compile time.
>
> --- a/drivers/md/dm-ioctl.c     2003/02/27 16:29:58
> +++ b/drivers/md/dm-ioctl.c     2003/02/27 17:21:54
> @@ -174,7 +174,7 @@
>  static int register_with_devfs(struct hash_cell *hc)
>  {
>         struct gendisk *disk = dm_disk(hc->md);
> -       char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1);
> +       char *name = kmalloc(DM_NAME_LEN + sizeof(DM_DIR));
>         if (!name) {
>                 return -ENOMEM;
>         }

Sorry, I sent the last patch before I got your email.

Also, the "+1" is still necessary, even if we switch to sizeof. The sprintf 
call that follows copies DM_DIR, followed by a slash, followed by the name 
from the hash table into the allocated string. The "+1" is for the slash in 
the middle. The terminating NULL character is accounted for in DM_NAME_LEN.

Linus, here is (yet another!) patch against current BK.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/


--- linux-2.5.63-bk4a/drivers/md/dm-ioctl.c	Fri Feb 28 08:43:19 2003
+++ linux-2.5.63-bk4b/drivers/md/dm-ioctl.c	Fri Feb 28 08:44:08 2003
@@ -174,7 +174,7 @@
 static int register_with_devfs(struct hash_cell *hc)
 {
 	struct gendisk *disk = dm_disk(hc->md);
-	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1, GFP_KERNEL);
+	char *name = kmalloc(DM_NAME_LEN + sizeof(DM_DIR) + 1, GFP_KERNEL);
 	if (!name) {
 		return -ENOMEM;
 	}
