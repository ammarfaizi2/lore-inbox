Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTHaW7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbTHaW7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:59:42 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:965 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263033AbTHaW7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:59:39 -0400
Subject: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Zach, Yoav" <yoav.zach@intel.com>
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
References: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062370720.12058.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 23:58:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 22:41, Zach, Yoav wrote:
> binary's path. Old behavior of binfmt_misc is kept for interpreters
> which do not specify this special flag. The patch is against
> linux-2.6.0-test4. A similar one was posted twice on the list, on Aug.
> 14 and 21, without significant response.

Aside from the general unshare fixes here is the other small problem you
need to look at 

#1 You can't assume /dev/fd/0 so why not just pass the filehandle number
as argv1 instead like the a.out loader did years ago

#2 Use snprintf not sprintf (Im sure sprintf is safe here but its easier
to audit code if you use snprintf)

#3 The instant you pass control to the user space loader I can steal the
handle via /proc

#4 The instant you pass control to the user space loader I can take it
over via ptrace

#5 After you pass control I can core dump the app and recover the data
using a signal

3, 4 and 5 require you make the userspace loader undumpable in the case 
where the fd being passed on is executable only. If you do this then it
certainly fixes 4 (permission denied) and 5 (no dump) and I think it
fixes #3

Alan

