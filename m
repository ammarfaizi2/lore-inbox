Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTDUJLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 05:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTDUJLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 05:11:18 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:17301 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263011AbTDUJLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 05:11:18 -0400
Message-ID: <3EA3B87B.60505@colorfullife.com>
Date: Mon, 21 Apr 2003 11:23:07 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junfeng Yang <yjf@stanford.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER]  Help Needed!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng wrote:

>It seems to us that create_dev can only be called at boot time (the
>"__init" attribute), so devfs_name must be an untainted kernel pointer.
>The warning on line 437 isn't a real error.
>
>However, this pointer is finally passed into strncpy_from_user through the
>call chain [ sys_symlink (devfs_name, name) --> getname (oldname) -->
>do_getname(filename, _) --> strncpy_from_user (_, filename, _)].  Is it
>okay to call *_from_user functions with the second arguements untainted?
>What will access_ok(VERIFY_READ, src, 1) return?
>  
>
The copy_{to,from}_user functions can access either user or kernel space.
after set_fs(KERNEL_DS), they access kernel space, after 
set_fs(USER_DS), they access user space.

The initial boot thread starts with set_fs(KERNEL_DS), and is switched 
back to set_fs(USER_DS) in search_binary_handler (fs/exec.c), called 
during exec of /sbin/init.

--
    Manfred

P.S.: On i386, you can access both kernel and user space after 
set_fs(KERNEL_DS), or if you use __get_user() and bypass access_ok(). 
Thus the __get_user() in arch/i386/kernel/traps.c, function 
show_registers is correct. This is the only instance I'm aware of where 
this is used, and noone else should be doing that. It fails on other 
archs, e.g. on sparc.

