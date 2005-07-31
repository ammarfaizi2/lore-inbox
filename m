Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVGaRsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVGaRsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVGaRsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:48:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7087 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261805AbVGaRsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:48:13 -0400
Date: Sun, 31 Jul 2005 10:47:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: 2.6.13-rc4-mm1
Message-Id: <20050731104702.7d16c8a1.akpm@osdl.org>
In-Reply-To: <42ECD3B2.1080409@domdv.de>
References: <20050731020552.72623ad4.akpm@osdl.org>
	<42ECD3B2.1080409@domdv.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:
>
> Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
> 
>  Andrew,
>  the good news is I can access pcmcia devices with rc4-mm1 which I
>  couldn't with at least rc3-mm1 on my x86_64 laptop. There is at least
>  one more problem with yenta_socket. Please see the attached dmesg output
>  and look for:
> 
>  Badness in __release_resource at kernel/resource.c:184
> 
>  This happens when accessing pcmcia from an initrd to read keys from a
>  pcmcia flash disk and removing the pcmcia modules afterwards.

hm, OK.  That's brought to us by the below -mm-only debugging patch.  Maybe
we should add more stuff to it to idenfify the child resources?


From: willy@parisc-linux.org (Matthew Wilcox)

What does it mean to release a resource with children?  Should the children
become children of the released resource's parent?  Should they be released
too?  Should we fail the release?

I bet we have no callers who expect this right now, but with
insert_resource() we may get some.  At the point where someone hits this
BUG we can figure out what semantics we want.

Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/resource.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN kernel/resource.c~releasing-resources-with-children kernel/resource.c
--- 25/kernel/resource.c~releasing-resources-with-children	2005-04-02 00:21:52.000000000 -0800
+++ 25-akpm/kernel/resource.c	2005-04-02 00:22:22.000000000 -0800
@@ -181,6 +181,8 @@ static int __release_resource(struct res
 {
 	struct resource *tmp, **p;
 
+	WARN_ON(old->child);
+
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;
_

