Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVLPDbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVLPDbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVLPDbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:31:16 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:35234 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932090AbVLPDbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:31:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=mlfKdzur7DyuIQNTrZuqFeDjVbP3n1IM0UBst8BgDmj89rzpuhQlgOxWz3oqBcb6q1vZh1i1DR7BhRCcsiEstkzZkksKgELr+Zrhh9AEYjl6f3nUKPZFw7N7T+DPS1qYBVpD9CpvHNayneVFD3Ymko5/0Gmd8rzUY9TREIO44o8=
Message-ID: <81083a450512142032h5e9a934u31ed9e4806d0341a@mail.gmail.com>
Date: Thu, 15 Dec 2005 10:02:42 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] kernel/module.c Getting rid of the redundant spinlock in resolve_symbol()
Cc: Jesper Juhl <jesper.juhl@gmail.com>, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1188_24275014.1134621162496"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1188_24275014.1134621162496
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/15/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Wed, 2005-12-14 at 11:16 +0530, Ashutosh Naik wrote:
> > On 12/14/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > Was just wondering, in that case, if we really need the spinlock in
> > resolve_symbol() function, where there exists a spinlock around the
> > __find_symbol() function
>
> Yes, I think that's redundant as well.  We're not altering the module
> list itself, so either of the two locks is sufficient, and we have the
> semaphore.

Changelog -

This patch gets rid of the redundant spinlock in the function
resolve_symbol() as we are not altering the module list, and we
already hold the semaphore.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_1188_24275014.1134621162496
Content-Type: text/plain; name=mod-patch2.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mod-patch2.txt"

diff -Naurp linux-2.6.15-rc5-vanilla/kernel/module.c linux-2.6.15-rc5/kernel/module.c
--- linux-2.6.15-rc5-vanilla/kernel/module.c	2005-12-14 10:14:08.000000000 +0530
+++ linux-2.6.15-rc5/kernel/module.c	2005-12-15 09:41:59.000000000 +0530
@@ -958,7 +958,6 @@ static unsigned long resolve_symbol(Elf_
 	unsigned long ret;
 	const unsigned long *crc;
 
-	spin_lock_irq(&modlist_lock);
 	ret = __find_symbol(name, &owner, &crc, mod->license_gplok);
 	if (ret) {
 		/* use_module can fail due to OOM, or module unloading */
@@ -966,7 +965,6 @@ static unsigned long resolve_symbol(Elf_
 		    !use_module(mod, owner))
 			ret = 0;
 	}
-	spin_unlock_irq(&modlist_lock);
 	return ret;
 }
 

------=_Part_1188_24275014.1134621162496--
