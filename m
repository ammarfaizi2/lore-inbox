Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265105AbUD3IDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUD3IDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUD3IDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:03:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:19144 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265105AbUD3IDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:03:02 -0400
Date: Fri, 30 Apr 2004 01:02:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: adi@hexapodia.org, pj@sgi.com, vonbrand@inf.utfsm.cl,
       nickpiggin@yahoo.com.au, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040430010213.65e6048e.akpm@osdl.org>
In-Reply-To: <409205C1.7000700@pobox.com>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<20040429141947.1ff81104.akpm@osdl.org>
	<20040429143403.35a7a550.pj@sgi.com>
	<20040429145725.267ea7b8.akpm@osdl.org>
	<20040430000408.GA29096@hexapodia.org>
	<20040429173223.3ea4d0c5.akpm@osdl.org>
	<409205C1.7000700@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > fadvise(POSIX_FADV_DONTNEED) is ideal for this.  Run it once per megabyte
>  > or so.
> 
> 
>  Sweet.  I'm so happy you added posix_fadvise (way back when), and even 
>  happier to hear this.

There are a number of other goodies we could add to it, as linux
extensions.

>  Does our fadvise support len==0 ("I mean the whole file")?  That's 
>  defined in POSIX, and would allow a compliant app to simply 
>  POSIX_FADV_DONTNEED once at the beginning.

Well I'll be darned.

--- 25/mm/fadvise.c~fadvise-len-fix	2004-04-30 00:58:00.437598504 -0700
+++ 25-akpm/mm/fadvise.c	2004-04-30 00:59:03.237051536 -0700
@@ -38,6 +38,9 @@ asmlinkage long sys_fadvise64_64(int fd,
 		goto out;
 	}
 
+	if (len == 0)		/* 0 == "all data following offset" */
+		len = -1;
+
 	bdi = mapping->backing_dev_info;
 
 	switch (advice) {

_

