Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUBXOmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUBXOmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:42:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8833 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262258AbUBXOmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:42:20 -0500
Date: Tue, 24 Feb 2004 09:44:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jim Deas <jdeas0648@jadsystems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <200402240558.AA3585540272@jadsystems.com>
Message-ID: <Pine.LNX.4.53.0402240931310.8074@chaos>
References: <200402240558.AA3585540272@jadsystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Jim Deas wrote:

> Can someone point me in the right direction.
> I am getting a oops on a driver I am porting from 2.4 to 2.6.2 kernel.
> I have expanded the file_operations structures and have a driver that
> loads and inits the hardware but when I call the open function I
> get an oops. The best I can track it is
>

Fix your line-warp!

> EIP 0060:[c0188954]
> chrdev_open +0x104
>
> What is the best debug tool to put this oops information in clear
> sight? It appears to never get to my modules open routine so I am
> at a debugging crossroad. What is the option on a kernel compile
> to get the compile listing so I can see what is at 0x104 in this
> block of code?
>

Nothing is going to help with that EIP with a segment value of
0x60. It looks like some dumb coding error, using a pointer
that disappeared after the module init function. In other
words, it's probably something like:

int __init init_module()
{
    struct file_operations fops;
    mset(&fops, 0x00, sizeof(fops));
    fops.open = open;
    fops.release = close;
    fops.owner = THIS_MODULE;
    register_chrdev(DEV_MAJOR, dev, &fops);
}

So, everything in init_module is GONE. Your program calls open()
and the pointer in the kernel gets dereferenced to junk.

There are kernel debugging tools, however I have found that
the most useful tools are printk() and some discipline.

In the case of code above, don't just change the declaration
of the fops object to static. Instead, move it outside the
function, so it's obviously where it won't go away.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


