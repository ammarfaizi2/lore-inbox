Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272322AbRISP6K>; Wed, 19 Sep 2001 11:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274033AbRISP6B>; Wed, 19 Sep 2001 11:58:01 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:15879 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S272322AbRISP5m>; Wed, 19 Sep 2001 11:57:42 -0400
Message-ID: <3BA8C01D.79FBD7C3@osdlab.org>
Date: Wed, 19 Sep 2001 08:56:13 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, crutcher+kernel@datastacks.com,
        lkml <linux-kernel@vger.kernel.org>, paulus@au.ibm.com
Subject: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(and maybe earlier...)

Simple problems grow...

Keith Owens has already noted one problem in sysrq.c (2.4.10-pre12).

Beginning:

I have an IBM model KB-9910 keyboard.  When I use
Alt+SysRQ+number (number: 0...9) on it to change the
console loglevel, only keys 5 and 6 have the desired
effect.  I used showkey -s to view the scancodes from
the other <number> keys, but showkey didn't display
anything for them.  Any other suggestions?


For now, I'm just using different (non-number) keys
to modify the loglevel.

Anyway, in looking at SysRq loglevel handling in
2.4.9-ac (and 2.4.10-pre12), I see that it has been modified
quite a bit.  Looks extensible, which can be good.
However, looking over it gave me several nagging questions
and problems.

1.  Was this stuff tested?  How ???

It always sets console_loglevel and then restores
console_loglevel from orig_log_level, so Alt+SysRq+#
handling is severely broken.

If someone (Crutcher ?) wants to patch it, that's fine.
If I patched it, I would just add a
  next_loglevel = -1;
at the beginning of __handle_sysrq_nolock() and then
let the loglevel handler(s) set next_loglevel.
If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
set console_loglevel to next_loglevel.

2.  I'd really prefer to see callers use
register_sysrq_key() and unregister_sysrq_key() so that they
can get/use return values, and not the lower-level functions
"__sysrq*" functions that are EXPORTed in sysrq.c.
I don't see a good reason to EXPORT all of these functions.

E.g., arch/ppc64/start/xmon.c calls __sysrq_put_key_op('x', ...).
It doesn't know (and cannot know) whether this call succeeded
or not.

3.  And the sysrq_key_table[] (comments) should end with
w, x, y, z, not with w, x, w, z.


~Randy

You can't do anything without having to do something else first. 
         -- Belefant's Law
