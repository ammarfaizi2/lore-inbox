Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTJXJg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTJXJg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:36:29 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:41163 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262118AbTJXJgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:36:21 -0400
Message-ID: <3F98F2F1.3000408@t-online.de>
Date: Fri, 24 Oct 2003 11:37:53 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: Vojtech Pavlik <vojtech@suse.cz>, torvalds@osdl.org
Subject: [PATCH] setkeycode ioctl fix
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: Srlaj0ZlweNAmvhqx3uoeLjYm6+2+zIcK0mUWt4QUhv909N-Dx6rwi@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

This is a bugfix for setkeycode() in /drivers/char/keyboard.c.

If we change a keycode the corresponding bit should be cleared if  and 
only if
this keycode is not defined any longer. I believe that this also was 
intended
with the original code, but the implementation is faulty.

First off all the first three changed lines are obviously erroneus: 
oldkey == truekey
is false or true, you do not need to inclose this in a for(). I believe 
the author
intended INPUT_KEYCODE(dev,i) == oldkey. But fixing this alone is not 
enough.

If somebody wants to interchange the definition of two keys A and B, the 
normal way
is to use two setkeycode calls:

    setkeycode (scancode A, keycode B);
    setkeycode (scancode B, keycode A);

The old code does a clearbit(oldkey ..) call even in situations where 
two keys have
the same definition, and this situation arises commonly in the situation 
mentioned
above.

Both errors are fixed with this patch.

As this is a pure and obvious bugfix, please include it before releasing 
2.6.0-final.

The patch is against 2.6.0-test8-bk3, but the code of keyboard.c has not 
changed
for a long time.

cu,
 Knut Petersen


--- drivers/char/keyboard.orig  2003-10-17 23:43:03.000000000 +0200
+++ drivers/char/keyboard.c     2003-10-24 12:17:36.000000000 +0200
@@ -204,13 +204,13 @@
        oldkey = INPUT_KEYCODE(dev, scancode);
        INPUT_KEYCODE(dev, scancode) = keycode;

-       for (i = 0; i < dev->keycodemax; i++)
-               if(keycode == oldkey)
-                       break;
-       if (i == dev->keycodemax)
-               clear_bit(oldkey, dev->keybit);
+       clear_bit(oldkey, dev->keybit);
        set_bit(keycode, dev->keybit);
-
+
+       for (i = 0; i < dev->keycodemax; i++)
+               if(INPUT_KEYCODE(dev,i) == oldkey)
+                       set_bit(oldkey, dev->keybit);
+
        return 0;
 }



