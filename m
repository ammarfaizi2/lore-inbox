Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbUCaBO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUCaBO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:14:27 -0500
Received: from ozlabs.org ([203.10.76.45]:6887 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263132AbUCaBOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:14:25 -0500
Subject: Re: Bug#240886: module-init-tools: modprobe pass wrong ide options
	to insmod
From: Rusty Russell <rusty@rustcorp.com.au>
To: 240886@bugs.debian.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040330162503.GA7730@wonderland.linux.it>
References: <20040330162503.GA7730@wonderland.linux.it>
Content-Type: text/plain
Message-Id: <1080695659.11048.152.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 31 Mar 2004 11:14:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 02:25, Marco d'Itri wrote:
...
> modprobe -v -k ide-mod options="ide=nodma hdc=cdrom"
> 
> resulting in
> 
>  insmod the_module "options=ide=nodma hdc=cdrom"
> 
> will not work. 

There are two problems here: one is in modprobe, but the real problem is
that putting:

	options ide-mod options="ide=nodma hdc=cdrom"

will be handed to ide-mod as:

	"ide=nodma hdc=cdrom"

ie. with the quotes intact.  It doesn't handle that, and probably
shouldn't.

Name: Fix Quote Handling in Parameters
Status: Tested on 2.6.5-rc3

Agustin Martin <agmartin@debian.org> pointed out that this doesn't
work:

	options ide-mod options="ide=nodma hdc=cdrom"

The quotes are understood by kernel/params.c (ie. it skips over spaces
inside them), but are not stripped before handing to the underlying
function.  They should be.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7471-linux-2.6.5-rc3/kernel/params.c .7471-linux-2.6.5-rc3.updated/kernel/params.c
--- .7471-linux-2.6.5-rc3/kernel/params.c	2003-10-09 18:03:02.000000000 +1000
+++ .7471-linux-2.6.5-rc3.updated/kernel/params.c	2004-03-31 11:02:44.000000000 +1000
@@ -96,6 +96,13 @@ static char *next_arg(char *args, char *
 	else {
 		args[equals] = '\0';
 		*val = args + equals + 1;
+
+		/* Don't include quotes in value. */
+		if (**val == '"') {
+			(*val)++;
+			if (args[i-1] == '"')
+				args[i-1] = '\0';
+		}
 	}
 
 	if (args[i]) {

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

