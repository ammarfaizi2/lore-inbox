Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVIJTAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVIJTAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 15:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVIJTAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 15:00:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932213AbVIJTAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 15:00:12 -0400
Date: Sat, 10 Sep 2005 12:00:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 7/7] uml: retry host close() on EINTR
In-Reply-To: <20050910174630.063774000@zion.home.lan>
Message-ID: <Pine.LNX.4.58.0509101157170.30958@g5.osdl.org>
References: <20050910174452.907256000@zion.home.lan> <20050910174630.063774000@zion.home.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, Paolo 'Blaisorblade' Giarrusso wrote:
>
> When calling close() on the host, we must retry the operation when we get
> EINTR.

Actually, no.

If close() return EINTR, the file descriptor _will_ have been closed. The
error return just tells you that soem error happened on the file: for
example, in the case of EINTR, the close() may not have flushed all the
pending data synchronously.

Re-doing the close() is the wrong thing to do, since in a threaded 
environment, something else might have opened another file, gotten the 
same file descriptor, and you now close _another_ file.

(Normally, re-doing the close will just return EBADF, of course).

I'm going to drop this patch, but in case you've ever seen a case where 
EINTR actually means that the fd didn't get closed, please holler, and we 
need to fix it.

			Linus
