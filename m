Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWEJRqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWEJRqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWEJRqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:46:30 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22403 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932318AbWEJRq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:46:29 -0400
Date: Wed, 10 May 2006 13:45:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Adrian Bunk <bunk@stusta.de>
cc: Daniel Walker <dwalker@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605101327380.20305@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
 <1147257266.17886.3.camel@localhost.localdomain>
 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <1147273787.17886.46.camel@localhost.localdomain>
 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de>
 <Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh fsck! gcc is hosed. I just tried out this BS module:

---
#include <linux/module.h>

int g = 0;

void func_int(int *y)
{
	*y = 0;
}

int warn_here(void)
{
	int x;

	printk("x=%d\n",x);

	return 0;
}

int but_not_here(void)
{
	int y;

	printk("y=%d\n",y);
	if (g) {
		func_int(&y);
	}
	return 0;
}

static int __init blah_init(void)
{
	warn_here();
	but_not_here();
        return 0;
}

static void __exit blah_exit(void)
{
	printk(KERN_INFO "Bye bye!\n");
}

module_init(blah_init);
module_exit(blah_exit);

MODULE_AUTHOR("My name here");
MODULE_DESCRIPTION("blah!");
MODULE_LICENSE("GPL");
---

And this is what I got!

  CC [M]  /home/rostedt/c/modules/warning.o
/home/rostedt/c/modules/warning.c: In function 'warn_here':
/home/rostedt/c/modules/warning.c:14: warning: 'x' is used uninitialized in this function
  Building modules, stage 2.


Why the fsck isn't the func but_not_here not getting a warning for the
first use of printk??  If I remove the if statement it gives me the
warning.  Hell, that if statement isn't even entered (g = 0).

If you remove the warn_here function altogether, this module gets no
warnings!!!

OK, this really bothers me :(

btw, if you are wondering. I did load the module, and here's the output
from dmesg:

x=-124784640
y=-124784640

And I even tried it with removing warn me, compiled with no warnings and
then got this:

y=134514958

Huh!

-- Steve

