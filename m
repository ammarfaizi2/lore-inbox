Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269379AbUIYS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbUIYS3v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUIYS3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:29:51 -0400
Received: from dp.samba.org ([66.70.73.150]:23190 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269379AbUIYS3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:29:48 -0400
Date: Sat, 25 Sep 2004 11:29:07 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925182907.GS580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 11:06:15AM -0700, Linus Torvalds wrote:

> You cannot claim that the number samba now puts there makes _any_ sense.  

Yes I can :-).

> Why the apparent 1MB minimum limit? And if it's just the size of the file
> in bytes, then why bother with it at all? And if you cannot get a 
> blocksize from the OS, why make up a nonsensical number?

As I've mentioned. The 1MB mess is to do with Windows clients
(it makes them faster with Samba). I apologise for that, you
can publicly beat me for it etc. and I promise to fix it for
Linux clients in future, but it works well for the majority
clients we have to support.

Also, the minumum size isn't the same issue as the st_blocks
issue.

> 	CIFS Extensions for UNIX systems V1
> 	LARGE_INTEGER NumOfBlocks
> 	Number of file system block used to store file
> 
> again?  Was it a CIFS Extension for POSIX? Or was it for UNIX like the 
> documentation specifies? Was it bytes, or was it blocks, like the 
> documentation says?

Some history. I turn up at HP and look at the patch they
have for this. They're putting the contents of st_blocks
from the OS (HPUX in their case) into this field. I then
write smbclient test code to test these extensions. Naturally
(and as god intended :-), I assume 512 byte blocks in this
value. When I look at the numbers they make no sense. So
I go digging. I find that 512 byte blocks are *not* guarenteed
(btw, thanks for your apology on being wrong on that... I'm
sure it's in the post :-) and so any clients using this have
no idea what this value actually means. So I have to decide
what this actually means. Yes, I could scale to 512 byte
blocks, but what if it's a HPUX client that expects 8192
byte blocks ? So I decide, unilaterally (like you in the
kernel I am god in the UNIX extensions space :-) to make this
the number returned from st_blocks scaled as bytes. After
all we have a 64 bit field so it has room. And then the
client can scale it to whatever strange block size the
userspace programs expect on that system.

My argument that POSIX doesn't have st_blocks was more
about the "it's always 512" issues, than what the code
does. Of course the code uses it if it's there.

Does it all make more sense now ? 

Jeremy.
