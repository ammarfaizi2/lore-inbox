Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTFMJ14 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265308AbTFMJ1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:27:55 -0400
Received: from hal-5.inet.it ([213.92.5.24]:46822 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S265303AbTFMJ1y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:27:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Paolo Ornati <javaman@katamail.com>
To: viro@www.linux.org.uk
Subject: Re: 2.5.70 freeze unloading module "snd"
Date: Fri, 13 Jun 2003 11:42:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <S264881AbTFLQS1/20030612161827Z+1679@vger.kernel.org>
In-Reply-To: <S264881AbTFLQS1/20030612161827Z+1679@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <S265303AbTFMJ1y/20030613092754Z+2224@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 June 2003 18:32, Paolo Ornati wrote:
> Hi,
> I'm trying ALSA on linux 2.5.70, it works fine but... when I try to unload
> module "snd" the kernel freeze without any message.
> Interrupts are enabled (I try this with the keyboard's leds :-), then I
> can't do anything but press the reset button.
>
> I'm using module-init-tools 0.9.12 and my config is:
> ...

Today I've tried the same thing (unload module "snd") on 2.5.69 without any problem...
so there is something wrong in patch-2.5.70.

Using some "printk" I found this:

sound/core/sound.c
static void __exit alsa_sound_exit(void)
{
	...
	if (unregister_chrdev(major, "alsa") != 0)		<-- kernel freeze!
		snd_printk(KERN_ERR "unable to unregister major device number %d\n", major);
	...
}

SO I think that the problem is in last changes to "fs/char_dev.c"...
Viro, according to the changelog it seems that these changes are yours...

<viro@www.linux.org.uk>
	[PATCH] cdev-cidr, part 1
	
	New object: struct cdev.  It contains a kobject, a pointer to
	file_operations and a pointer to owner module.  These guys have a search
	structure of the same sort as gendisks and chrdev_open() picks
	file_operations from them.
	
	Intended use: embed such animal in driver-owned structure (e.g.
	tty_driver) and register it as associated with given range of device
	numbers.  Generic code will do lookup for such object and use it for the
	rest.
	
	The behaviour of register_chrdev() is _not_ changed - it allocates
	struct cdev and registers it; any old driver will work as if nothing had
	changed.
	...

Viro, what do you think?

BYE,
Paolo
