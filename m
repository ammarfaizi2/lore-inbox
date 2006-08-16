Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWHPPnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWHPPnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWHPPnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:43:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932086AbWHPPnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:43:18 -0400
Date: Wed, 16 Aug 2006 08:43:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 6/7] vt: Update spawnpid to be a struct pid_t
Message-Id: <20060816084313.2cffca66.akpm@osdl.org>
In-Reply-To: <20060816193557.GA586@oleg>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193191-git-send-email-ebiederm@xmission.com>
	<20060816193557.GA586@oleg>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 23:35:57 +0400
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> On 08/15, Eric W. Biederman wrote:
> >
> > diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
> > index 28eff1a..d7e0187 100644
> > --- a/drivers/char/vt_ioctl.c
> > +++ b/drivers/char/vt_ioctl.c
> > @@ -645,12 +645,13 @@ #endif
> >  	 */
> >  	case KDSIGACCEPT:
> >  	{
> > -		extern int spawnpid, spawnsig;
> > +		struct pid *spawnpid;
> 		^^^^^^^^^^^^^^^^^^^^
> Should be "extern struct pid *spawnpid" ?
> 

It was updated thusly:  (the identifiers are a bit generic-sounding though)


From: Eric Biederman <ebiederm@xmission.com>

This moves the declaration of spawnpid and spawnsig into, a header
file, and makes spawnpid extern.  Without being extern the declaration
of swanpid was a nice little struct pid leak in the kernel and totally
broke the spawnpid functionality :(

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/vt_ioctl.c |    2 --
 include/linux/vt_kern.h |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/char/vt_ioctl.c~vt-update-spawnpid-to-be-a-struct-pid_t-tidy drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c~vt-update-spawnpid-to-be-a-struct-pid_t-tidy
+++ a/drivers/char/vt_ioctl.c
@@ -645,8 +645,6 @@ int vt_ioctl(struct tty_struct *tty, str
 	 */
 	case KDSIGACCEPT:
 	{
-		struct pid *spawnpid;
-		extern int spawnsig;
 		if (!perm || !capable(CAP_KILL))
 		  return -EPERM;
 		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
diff -puN include/linux/vt_kern.h~vt-update-spawnpid-to-be-a-struct-pid_t-tidy include/linux/vt_kern.h
--- a/include/linux/vt_kern.h~vt-update-spawnpid-to-be-a-struct-pid_t-tidy
+++ a/include/linux/vt_kern.h
@@ -84,4 +84,7 @@ void reset_vc(struct vc_data *vc);
 extern char con_buf[CON_BUF_SIZE];
 extern struct semaphore con_buf_sem;
 
+extern struct pid *spawnpid;
+extern int spawnsig;
+
 #endif /* _VT_KERN_H */
_

