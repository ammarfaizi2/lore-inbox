Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWH2RiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWH2RiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWH2RiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:38:13 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:40583 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S965177AbWH2RiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:38:11 -0400
Message-ID: <44F47B84.90605@slaphack.com>
Date: Tue, 29 Aug 2006 12:38:12 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: PFC <lists@peufeu.com>
CC: Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 und LZO compression
References: <20060827003426.GB5204@martell.zuzino.mipt.ru> <20060827010428.5c9d943b.akpm@osdl.org> <op.te1q2sfbcigqcu@apollo13>
In-Reply-To: <op.te1q2sfbcigqcu@apollo13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PFC wrote:
> 
> 
>     Would it be, by any chance, possible to tweak the thing so that 
> reiserfs plugins become kernel modules, so that the reiserfs core can be 
> put in the kernel without the plugins slowing down its acceptance ?

I don't see what this has to do with cryptoapi plugins -- those are not 
related to Reiser plugins.

As for the plugins slowing down acceptance, it's actually the concept of 
plugins and the plugin API -- in other words, it's the fact that Reiser4 
supports plugins -- that is slowing it down, if anything about plugins 
is still an issue at all.

Making them modules would make it worse.  Last I saw, Linus doesn't 
particularly like the idea of plugins because of a few misconceptions, 
like the possibility of proprietary (possibly GPL-violating) plugins 
distributed as modules -- basically, something like what nVidia and ATI 
do with their video drivers.

As it is, a good argument in favor of plugins is that this kind of thing 
isn't possible -- we often put "plugins" in quotes because really, it's 
just a nice abstraction layer.  They aren't any more plugins than 
iptables modules or cryptoapi plugins are.  If anything, they're less, 
because they must be compiled into Reiser4, which means either one huge 
monolithic Reiser4 module (including all plugins), or everything 
compiled into the kernel image.

>     (and updating plugins without rebooting would be a nice extra)

It probably wouldn't be as nice as you think.  Remember, if you're using 
a certain plugin in your root FS, it's part of the FS, so I don't think 
you'd be able to remove that plugin any more than you're able to remove 
reiser4.ko if that's your root FS.  You'd have to unmount every FS that 
uses that plugin.

At this point, you don't really gain much -- if you unmount every last 
Reiser4 filesystem, you can then remove reiser4.ko, recompile it, and 
load a new one with different plugins enabled.

Also, these things would typically be part of a kernel update anyway, 
meaning a reboot anyway.

But suppose you could remove a plugin, what then?  What would that mean? 
  Suppose half your files are compressed and you remove cryptocompress 
-- are those files uncompressed when the plugin goes away?  Probably 
not.  The only smart way to handle this that I can think of is to make 
those files unavailable, which is probably not what you want -- how do 
you update cryptocompress when the new reiser4_cryptocompress.ko is 
itself compressed?

That may be an acceptable solution for some plugins, but you'd have to 
be extremely careful which ones you remove.  The only safe way I can 
imagine doing this may not be possible, and if it is, it's extremely 
hackish -- load the plugin under another module name, so 
r4_cryptocompress would be r4_cryptocompress_init -- have the module, 
once loaded, do an atomic switch from the old one to the new one, 
effectively in-place.

But that kind of solution is something I've never seen attempted, and 
only really heard of in strange environments like Erlang.  It would 
probably require much more engineering than the Reiser team can handle 
right now, especially with their hands full with inclusion.

>>> The patch below is so-called reiser4 LZO compression plugin as extracted
>>> from 2.6.18-rc4-mm3.
>>>
>>> I think it is an unauditable piece of shit and thus should not enter
>>> mainline.
>>
>> Like lib/inflate.c (and this new code should arguably be in lib/).
>>
>> The problem is that if we clean this up, we've diverged very much from 
>> the
>> upstream implementation.  So taking in fixes and features from upstream
>> becomes harder and more error-prone.
>>
>> I'd suspect that the maturity of these utilities is such that we could
>> afford to turn them into kernel code in the expectation that any future
>> changes will be small.  But it's not a completely simple call.
>>
>> (iirc the inflate code had a buffer overrun a while back, which was found
>> and fixed in the upstream version).
>>
>>
> 
> 

