Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUBSC6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUBSC6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:58:22 -0500
Received: from adsl-65-66-12-249.dsl.okcyok.swbell.net ([65.66.12.249]:4047
	"EHLO teco-xaco.com") by vger.kernel.org with ESMTP id S267720AbUBSC6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:58:13 -0500
Message-ID: <4034253E.1040009@teco-xaco.com>
Date: Wed, 18 Feb 2004 20:53:50 -0600
From: Daniel Newby <newby@teco-xaco.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Tridgell <tridge@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So some variation of the interface
> 
> 	int magic_open(
> 		/* Input arguments */
> 		const char *pathname,
> 		unsigned long flags,
> 		mode_t mode,

What about making the pathname hold the alternative cases for each 
character, not just an exact string?  If Samba wanted to open
"A File.txt", it would do

     magic_open( "[a|A][ ][f|F][i|I][e|E][.][t|T][x|X][t|T]", ... )

The syntax shown is conceptual; the actual code would use binary 
packing.  Characters would be variable length to support UTF-8 and 
the like.

Userland would be responsible for making a useful pathname.  If it 
tried something like "[aL|P|#][m|m]", the kernel would cheerfully 
use it.  The only sanity checking would be that special characters 
like "/" and ":" cannot have alternatives.

Pros:

1.  Filesystem names are looked up in kernel mode, where it might be 
efficient.  (Less grossly slow at least.)

2.  But the kernel doesn't care about encodings and character sets.

3.  No new kernel infrastructure needed.  (I hope?)  The case- 
insensitive system calls don't take a performance hit.

4.  The kernel can detect name collisions and decide what to do 
based on a flag.

5.  Lookup tables are totally in userland and outside locks.  Each 
app can use the table it finds appropriate.

6.  A naughty app can't deadlock the filesystem.

7.  Case-insensitive calls can be atomic, if you're willing to pay 
the performance price.  It's straightforward for magic_creat() to 
refuse to create collisions.

Cons:

1.  Looking up multiple alternatives is hairy.  (Not that the other 
approaches are much prettier.)

2.  Massive filenames would get turned into something *really* 
massive (five times as many bytes for a simple packing).  Does this 
break anything?

     -- Daniel Newby


