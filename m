Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTFGQMW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTFGQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:12:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11780 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263258AbTFGQMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:12:20 -0400
Date: Sat, 7 Jun 2003 09:25:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: __user annotations
In-Reply-To: <20030607143219.U626@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.44.0306070917150.2840-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jun 2003, Ingo Oeser wrote:
> 
> That's a big pity. How do I workaround this? I would like to
> help resolving this issues, if you are interested.

The solution to these things is to _always_ have a separate type for the 
user thing than for the kernel thing. 

In practice, a lot of code has ended up doing that _anyway_, since the
kernel usually wants to have a few extra fields for its internal use. The
classic unix example of this, of course, is "struct stat" vs "struct
inode".

But if your structures are 100% the same, then you can just share them. 
There's nothing wrong with having

	struct ioctl_arg {
		int value;
		int another_value;
		..
	};

and then in your ioctl routines you have

    int my_ioctl_routine(struct ioctl_arg __user *ptr)
    {
	struct ioctl_arg arg;

	if (copy_from_user(&arg, ptr, sizeof(*ptr))
		return -EFAULT;
	...
    }

and that's fine.

You can even have user pointers _inside_ the structure: because "sparse" 
really understands C types at a very fundamental level (like a compiler 
would, not like some simpler source scanner), you can have

	struct ioctl_arg {
		int value;
		void __user *buf;
	};

and do

    int my_ioctl_routine(struct ioctl_arg __user *ptr)
    {
	struct ioctl_arg arg;
	char buffer[10];

	if (copy_from_user(&arg, ptr, sizeof(*ptr))
		return -EFAULT;

and sparse will be aware of the fact that "arg.buf" is a user pointer, and 
it will properly warn if you pass it to a function that expects a kernel 
pointer (or assign it to a normal non-user pointer thing).

		Linus

