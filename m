Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUGNESm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUGNESm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 00:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUGNESm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 00:18:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:52914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265500AbUGNESk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 00:18:40 -0400
Date: Tue, 13 Jul 2004 21:17:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-Id: <20040713211721.05781fb7.akpm@osdl.org>
In-Reply-To: <1089776640.15336.2557.camel@abyss.home>
References: <1089771823.15336.2461.camel@abyss.home>
	<20040714031701.GT974@dualathlon.random>
	<1089776640.15336.2557.camel@abyss.home>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev <peter@mysql.com> wrote:
>
> The reason for me to disable swap both in 2.4 and 2.6 is - it really
>  hurts performance. In some cases performance can be 2-3 times slower
>  with swap file enabled.   Using O_DIRECT and mlock() for buffers helps 
>  but not completely.

It's strange that swap should harm performance in this manner.  Is that
also the case on 2.6?

wrt this OOM problem: it's possible that your ZONE_NORMAL got filled with
anonymous memory which the VM is unable to do anything about.  If you're
going to run a highmem box swapless then you should tune the kernel so that
it doesn't use so much ZONE_NORMAL memory for anonymous pages.

Try

	echo 500 > /proc/sys/vm/lower_zone_protection

then do:

	echo m > /proc/sysrq-trigger; dmesg -c

You'll get output like this:


Normal free:407192kB min:936kB low:1872kB high:2808kB active:1572kB inactive:410348kB present:901120kB
protections[]: 0 468 128724

                     ^^^^^^

This number here means that the VM will make 128724 pages (500MB) of the
normal zone ineligible for anonymous memory and pagecache allocations. 
That is probably an appropriate setting for your application.  If you set
lower_zone_protection too low you'll still get OOMs.  If you set it too
high the file caching efficiency may suffer a little.
