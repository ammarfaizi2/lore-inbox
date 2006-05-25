Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWEYQfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWEYQfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWEYQfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:35:31 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:18914 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965199AbWEYQfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:35:30 -0400
Message-ID: <4475DCC0.6000507@mandriva.org>
Date: Thu, 25 May 2006 19:35:12 +0300
From: Anssi Hannula <anssi@mandriva.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
References: <20060515211229.521198000@gmail.com>	<20060515211506.783939000@gmail.com>	<20060517222007.2b606b1b.akpm@osdl.org>	<44757246.9010300@mandriva.org>	<20060525070017.16344c97.akpm@osdl.org>	<4475C2F2.7090207@mandriva.org> <20060525075257.3f2963a9.akpm@osdl.org>
In-Reply-To: <20060525075257.3f2963a9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Anssi Hannula <anssi@mandriva.org> wrote:
> 
>>>Generally we use file descriptors (and driver-specific state at
>>
>> > file.f_private) to manage things like that.  But I'd imagine that we
>> > couldn't retain the existing semantics with any such scheme.
>> > 
>> > A pragmatic approach would be to put a big fat comment in there explaining
>> > how it all works and leave it at that.
>>
>> As I don't see this could break any existing applications, I would very
>> much like to change the behaviour so that the effects are file
>> descriptor specific.
> 
> 
> ooh, that's always risky - we just don't know what people are doing out
> there.  They do the damnedest things.
> 
> Is it possible to implement the new behaviour while retaining the old
> behaviour as well?  And to detect when an app is using the old behaviour
> and to drop a printk("stop doing this")?  So we can kill the old behaviour
> in a year or so?

I *really* don't think any app is trying to do one of the following:
- open another fd to the same device and delete effect created in the
first fd
- open and close another fd to the same device to delete all effects

The latter one doesn't make any sense (the process could just open and
close the first fd), but the former one is possible, though very unlikely.

I count only 6 programs using linux ff, of which 3 are test programs.
None of those messes up with fd's so that they would depend on the old
behaviour. I would change the behaviour, while we still can.

What we could do is allow deleting effects, whether they're owned by the
fd or not. If they aren't, printk() would be issued.

> 
>>What should I use to differentiate the descriptors?
>> Can I just compare the "struct file*"? (it seems to work well, I just
>> modified the code so)
> 
> Depends what you're trying to do.  Different threads in the same process
> can share the same file*'s.

I try to have a coherent behaviour:
- fd1 opened
- fd1: effects 0, 1 are created
- fd2 opened
- fd2: effects 2, 3 are created
- fd2 closed
=> effects 2, 3 get deleted
- fd1 uses effects
- fd1 closed
=> effects 0, 1 get deleted


I will once again give an example how things would go with the old
behaviour:
- fd1 opened
- fd1: effects 0, 1 are created
- fd2 opened
- fd2: effects 2, 3 are created
- fd2 closed
=> effects 0, 1, 2, 3 get deleted
- fd1 uses effects
=> failure
- fd1 closed


(fd1 and fd2 are of the same process and the same device)

-- 
Anssi Hannula

