Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129514AbQKMXDj>; Mon, 13 Nov 2000 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbQKMXD3>; Mon, 13 Nov 2000 18:03:29 -0500
Received: from smtp-abo-4.wanadoo.fr ([193.252.19.153]:63431 "EHLO
	antholoma.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129514AbQKMXDP>; Mon, 13 Nov 2000 18:03:15 -0500
Date: Mon, 13 Nov 2000 23:43:49 +0100
To: linux-kernel@vger.kernel.org
Cc: petkan@spct.net, mingo@redhat.com
Subject: Inconsistencies in 3dNOW handling
Message-ID: <20001113234349.A28046@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at what the CONFIG_X86_USE_3DNOW config option in 2.40.-test10
enables, I find a couple of strange things.  This led me through a
small high-level audit of 3DNOW/MMX stuff.

Hopefully someone will be able to explain or to confirm whether the
points I highlight are indeed bugs.  I'd value some comments before
starting to change this :}


- CONFIG_MK6 is described as "K6/K6-II/K6-III", and CONFIG_MK7 as
"Athlon/K7".  Of these two, only the latter defines
CONFIG_X86_USE_3DNOW, although K6-II and K6-III do provide 3DNOW
instructions.  We even find in strings-486.h a comment saying:

	This CPU favours 3DNow strongly (eg AMD K6-II, K6-III, Athlon)

OTOH, string.h only says:

 *	This CPU favours 3DNow strongly (eg AMD Athlon)

page.h says:

 *	On older X86 processors its not a win to use MMX here it seems.
 *	Maybe the K6-III ?

Gasp.  Would it or not in the end be useful to add a CONFIG_MK6II
option that would enable 3DNOW ?


- In all places where 3DNOW is tested (strings-486.h, page.h), only
MMX-specific funcs are used (_mmx_memcpy mostly, mmx_{clear,copy}_page)

page.h says:

 *	On older X86 processors its not a win to use MMX here it seems.
 *	Maybe the K6-III ?

mmx.[ch] say:

 *	MMX 3Dnow! helper operations

So do they use MMX or 3Dnow after all ?  They are distinct processor
features, aren't they ?

If this option is really just meant to enable MMX stuff, let's just
call it by its name

Some doc about that should be written - I'll gladly do that once I've
gathered the info.  Some Documentation/i386/MMX file maybe, or in
mmx.c.  But this info won't be easily found anyway if we keep using
3DNOW as a name for the config option...  Objections ?


- mmx.c says:

	Checksums are not a win with MMX on any CPU
	tested so far for any MMX solution figured

This would be better to have the list of tested CPUs here.  Does
someone have this list ?


- there is even a CONFIG_X86_USE_3DNOW_AND_WORKS option, that would
enable MMX in __generic_copy-{to,from}_user
(arch/i386/lib/usercopy.c).  There is no comment about why this code
was disabled.

This code uses the following test to trigger MMX use:

		if(n<512)
			__copy_user(to,from,n);
		else
			mmx_copy_user(to,from,n);

... whereas string{,-486}.h use the following test to trigger MMX use:

	if(len<512 || in_interrupt())
		return __constant_memcpy(to, from, len);
	return _mmx_memcpy(to, from, len);

Could this be the cause of the problem ?


You'll also have noticed the inconsistent naming in 2 highly similar
pieces of code.


- BTW, what does this 512 stand for ?  Especially as it's used in
several places, a #define would seem nice at first glance.


- In mmx.c, function naming and ordering really seems inconsistent.
Or is there a reason for a "zero/clear" duality ?


- drivers/md/xor.c says:

	certain CPU features like MMX can only be detected runtime

I'm not sure how much this relates to the above, but I'd say a MMX
config option could be used for this ?  Or a common detection routine
that other drivers could use ?

-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
debian-email:   <dirson@debian.org> |   Support Debian GNU/Linux:
                                    | Cheaper, more Powerful, more Stable !
http://ydirson.free.fr/             | Check <http://www.debian.org/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
