Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUFIJsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUFIJsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 05:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFIJsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 05:48:08 -0400
Received: from zero.aec.at ([193.170.194.10]:33028 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265770AbUFIJsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 05:48:01 -0400
To: Steve Hemond <steve.hemond@sympatico.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Inserting a module (2.6 kernel)
References: <24Zio-6xX-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 09 Jun 2004 11:47:58 +0200
In-Reply-To: <24Zio-6xX-3@gated-at.bofh.it> (Steve Hemond's message of "Wed,
 09 Jun 2004 02:40:08 +0200")
Message-ID: <m3oentkqpd.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Hemond <steve.hemond@sympatico.ca> writes:

> Hi people,
>
> I am new to kernel module writing and I base myself on the Linux Device Drivers book from O'reilly. I have written this simple module :
>
> #include <linux/module.h>
>
> int init_module(void)
> {
>   printk("<1>Module inserted\n");
>   return 0;
> }
>
> void cleanup_module(void)
> {
>   printk("<1>Module removed\n");
> }
>

For some reason that's probably far too complicated for my little
brain it's getting more and more complicated to write custom
modules for 2.6.

Compile all with:

gcc -O2 -c hello.c -I /path/to/kernel/include

or 

gcc -O2 -mcmodel=kernel -mno-red-zone -c hello.c -I /path/to/kernel/include
if you're using x86-64.

In 2.4 what worked was:

#define MODULE 1
#define __KERNEL__ 1 
#include <linux/module.h>

int init_module(void)
{
        printk("Hello world\n");
        return 0;
}

Then in 2.6 it needed

#define MODULE 1
#define __KERNEL__ 1 
#define KBUILD_MODNAME "hello"
#include <linux/module.h>

int init_module(void)
{
        printk("Hello world\n");
        return 0;
}

Now since 2.6.5 or so it needs: 

/* MODULE is not needed anymore */
#define __KERNEL__1 
#include <linux/module.h>

int init_module(void)
{
        printk("Hello world\n");
        return 0;
}

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
        .name = "hello",
        .init = init_module,
};

I'm sure there will be more surprises in the future. Keep tuned.

-Andi



