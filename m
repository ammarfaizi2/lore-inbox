Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbTCTU3m>; Thu, 20 Mar 2003 15:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261962AbTCTU3m>; Thu, 20 Mar 2003 15:29:42 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:10764 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261951AbTCTU3l>; Thu, 20 Mar 2003 15:29:41 -0500
Date: Thu, 20 Mar 2003 21:40:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] alternative dev patch
In-Reply-To: <Pine.LNX.4.44.0303200140050.12110-100000@serv>
Message-ID: <Pine.LNX.4.44.0303202131470.12110-100000@serv>
References: <Pine.LNX.4.44.0303200140050.12110-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Mar 2003, Roman Zippel wrote:

> This patch makes use of the character device hash and avoids introducing 
> unnecessary interfaces. I also moved the tty hack where it belongs.
> As an example I converted the misc device to demonstrate how drivers can 
> make use of it.
> Probably the most interesting part is how the open path stays short and 
> fast.

Here is a more detailed explanation of the patch and how it compares to 
Andries patch.

The open path for most devices is quite simple and tries to avoid a lookup 
by using the cached value in inode->i_cdev, so it simply has to get 
inode->i_cdev->fops. Only if that fails, open tries the slow path looking 
up the major device. Andries removes all the infrastructure for this with 
the first patch and replaces it with a lookup which can be quite expensive 
(e.g. when a major device has a lot of minor devices registered).

Further he introduces a new function register_chrdev_region(), which is 
only needed by the tty code and rather hides the problem than solves 
it. So the complexity should stay in the tty layer (and has to be fixed 
there), than forcing it into the generic layer.

The misc device example is interesting that misc_open() now is only called 
if no misc device is registered for that minor, so it only needs to 
request a module. The remaining functionality is basically to export 
information about misc devices to userspace and even part of that could be 
moved into the generic part (e.g. part of the driver model, but that 
depends a lot on what the tty layer needs).

Overall the generic code is 32bit dev_t safe (+ minor fixes/ 
optimizations). A flag still needs to be added, whether a driver can 
handle more than 256 minor numbers, but this patch helps drivers to manage 
them without huge tables (this latter part is also missing in Andries 
patch).

bye, Roman

