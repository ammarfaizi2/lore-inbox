Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTETHLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 03:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTETHLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 03:11:38 -0400
Received: from terminus.zytor.com ([63.209.29.3]:21389 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263617AbTETHLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 03:11:35 -0400
Message-ID: <3EC9D823.5020400@zytor.com>
Date: Tue, 20 May 2003 00:24:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>	<babhik$sbd$1@cesium.transmeta.com>	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>	<1053392095.21582.48.camel@imladris.demon.co.uk>	<3EC9803F.6010701@zytor.com> <m1of1y15v1.fsf@frodo.biederman.org>
In-Reply-To: <m1of1y15v1.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> Ugh.  I now see both sides of this.
> 
> ABI changes always require writing new code to take advantage
> of it but that code does not need to live in libc.  And libc is expected
> to have the definitions necessary to compile the new code.
> 

Bingo.

>>
>>I maintain the proposal I have given before:
>>
>><linux/abi/*.h> as the header file namespace;
> 
> What about <linux-abi/*.h>
> 
>><linux/*.h> <asm/*.h> namespaces reserved for compatibility (once the
>>migration is complete these are owned by the libc)
> 
> I think removing the abi namespace totally from the legacy directories
> helps this to a small extent.
> 

It might, but the <linux/abi/*.h> namespace hasn't been used, so it 
isn't really legacy in the sense that you can have a possible conflict. 
  Having said that, <linuxabi/*.h> is the least bleacherous nonlegacy 
alternative I've seen (I'd like to skip the dash, though.)  <abi/*.h> is 
already taken.

> 
>>Types use the __kernel_* namespace *only*; structures use struct __kernel_*.
>>
>>Some form of export of the expected syscall ABI as well as syscall
>>numbering.
> 
> 
> Prototypes for everything including ioctls.
>  

Absolutely.  As I said in another post, if this is done correctly, a 
whole bunch of the ABI compatbility stuff like the 32-on-64 things 
should be possible to generate automatically.  If that isn't true, it's 
done wrong.

>>
>>A bigger issue is if this really should be done in C.  A worthwhile
>>thought: if this is done correctly then most or all of the 64/32 compat
>>code (or any other arch1-on-arch2 compatibility) should be able to be
>>automatically generated.  If not, it almost certainly isn't done
>>correctly...
> 
> 
> Potentially.  Certain things like type conversions may be a non-trivial
> exercise.  It is certainly true that it should be possible to build
> the entire decoding logic for strace.  Even in the mixed architecture
> cases.
> 
> For cases that are hard to automate see: sys_old_mmap vs. sys_mmap2,
> on x86.  Potentially it can be done but it requires a powerful stub
> generator.
> 

That one is somewhat tricky, and probably needs some ad hoc code. 
However, you get a long way toward the goal if you can express the 
following:

void * sys_mmap(void *, size_t, int, struct { int, int, off32_t });
void * sys_mmap2(void *, size_t, int, int, int, off32_t);
void * sys_mmap64(void *, size_t, int, int, int, struct { off64_t });

(The latter doesn't exist at the moment AFAIK, but at some point it'll 
be necessary.)

You can get even further if you can express the fact that the final 
structure in sys_old_mmap are "memory arguments" -- ordinary arguments 
spilled to memory because we ran out of registers ("prematurely" in the 
case of sys_mmap, due to backwards compatibility constraints.)

> 
>>>If Linus would approve a strategy for rearranging the headers such that
>>>people can work on it without suspecting that they're just wasting their
>>>time, I think it could get done for 2.6.
>>>
>>>It's not the kind of thing you do in private and present as a fait
>>>accomplis -- if it isn't quite right, you end up having to do the whole
>>>thing from scratch, afaict.
>>
>>Agreed.
> 
> If it is done purely as headers certainly.  For a header generator it
> might be something you can get away with.  Because the core repository
> would not need to change just the world useable form.  This may
> be the one good argument for doing this in something other than C.
> 

On the other hand, Linus just released "sparse", which is a pretty nice 
  C parser that might be useful for this, especially with some kind of 
custom annotation capability.  I talked to him about this a while ago, 
actually.

	-hpa


