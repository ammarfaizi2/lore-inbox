Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSGYNci>; Thu, 25 Jul 2002 09:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSGYNbQ>; Thu, 25 Jul 2002 09:31:16 -0400
Received: from pump3.york.ac.uk ([144.32.128.131]:965 "EHLO pump3.york.ac.uk")
	by vger.kernel.org with ESMTP id <S314403AbSGYNaJ>;
	Thu, 25 Jul 2002 09:30:09 -0400
Date: Thu, 25 Jul 2002 14:42:13 +0100 (BST)
From: Ewan Mac Mahon <ecm103@york.ac.uk>
X-X-Sender: ewan@kitt.york.ac.uk
To: James Simmons <jsimmons@transvirtual.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] Second set of console changes.
In-Reply-To: <Pine.LNX.4.44.0207242326520.29650-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.44.0207251402530.31229-100000@kitt.york.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, James Simmons wrote:
>  
>    To the people with the devfs issues. Please send me a log of what
> exactly happened and a detail ksymoop if you can. I just tried it on my
> system with devfs enabled and it works for me. 

It doesn't oops, it just doesn't register the devices so you can't open 
gettys on them. Other than that the kernel boots fine and you can log in 
over the network. Doing that you can see a couple of big difference in 
/dev:

2.5.28 without fix:

$ ls -l /dev/vc
total 0
crw-------    1 root     root       4,   0 Jan  1  1970 0

$ ls -l /dev/tty*
crw-rw-rw-    1 root     root       5,   0 Jan  1  1970 /dev/tty
lr-xr-xr-x    1 root     root            4 Jul 25 14:17 /dev/tty0 -> vc/0


Whereas with the fix to add a call to con_init_devfs() near the end of 
vty_init() it all works and you can see the following:

ls -l /dev/vc
total 0
crw-------    1 root     root       4,   0 Jan  1  1970 0
crw-------    1 root     root       4,   1 Jul 25 14:09 1
crw-------    1 root     root       4,  10 Jan  1  1970 10
crw-------    1 root     root       4,  11 Jan  1  1970 11
etc...
crw-------    1 root     root       4,  63 Jan  1  1970 63

$ ls -l /dev/tty*
crw-rw-rw-    1 root     root       5,   0 Jan  1  1970 /dev/tty
lr-xr-xr-x    1 root     root            4 Jul 25 14:25 /dev/tty0 -> vc/0
lr-xr-xr-x    1 root     root            4 Jul 25 14:25 /dev/tty1 -> vc/1
lr-xr-xr-x    1 root     root            5 Jul 25 14:25 /dev/tty10 -> vc/10
lr-xr-xr-x    1 root     root            5 Jul 25 14:25 /dev/tty11 -> vc/11
etc...
lr-xr-xr-x    1 root     root            5 Jul 25 14:25 /dev/tty63 -> vc/63


If the system can still see static device nodes for the devices it can, of 
course, still ue them even with devfs built into the kernel.

Ewan

