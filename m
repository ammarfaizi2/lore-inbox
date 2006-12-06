Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760595AbWLFNUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760595AbWLFNUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760592AbWLFNUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:20:46 -0500
Received: from belize.chezphil.org ([80.68.91.122]:3491 "EHLO
	belize.chezphil.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603AbWLFNUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:20:46 -0500
To: <linux-kernel@vger.kernel.org>
Date: Wed, 06 Dec 2006 13:20:41 +0000
Subject: Subtleties of __attribute__((packed))
Message-ID: <1165411241721@dmwebmail.belize.chezphil.org>
X-Mailer: Decimail Webmail 3alpha14
MIME-Version: 1.0
Content-Type: text/plain; format="flowed"
From: "Phil Endecott" <phil_arcwk_endecott@chezphil.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I used to think that this:

struct foo {
   int a  __attribute__((packed));
   char b __attribute__((packed));
   ... more fields, all packed ...
};

was exactly the same as this:

struct foo {
   int a;
   char b;
   ... more fields ...
} __attribute__((packed));

but it is not, in a subtle way.

Maybe you experts all know this already, but it was new to me so I 
thought I ought to share it, since there have been a few patches 
recently changing the first form to the second form to avoid gcc 
warnings.  (See for example 
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=1a7a3f50e40b0a956f44511e42b124a6be98b30b;hp=74f6889f834f1679f09ccd8bbc772fdafd6aade2;hb=e2bf2e26c0915d54208315fc8c9864f1d987217a;f=arch/powerpc/platforms/iseries/main_store.h 
or http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6a878184c202395ea17212f111ab9ec4b5f6d6ee)

The difference comes when you declare a variable of this struct type 
like this:

   char c;
   struct foo f;

If you use the first form in the declaration of struct foo, a gap will 
be left between c and f so that the start of the struct is aligned.  
But if you use the second form, f will be packed immediately after c, unaligned.

On x86 of course none of this matters for correct behaviour since the 
hardware supports unaligned accesses.  Assuming that your hardware 
doesn't do unaligned accesses then some code will still work.  In 
particular, if you access f like this:

   f.a++;

or probably

   func1(f.a);  // func1 takes an int

then gcc will generate the necessary byte-shuffling code.  However, if 
you write this:

   func2(&f.a);  // func2 takes an int*

then an unaligned pointer is passed to func2.  When func2 dereferences 
the pointer the hardware fails in some way.

GCC does not seem to generate an error or warning when you take the 
address of an unaligned field like this.

I believe that the solution is to write something like this:

struct foo {
   int a;
   char b;
   ... more fields ...
} __attribute__((packed)) __attribute__((aligned(4)));

Now the fields within the struct will be packed, but variables of the 
struct type will be aligned to a 4-byte boundary.

It could be that the kernel code is all safe.  I discovered this issue 
in user code that used structs from the kernel headers.  But I 
encourage anyone who changed their use of __attribute__((packed)) to 
avoid a gcc warning to review what they have done, especially if they 
have tested it only on x86.

Thanks for your attention, and please forgive me if you all know all 
this already!

Regards,

Phil.


(You are welcome to cc: me with any replies.)





