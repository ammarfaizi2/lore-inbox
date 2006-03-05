Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751727AbWCEGRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWCEGRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 01:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWCEGRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 01:17:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751727AbWCEGRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 01:17:25 -0500
Date: Sat, 4 Mar 2006 22:15:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adjust /dev/{kmem,mem,port} write handlers
Message-Id: <20060304221550.6892c7ba.akpm@osdl.org>
In-Reply-To: <44081B03.76F0.0078.0@novell.com>
References: <44081B03.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> The /dev/mem and /dev/kmem write handlers weren't fully POSIX compliant in
> that they wouldn't always force the file pointer to be updated when returning
> success status.
> The /dev/port write handler was inconsistent with the /dev/mem and /dev/kmem
> handlers in that when encountering a -EFAULT condition after already having
> written a number of items it would return -EFAULT rather than the number of
> bytes written.
> 
> ...
>
> @@ -514,11 +510,10 @@ static ssize_t write_kmem(struct file * 
>  			if (len) {
>  				written = copy_from_user(kbuf, buf, len);
>  				if (written) {
> -					ssize_t ret;
> -
> +					if (wrote + virtr)
> +						break;
>  					free_page((unsigned long)kbuf);
> -					ret = wrote + virtr + (len - written);
> -					return ret ? ret : -EFAULT;
> +					return -EFAULT;
>  				}
>  			}
>  			len = vwrite(kbuf, (char *)p, len);


I think write_kmem() still isn't quie right - it needs to update `p' (and
hence *ppos) to account for a partial copy_from_user().  (Please double-check)


--- devel/drivers/char/mem.c~adjust-dev-kmemmemport-write-handlers-fix	2006-03-04 22:10:55.000000000 -0800
+++ devel-akpm/drivers/char/mem.c	2006-03-04 22:15:19.000000000 -0800
@@ -504,8 +504,11 @@ static ssize_t write_kmem(struct file * 
 			if (len) {
 				written = copy_from_user(kbuf, buf, len);
 				if (written) {
-					if (wrote + virtr)
+					if (wrote + virtr) {
+						p += len - written;
+						virtr += len - written;
 						break;
+					}
 					free_page((unsigned long)kbuf);
 					return -EFAULT;
 				}
_

