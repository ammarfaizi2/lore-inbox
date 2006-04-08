Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWDHKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWDHKOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWDHKOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 06:14:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964840AbWDHKOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 06:14:44 -0400
Date: Sat, 8 Apr 2006 03:12:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: shemminger@osdl.org, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, fpavlic@de.ibm.com,
       davem@sunset.davemloft.net
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Message-Id: <20060408031235.5d1989df.akpm@osdl.org>
In-Reply-To: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com>
References: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com>
	<20060407074627.2f525b2e@localhost.localdomain>
	<20060408100213.GA9412@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> Ok, so the problem seems to be that inet_init gets called after qeth_init.
>  Looking at the top level Makefile this seems to be true for all network
>  drivers in drivers/net/ and drivers/s390/net/ since we have
> 
>  vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
> 
>  The patch below works for me... I guess there must be a better way to make
>  sure that any networking driver's initcall is made before inet_init?
> 
>  Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>  ---
> 
>   Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
>  diff --git a/Makefile b/Makefile
>  index b401942..c5cea07 100644
>  --- a/Makefile
>  +++ b/Makefile
>  @@ -567,7 +567,7 @@ #
>   # System.map is generated to document addresses of all kernel symbols
>   
>   vmlinux-init := $(head-y) $(init-y)
>  -vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
>  +vmlinux-main := $(core-y) $(libs-y) $(net-y) $(drivers-y)

<wonders what this will break>

I have a bad feeling that one day we're going to come unstuck with this
practice.  Is there anything which dictates that the linker has to lay
sections out in .o-file-order?

Perhaps net initcalls should be using something higher priority than
device_initcall().
