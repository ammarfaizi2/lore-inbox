Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbTHJWpO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270753AbTHJWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:45:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:44219 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270740AbTHJWpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:45:07 -0400
Date: Sun, 10 Aug 2003 15:43:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: gaxt@rogers.com, henrik@fangorn.dk, romieu@fr.zoreil.com,
       linux-kernel@vger.kernel.org, felipe_alfaro@linuxmail.org,
       babydr@baby-dragons.com, len.brown@intel.com
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-Id: <20030810154343.351aa69d.akpm@osdl.org>
In-Reply-To: <20030810211745.GA5327@gamma.logic.tuwien.ac.at>
References: <20030809104024.GA12316@gamma.logic.tuwien.ac.at>
	<1060436885.467.0.camel@teapot.felipe-alfaro.com>
	<3F34D0EA.8040006@rogers.com>
	<20030809104024.GA12316@gamma.logic.tuwien.ac.at>
	<20030809115656.GC27013@www.13thfloor.at>
	<20030809090718.GA10360@gamma.logic.tuwien.ac.at>
	<20030809130641.A8174@electric-eye.fr.zoreil.com>
	<20030809090718.GA10360@gamma.logic.tuwien.ac.at>
	<01a201c35e65$0536ef60$ee52a450@theoden>
	<3F34D0EA.8040006@rogers.com>
	<20030810211745.GA5327@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> I tried as boot cmd line:
>  	s root=03:41 acpi=off
>  and still it didn't work. Same problem.

It is decimal.  You want 03:65.


Could you test this patch?  It should put things back to the way
they were before this mini-fisaco. root=0341 should work as well.


 init/do_mounts.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff -puN init/do_mounts.c~handle-old-dev_t-format init/do_mounts.c
--- 25/init/do_mounts.c~handle-old-dev_t-format	2003-08-09 16:15:24.000000000 -0700
+++ 25-akpm/init/do_mounts.c	2003-08-09 16:17:25.000000000 -0700
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

_

