Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTI3X56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTI3XzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:55:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:48032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbTI3XzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:55:02 -0400
Date: Tue, 30 Sep 2003 16:54:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs sparse fixes
In-Reply-To: <UTC200309291825.h8TIPB318380.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0309301649470.21089-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003 Andries.Brouwer@cwi.nl wrote:
> 
> I think I prefer two rights above two wrongs - the declaration
> already gives addr the right type - it really does point to kernel space -
> but we inherit an incorrect type for file->f_op->write, so have to cast
> that.

No, the type for file->f_op->write is of the _rigth_ type.

It literally _does_ get the data from user space.

The thing is, what "set_fs(KERNEL_DS)" does is to say "kernel space is now 
user space". So the _caller_ will have made user space and kernel space be 
the same mapping, exactly so that the write will do the right thing.

[ Yeah, we long since renamed all the "get_fs_byte()" calls to a much more
  natural "get_user()" macro, and the "set_fs()" thing should be renamed
  too. It obviously makes no sense any more, since we don't use the '%fs'
  segment register even on x86 these days, and on other architectures it
  never made any sense in the first place. ]

So as a result of the "set_fs()" the kernel pointer literally _becomes_ a 
user-pointer. That's what set_fs() is all about. And that's why it is 
correct to cast the pointer - but not the function. The function still 
takes a user pointer.

			Linus

