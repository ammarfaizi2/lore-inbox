Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267906AbUHKDNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267906AbUHKDNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267907AbUHKDNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:13:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:10133 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267906AbUHKDNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:13:45 -0400
Date: Tue, 10 Aug 2004 20:13:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Prasanna Meda <pmeda@akamai.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: sendfile bugs(?)
In-Reply-To: <41198757.44B373C1@akamai.com>
Message-ID: <Pine.LNX.4.58.0408102007120.1839@ppc970.osdl.org>
References: <41198757.44B373C1@akamai.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Aug 2004, Prasanna Meda wrote:
> 
> There seems to be couple of issues in sendfile code.
>    - read_write.c: sys_sendfile:do_sendfile checks for ppos
>        to be NULL,  the intension is checking the contents for
>        zero.

No, it really checks the _pointer_ for NULL. 

A NULL ptr means that it's not a pread interface, but that we should use 
f_pos. It's for when the user doesn't pass in any ppos thing: see 
sys_sendfile() for the two cases.

>   - locks_verify_write() may checks at different offset for
>       permission, and copy at different offset, since it is also
>       using out_file->f_pos.  And also it will be cleaner to
>       update out_file->f_pos atomically only when it succeeds.
>       It also deletes the dependency on f_pos from filemap.c.

Yes, this part is probably worth doing. It's probably _also_ worth doing
something similar for the in-file f_pos thing (ie pass in a copy of f_pos
the same way read/write does these days).

		Linus
