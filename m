Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVGSSUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVGSSUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVGSSUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:20:39 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:38411 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261704AbVGSSUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:20:37 -0400
Message-ID: <42DD44E2.3000605@tu-harburg.de>
Date: Tue, 19 Jul 2005 20:22:26 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org>
In-Reply-To: <20050719161623.GA11771@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
>>I'm using the i_size of directories in my patches.  When reading
>>from a union directory, I'm using the i_size to seek to the right
>>offset in the union stack.
> 
> 
> Ick.  That'a a bit of a hack.
> 

Don't think so:

1st dir:   [XXXXXXXXXXXXXXXXXXXXX]
       f_pos=0               f_pos=i_size(1st)


2nd dir:   [XXXXXXXXXXX|---------]
       f_pos=i_size(1st)     f_pos=i_size(1st+2nd)
                        ^
                        | f_pos=i_size(1st)+offset

Since these "arranged" values are also used as the offsets in the return 
dirent IMO it is quite clean.

> 
> Hence the value of 20 I guess --- assuming nothing will stack this
> high?
> 

Nope. This value is kind of traditional: tmpfs is using it 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=103208296515378&w=2). I 
think a better value would be 1 (one) since this is also used as the 
dirent offset by dcache_readdir().

> 
> I personally would prefer that to be honest or some other way that
> doesn't change i_size.

The i_size of a directory isn't covered by the POSIX standard. IMO, it 
should be possible to seek in the range of i_size and a following 
readdir()  on the directory should succeed. But this isn't possible even 
not with real file systems like ext2.
But keeping the i_size bound to zero even if the directory contains 
entries does not make sense at all.

Jan
