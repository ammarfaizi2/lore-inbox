Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129654AbQKMRKp>; Mon, 13 Nov 2000 12:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbQKMRKg>; Mon, 13 Nov 2000 12:10:36 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:30213 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129728AbQKMRK0>; Mon, 13 Nov 2000 12:10:26 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27093@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: RE: catch 22 - porting net driver from 2.2 to 2.4
Date: Mon, 13 Nov 2000 09:09:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Jeff Garzik" wrote:
> Theoretically, if you call unregister_netdev from rmmon, it should grab
> rtnl_lock and then complete the operation for you.  If that doesn't work
> for you, it sounds like you are not setting up, or cleaning up,
> something correctly.
> 
> Basically... it sounds like there are still bugs in your driver that
> need working out :)

I followed the value of dev->refcnt and there is something strange. before
the call to register_netdev it is set to 0 and after that it is increased to
1. but before the call to unregister_netdev it is somehow 2.

How can I tell who is modifying it and when ?

I tried using kdb to find out but it keeps hanging the machine. I wanted to
place a breakpoint that will pop if a certain memory address is accessed so
I did the following:

static void *p;	(global - at the top of my source file)
EXPORT_SYMBOL (p);

in my probe function:
	p = (void*) dev->refcnt;

> insmod my_module
> ksyms

this showed that p is at address 0xd081ee90

then from within kdb:
kdb> md 0xd081ee90
0xd081ee90 c470bedc ........ ........

kdb> bpha 0xc470bedc
Forced Global Breakpoint at...

kdb> go

system hung


Is there a way to place a breakpoint on a memory address access ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
