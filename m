Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUAFEKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUAFEKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:10:33 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:59013 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265332AbUAFEKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:10:24 -0500
Message-ID: <3FFA350D.2070507@cyberone.com.au>
Date: Tue, 06 Jan 2004 15:09:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Libor Vanek <libor@conet.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
References: <3FFA30FA.1040602@conet.cz>
In-Reply-To: <3FFA30FA.1040602@conet.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Libor Vanek wrote:

> Hi,
> I'm trying to do some debugging with 2.6.0 + mm1 patch (I attach my 
> .config) and I found out this very strange thing when changing 
> fs/open.c (about the line 933):
>
> ORIGINAL CODE:
> ...
> asmlinkage long sys_open(const char __user * filename, int flags, int 
> mode)
> {
>        char * tmp;
>        int fd, error;
>
> #if BITS_PER_LONG != 32
>        flags |= O_LARGEFILE;
> #endif
>        tmp = getname(filename);
>        fd = PTR_ERR(tmp);
> ...
>
>
> MY TINY MODIFICATION:
> ...
> asmlinkage long sys_open(const char __user * filename, int flags, int 
> mode)
> {
>        char * tmp;
>        int fd, error;
>     char tmp_path[PATH_MAX],tmp2_path[PATH_MAX];
>
>
> #if BITS_PER_LONG != 32
>        flags |= O_LARGEFILE;
> #endif
>        tmp = getname(filename);
>     printk (KERN_INFO "sys_open: %s\n",tmp);
>        fd = PTR_ERR(tmp);
> ...
>
>
> This causes kernel to panic during boot. Messages are: (maybe some 
> typos - writing from paper)
> ...
> NET: Registering protocol family 17
> Unable to handle kernel paging request at virtual address fffffff2 


getname can return errors, actually. Looks like you're trying to print
the string at address -EFAULT.

When in doubt, always suspect your code.


