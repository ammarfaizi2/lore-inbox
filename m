Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275518AbTHMUiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275519AbTHMUiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:38:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275518AbTHMUiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:38:13 -0400
Date: Wed, 13 Aug 2003 13:24:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new dev_t printable convention and lilo
Message-Id: <20030813132408.4c232ae5.akpm@osdl.org>
In-Reply-To: <E19mvTD-0007gz-00.arvidjaar-mail-ru@f16.mail.ru>
References: <20030809161221.1a94eb2c.akpm@osdl.org>
	<E19mvTD-0007gz-00.arvidjaar-mail-ru@f16.mail.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrey Borzenkov" <arvidjaar@mail.ru> wrote:
>
> It happens in name_to_dev_t:
> 
>  	if (strncmp(name, "/dev/", 5) != 0) {
>  		res = (dev_t) simple_strtoul(name, &p, 16);
>  		if (*p)
>  			goto fail;
>  		goto done;
>  	}
> 
> it means handle-old-dev_t is meaningless and has to be removed ; and if we want people to use new format, it needs to go into name_to_dev_t.

It's better to handle both isn't it?



 25-akpm/init/do_mounts.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff -puN init/do_mounts.c~handle-old-dev_t-format init/do_mounts.c
--- 25/init/do_mounts.c~handle-old-dev_t-format	Wed Aug 13 13:07:12 2003
+++ 25-akpm/init/do_mounts.c	Wed Aug 13 13:23:18 2003
@@ -71,13 +71,19 @@ static dev_t __init try_name(char *name,
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
 	buf[len - 1] = '\0';
-	/*
-	 * The format of dev is now %u:%u -- see print_dev_t()
-	 */
-	if (sscanf(buf, "%u:%u", &maj, &min) == 2)
+	if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
+		/*
+		 * Try the %u:%u format -- see print_dev_t()
+		 */
 		res = MKDEV(maj, min);
-	else
-		goto fail;
+	} else {
+		/*
+		 * Nope.  Try old-style "0321"
+		 */
+		res = (dev_t)simple_strtoul(buf, &s, 16);
+		if (*s)
+			goto fail;
+	}
 
 	/* if it's there and we are not looking for a partition - that's it */
 	if (!part)
@@ -135,9 +141,15 @@ dev_t name_to_dev_t(char *name)
 		goto out;
 
 	if (strncmp(name, "/dev/", 5) != 0) {
-		res = (dev_t) simple_strtoul(name, &p, 16);
-		if (*p)
-			goto fail;
+		unsigned maj, min;
+
+		if (sscanf(name, "%u:%u", &maj, &min) == 2) {
+			res = MKDEV(maj, min);
+		} else {
+			res = (dev_t)simple_strtoul(name, &p, 16);
+			if (*p)
+				goto fail;
+		}
 		goto done;
 	}
 	name += 5;

_

