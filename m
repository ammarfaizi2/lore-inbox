Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130878AbQKNJGb>; Tue, 14 Nov 2000 04:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130880AbQKNJGW>; Tue, 14 Nov 2000 04:06:22 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:25351 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130878AbQKNJGG>; Tue, 14 Nov 2000 04:06:06 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27095@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>
Cc: "'LNML'" <linux-net@vger.kernel.org>
Subject: Q: using kdb to trap memory modifications
Date: Tue, 14 Nov 2000 00:35:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I'm trying to see when and how a certain variable is being modified and I
wonder how to get kdb to do that for me.

when I do 'insmod my_module' with my network driver, I noticed that
dev->refcnt is 0 at first and gets increased to 1 after calling
register_netdev. When I want to do 'rmmod my_module' somehow dev->refcnt is
at 2 before the call to unregister_netdev and so the kernel (2.4.0-test9)
won't let the module to unload. Since I don't increase it explicitly, I want
to know who does it for me and when to see if I'm doing anything wrong.

So, I modified my module to contain in the global section:
	static void* ptr;
	EXPORT_SYMBOL(ptr);

and in my module_init function I added:

	ptr = (void*) &dev->refcnt;

after running 'insmod my_module' I used ksyms and found that ptr is at
address 0xd081eeb4.

after entering kdb, I did:

	kdb> md 0xd081eeb4

	0xd081eeb4  c470bedc  00000000  00000000  00000000
	0xd081eec4  00000000  00000000  00000000  00000000
	.
	.

	kdb> bph 0xc470bedc
	Forced Breakpoint at.... #0 ...

	kdb> be 0
	kdb> go

When I try to return to normal shell, the system is totally hung and won't
even receive inputs from the remote serial terminal.
I tried bp, bpa and bpha, but the result is always the same.


	Thanks,
	Shmulik Hen
      	Software Engineer
	Linux Advanced Networking Services
	Network Communications Group, Israel (NCGj)
	Intel Corporation Ltd.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
