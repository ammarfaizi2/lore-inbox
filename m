Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTDJXeL (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTDJXeJ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:34:09 -0400
Received: from watch.techsource.com ([209.208.48.130]:41974 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264264AbTDJXeE (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:34:04 -0400
Message-ID: <3E960536.5010900@techsource.com>
Date: Thu, 10 Apr 2003 19:58:46 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Painlessly shrinking kernel messages (Re: kernel support for
 non-english user messages)
References: <3E95EB6D.4020004@techsource.com> <1050010963.12494.132.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>Not a totally crazy idea. You could also do 5pack and some of the other
>string tricks people have used in time. You also dont need to do word
>boundaries.
>
My google search for '5pack' didn't come up with anything relevant. 
 Things that come to mind include converting to a character set which 
requires fewer than 8 bits per character and then packing them into 
bytes.  Or perhaps making a list of every quintuplet of characters that 
ever occurs and assign them codes.

I initially considered the idea of ignoring word boundaries.  I rejected 
it because part of the "painless" factor would be that it could be done 
manually without a lot of thinking.  But I will run a test which ignores 
word boundaries and see what kinds of results I get.  Of course, if we 
want to do something that involves some post-compile magic or whatnot, 
then we can do all sorts of gnarley tricks.  But that doesn't differ (in 
complexity) much from the idea someone else mentioned which was to 
completely remove all messages from the kernel by magically converting 
them to numbers or hashes and then decoding them outside of the kernel.  

There was mentioned a valid point that boot messages need to be handled 
properly by the kernel before any services are up.  Separating the boot 
messages from the non-boot messages would require manual intervention 
that goes against the painless factor, and is the pie slice containing 
only non-boot messages large enough that it's worth it?  There seem to 
be quite a lot of boot messages that could benefit from some sort of 
completely-in-kernel compression.


>
>For embedded at least this is far from ludicrous as a concept. The
>tricky piece for all of these is working out how to grab each printk
>format string and do things to it. That lets you do compression,
>removal, internationalisation, cataloguing ..
>  
>

Hmmm...
- Make gcc produce assember output
- Find all calls to prink
- Cross-reference those against all static strings
- Compress the strings
- Run through gas, etc.

The problem with this approach is that we have to deal with different 
architectures.  The plus is that any unsupported arch just doesn't run 
the compression tool and uses regular printk.

How about:
- Use perl or yacc or something to parse the kernel source for strings
- Compress them
- Make the substitutions inline in the source as part of the 
pre-processing stage
- Compile

Heck, we could just embed this functionality directly into the 
preprocessor.  Unfortunately, this one is somewhat beyond my current 
knowledge of the tools that would make it convenient.


Just as a note, I worked on my test program to make it a more accurate. 
 For 128 codes, the actual reduction is 38946 bytes.  For this 
algorithm, I look to see if any of the shorter words are contained in 
any of the larger ones; in the case where the shorter word's 
substitution would shrink the kernel more than the larger, I add the 
larger word's count to the smaller and delete the larger.  

If we were to outlaw some of the lower characters, such as most 
non-printing characters and all lower-case, then that brings us up to 
having 184 codes to work with.  That lets us save 42692 bytes.  If we 
were to go to two-character codes, where the first one is 128-255 and 
the second is 1-255, that brings the number of codes up to 32640.  It 
turns out that, with my current algorithm, it doesn't buy anything, and 
it also violates the painless factor by giving people a huge list of 
words they have to pick from when writing kernel messages.  Also, it 
turns out that there are only just over 500 different words which would 
save more than 2 bytes by being encoded.

I need to get a LOT more clever about this before it's worth doing. 
 I'll try the no-word-boundaries approach.  And we'll see how interested 
other people are in having to DEAL with it.



BTW, should I faint or something because THE Alan Cox responded to my 
first post to lkml?  :)
You hate it when people say that sort of thing, don't you.  :)


