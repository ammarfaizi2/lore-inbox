Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVCERUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVCERUB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVCERTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:19:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28678 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263035AbVCERP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:15:58 -0500
Date: Sat, 5 Mar 2005 18:15:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kai Germaschewski <kai.germaschewski@unh.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050305171556.GE6373@stusta.de>
References: <20050305153638.GD6373@stusta.de> <Pine.LNX.4.44.0503051108300.20560-100000@chaos.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0503051108300.20560-100000@chaos.sr.unh.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 11:36:23AM -0500, Kai Germaschewski wrote:
> On Sat, 5 Mar 2005, Adrian Bunk wrote:
> 
> > This warning sounds like a good plan (but it won't let many objects stay 
> > inside lib-y).
> 
> The patch is simple (except that the warning it throws looks rather ugly), 
> see appended.
> 
> However, I spoke too soon. There actually is a legitimate use for 
> EXPORT_SYMBOL() in a lib-y object, e.g. lib/dump_stack.c. This provides a 
> default implementation for dump_stack(). Most archs provide their own 
> implementation (and EXPORT_SYMBOL() it), and in this case we definitely 
> want the default version in lib to be thrown away, including its 
> EXPORT_SYMBOL. So the appended patch throws false positives and thus can 
> not be applied.

That's usually solved through #define's (see e.g. lib/extable.c).

> Still, many files in lib-y "should" be moved to obj-y. Then again, the 
> clear cases (e.g. ctype, vsnprintf) are getting used in the static kernel 
> image, so they get linked in anyway, moving them from lib-y to obj-y 
> doesn't make any difference whatsoever.
> 
> The interesting cases are more of the crc32 type -- some people may not 
> use this at all, so they want the space savings. Moving all of those into 
> obj-y unconditionally creates unnecessary bloat. Actually, crc32 already 
> did the right thing -- a config option. That would work for parser.o, too, 
> just make the filesystems which need it "select CONFIG_PARSER".

It's used by many filesystems plus some optional part of the USB code.

Basically, there are two choices:
- always include a function
- include a function only if required

The second one is possible, but object files are the wrong granularity - 
why should it pull the whole parser.c if only match_strdup was required?

You have all possibilities with #define's.

> I think there are basically three cases of objects in lib-y:
> 
> o functions we clearly use anyway, e.g. vsprintf.o.
>   these should be always available, also for modules (pretty much every
>   module uses printk, right?)
>   So these should be in obj-y, however since they always get used in the
>   kernel, too, independent of the .config, in practice there's no 
>   difference to them being in lib-y.

Agreed.

> o "weak" implementations, which may be overwritten by a arch-specific
>   implementation.
>   These need to be in lib-y for this mechanism to work.

This doesn't work if the object file also contains other code.

> o Marginal cases like crc32.o, parser.o, bitmap.o
>   There are real world cases out there where these functions will never be 
>   used, so just compiling them into the kernel because one day there may 
>   be a module which wants to use them does cause some bloat. Making them
>   config options and have every module which needs them mention them in
>   Kconfig causes some bloat on the source side.

Can you send a .config where bitmap.o isn't used?

>   It's a trade-off. In my tree (current -bk), parser.o symbols are
>   referenced by procfs, i.e. 99.9% of all builds will pull it in anyway.
>   So putting it into obj-y is a good solution, IMO. (Do I hear the 
>   embedded people cry?)
>   I guess in -mm this changed, which may justify going to CONFIG_PARSER
>   (along the lines of CONFIG_CRC32) way. Then again, .text of
>   parser.o is 0x373 bytes on my x86_64 system. Not a whole lot to
>   lose when it's compiled in unconditionally. (And it's used among others 
>   by ext2 and ext3, so chances are, you need it anyway)

As above:
If you care about code size, CONFIG_PARSER gives the wrong granularity.



My general impression is:

Everything lib-y does can be done with obj- and #define's.
And this way, it's done explicit.

I'm not really happy with tricks like compiling two versions of 
dump_stack() and the linker somehow discards the right one.


> --Kai
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

