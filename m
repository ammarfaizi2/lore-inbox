Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263327AbVGOQJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbVGOQJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263326AbVGOQJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:09:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263327AbVGOQJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:09:33 -0400
Date: Fri, 15 Jul 2005 09:08:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, Jan Blunck <j.blunck@tu-harburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic_file_sendpage
In-Reply-To: <Pine.LNX.4.61.0507151511220.21786@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0507150904110.19183@g5.osdl.org>
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org>
 <20050715112255.GC2721@wohnheim.fh-wedel.de> <Pine.LNX.4.61.0507151511220.21786@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2005, Jan Engelhardt wrote:
>
> >> I don't know if we want to add this feature, really.  It's such a
> >> specialised thing.
> >
> >With union mount and cowlink, there are two users already.  cp(1)
> >could use it as well, even if the improvement is quite minimal.
> 
> FTP PUT could use this too - currently, only FTPGETs can use sendfile because 
> the target had to be a socket.
> (With FTP PUT, the src is a sock, dst is a filedescriptor.)

No, FTP PUT _cannot_ use it, exactly because sendfile() can't do anything 
but file sources (and not even all file sources - it can only do regular 
filesystems that use the page cache).

This is why I want to get rid of sendfile(). It's a fundamentally broken
interface. Really. In contrast, the pipe buffers _can_ be used for direct
socket->file interfaces.

Now, even pipe buffers obviously won't actually be really "zero-copy":
you'll end up needing one copy to align the result, since the incoming
network packets will obviously not be nice page-sized and page-aligned
things. But they won't need the "copy to user space" and "copy back from
user space into kernel space", so it will be a question of _minimal_ copy
(and avoiding unnecessary user space VM work).

			Linus
