Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313603AbSDPFbt>; Tue, 16 Apr 2002 01:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313604AbSDPFbs>; Tue, 16 Apr 2002 01:31:48 -0400
Received: from 66-224-32-37.atgi.net ([66.224.32.37]:53266 "EHLO sr71.net")
	by vger.kernel.org with ESMTP id <S313603AbSDPFbr>;
	Tue, 16 Apr 2002 01:31:47 -0400
Message-ID: <3CBBB735.9050406@us.ibm.com>
Date: Mon, 15 Apr 2002 22:31:33 -0700
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: OOPS caused by ext2 changes
In-Reply-To: <3CBB7B73.8090104@us.ibm.com> <3CBB9A15.E04FDA10@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Dave Hansen wrote:
>
>>Andrew Morton and I discused this earlier.  I have some more information
>>now.  The problem: "dbench 64" run on a small (~120meg) partition with
>>1k block sizes produces Oopses.
>>
>>This changeset:
>>http://linus.bkbits.net:8080/linux-2.5/patch@1.248.2.6?nav=index.html|ChangeSet|cset@1.248.2.6
>>is the culprit.  Without it applied, none of this happens.
>>
>However it seems that there's potential for a buffer reference
>leak in ext2_get_branch:
>
>See, sb_bread() bumps b_count, but on the `goto changed;'
>branch we lose track of that buffer.
>
>b_count is only 16 bits, so it's conceivable that the
>count wraps to zero, and that is fatal.
>
>It would be interesting to replace that `goto changed;' 
>with { __brelse(bh); goto changed; }.  Plus maybe a
>debug printk to see if we are indeed hitting that path.
>
Well, I'm a little bit clearer about what's going on now.  I noticed 
that verify_chain() is inline, and that is what is actually Oopsing. 
 Any idea how we're getting 8 into edx?  

edx: 00000008
Code;  c013dea4 <__brelse+4/20>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====

Is the Indirect array getting junk into it?

