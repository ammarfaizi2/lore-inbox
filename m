Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTEHPuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTEHPuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:50:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36747 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261707AbTEHPup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:50:45 -0400
Date: Thu, 08 May 2003 07:54:38 -0700 (PDT)
Message-Id: <20030508.075438.52189319.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: haveblue@us.ibm.com, akpm@digeo.com, rmk@arm.linux.org.uk,
       rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1052405730.10038.51.camel@dhcp22.swansea.linux.org.uk>
References: <3EB98878.5060607@us.ibm.com>
	<1052395526.23259.0.camel@rth.ninka.net>
	<1052405730.10038.51.camel@dhcp22.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 08 May 2003 15:55:31 +0100

   Unfortunately for the ISA driver code we *have* to rely on link
   order or rip out the __init stuff and use Space.c type hacks.
   
I do no argue that needing an invocation order is bogus.
I merely disagree with the way we're trying to achieve it.

You don't need Space.c magic, the linker in binutils has mechanisms by
which this can be accomplished and we already use this in 2.5.x

Have a peek at __define_initcall($NUM,fn), imagine it with one more
argument $PRIO.  It might look like this:

#define __define_initcall(level,prio,fn) \
        static initcall_t __initcall_##fn __attribute__
        ((unused,__section__ ("\.initcall" level "." prio ".init"))) = fn

Use the 'prio' number to define the ordering.  The default for
modules that don't care about relative ordering within a class
use a value like "9999" or something like that.

The only magic is what to do with the vmlinux.lds scripts to
handle this correctly.  Are regular expressions allowed in the
section names?
