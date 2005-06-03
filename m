Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFCJqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFCJqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 05:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVFCJqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 05:46:04 -0400
Received: from witte.sonytel.be ([80.88.33.193]:27804 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261195AbVFCJpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 05:45:53 -0400
Date: Fri, 3 Jun 2005 11:45:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: XIAO Gang <xiao@unice.fr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion on "int len" sanity
In-Reply-To: <20050602084840.GA32519@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be>
References: <429EB537.4060305@unice.fr> <20050602084840.GA32519@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584334533-903255571-1117791951=:16362"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584334533-903255571-1117791951=:16362
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Jun 2005, [iso-8859-1] Jörn Engel wrote:
> On Thu, 2 June 2005 09:28:55 +0200, XIAO Gang wrote:
> > 3. The similar situation occurs in fs/namei.c, vfs_readlink(). Here it does 
> > not matter if len
> > is declared to be unsigned, but for size_t, we have to take care about the 
> > size of size_t.
> 
> You could possibly change the code to:
> 
> int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
> {
> 	union {
> 		unsigned len;
                ^^^^^^^^
Plain unsigned is deprecated.

> 		int ret;
> 	} u;

Ugh...

> 
> 	u.ret = PTR_ERR(link);
> 	if (IS_ERR(link))
> 		goto out;
> 
> 	u.len = strlen(link);
> 	if (u.len > (unsigned) buflen)
> 		u.len = buflen;
> 	if (copy_to_user(buffer, link, u.len))
> 		u.ret = -EFAULT;
> out:
> 	return u.ret;
> }

buflen should be size_t.

Since the return value may be negative, it should be signed. But int is not an
option, since size_t is 64 bit on 64-bit machines, while int is still 32-bit.
So the return type should be ssize_t.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584334533-903255571-1117791951=:16362--
