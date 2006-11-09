Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966043AbWKIQiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966043AbWKIQiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966044AbWKIQiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:38:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:45293 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966043AbWKIQiA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:38:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
Date: Thu, 9 Nov 2006 17:37:48 +0100
User-Agent: KMail/1.9.5
Cc: kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com>
In-Reply-To: <455340B8.2080206@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611091737.48801.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 15:52, Avi Kivity wrote:
> Wouldn't that make inline assembly useless?  Suppose the contents is 
> itself a pointer.  What about the pointed-to contents?
> 
> e.g.
> 
>     int x = 3;
>     int *y = &x;
>     int z;
> 
>     asm ("mov %1, %%rax; movl (%%rax), %0" : "=r"(z) : "g"(y) : "rax");
>     assert(z == 3);

Same here, you need to tell gcc what is really accessed, like 

asm ("mov %1, %%rax; movl (%%rax), %0" : "=r"(z) : "g"(y), "m"(*y) : "rax");

I know that the s390 kernel developers have hit that problem
frequently with inline assemblies. It may be that it's harder
to hit on x86, because there are fewer registers available and
data therefore tends to spill to the stack.

> > Or gcc
> > might move the assignment of phys_addr to after the inline assembly.
> >   
> "asm volatile" prevents that (and I'm not 100% sure it's necessary).

Yes, I think that's right. The 'volatile' should not be necessary though,
if you get the inputs right.

	Arnd <><
