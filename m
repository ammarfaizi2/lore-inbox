Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271691AbTGRD7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 23:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271692AbTGRD7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 23:59:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:54738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271691AbTGRD7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 23:59:54 -0400
Date: Thu, 17 Jul 2003 21:15:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Ruvolo <chris+lkml@ruvolo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1 garbage in /proc/ioports and oops
Message-Id: <20030717211533.77c0f943.akpm@osdl.org>
In-Reply-To: <20030718011101.GD15716@ruvolo.net>
References: <20030718011101.GD15716@ruvolo.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ruvolo <chris+lkml@ruvolo.net> wrote:
>
> Hi, I am seeing some garbage data in /proc/ioports.  Currently, I can cat
>  the file without an oops, but on a previous boot, the following oops came
>  up when catting the file.
> 
>  Exact output from /proc/ioports is attached (some 8-bit garbage), as well as
>  lsmod output.  Let me know if further data is needed.
> 
>  I suspect that this is a problem in one of the drivers I am using, but
>  how do I track down which one it is (since the name is not there)?

You could load all those modules one at a time, doing a `cat /proc/ioports'
after each one.  One sneaky way of doing that would be to make your
modprobe executable be:


	#!/bin/sh
	echo Loading $* > /dev/console
	modprobe.orig $*
	cat /proc/ioports > /dev/null
	echo that worked

and then just boot in the normal manner.



Have you ever unloaded a module?  The usual source of this crash is some
driver forgot to unregister an IO region during module unload.  So a read
of /proc/ioports crashes _after_ the module is rmmodded.


