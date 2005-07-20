Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVGTSXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVGTSXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGTSXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:23:36 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:28271 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261455AbVGTSXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:23:00 -0400
Message-ID: <42DE96F2.9070105@tu-harburg.de>
Date: Wed, 20 Jul 2005 20:24:50 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org>
In-Reply-To: <20050719191648.GA24444@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> Hos does that work if offset >= m?
> 

Eerrh, did you actually read my patch? The i_size of a directory is 
increased by SIMPLE_BOGO_DIRENT_SIZE for every entry in the directory.

 >>So you can seek to m*<stack-depth>+<offset> to access an offset into
 >>> >something at depth m?
 >>> >
 >>
 >> Yes.

I got that one wrong! You can seek to the "sum of i_sizes (of the m 
directories) + offset" to access offset in the m'th directory/stack-depth.

> 
> lseek talks about bytes --- yes, it means for files specifically but I
> still don't see why we need to define more counter-intuitive semantics
> for directories when we don't need them.

It is counter-intuitive to have a value which is information less, like 
in the zero case.

> 
> Also, how is lseek + readdir supposed to work in general?

This is how libc is reading directories (at least on arch s390x):

getdents() != 0
lseek() to d_off of last dirent
getdents() != 0
lseek() to d_off of last dirent
getdents() == 0
return

Therefore I really need values that make sense for d_off. Therefore I 
really need values that make (some kind of) sense for i_size.

Jan
