Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264969AbUDUGCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbUDUGCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbUDUGCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:02:03 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:26123 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264969AbUDUGB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:01:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Kevin O'Connor" <kevin@koconnor.net>
Subject: Re: inline_hunter 0.2 and it's results
Date: Wed, 21 Apr 2004 09:01:48 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua> <20040419214041.GA3749@ohio.localdomain>
In-Reply-To: <20040419214041.GA3749@ohio.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404210901.48882.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resend, I don't see my mail on lkml.org]

On Tuesday 20 April 2004 00:40, Kevin O'Connor wrote:
> On Fri, Apr 16, 2004 at 10:30:40PM +0300, Denis Vlasenko wrote:
> > Size  Uses Wasted Name and definition
> > ===== ==== ====== ================================================
> >    56  461  16560 copy_from_user    include/asm/uaccess.h
> >   122  119  12036 skb_dequeue       include/linux/skbuff.h
> >   164   78  11088 skb_queue_purge   include/linux/skbuff.h
> >    97  141  10780 netif_wake_queue  include/linux/netdevice.h
> >    43  468  10741 copy_to_user      include/asm/uaccess.h
> >    43  461  10580 copy_from_user    include/asm/uaccess.h
>
> Hi Denis,
>
> Why are there two copy_from_user lines?

Good question!

...(/me digs into this)...

Because there are files which has 56 byte copy_from_user().
Namely these:

56 copy_from_user tree/sound/oss/audio.o
56 copy_from_user tree/net/atm/svc.o
56 copy_from_user tree/net/atm/resources.o
56 copy_from_user tree/fs/open.o
56 copy_from_user tree/drivers/video/sstfb.o
56 copy_from_user tree/drivers/video/fbcmap.o
56 copy_from_user tree/drivers/net/pppoe.o

Rest of them (~400 files) has 43 byte one.

disasm, diff of
void inline_copy_from_user_3(void) { copy_from_user(0,0,0); }
yields:

--- copy_from_user_43   Tue Apr 20 23:40:07 2004
+++ copy_from_user_56   Tue Apr 20 23:41:23 2004
@@ -11,11 +11,16 @@
        39 5a 18                cmp    %ebx,0x18(%edx)
        83 d9 00                sbb    $0x0,%ecx
        85 c9                   test   %ecx,%ecx
-       75 0b                   jne    XXXX <inline_copy_from_user_3+0x28>
+       75 0d                   jne    XXXX <inline_copy_from_user_3+0x2a>
        31 c9                   xor    %ecx,%ecx
        31 d2                   xor    %edx,%edx
        31 c0                   xor    %eax,%eax
        e8 fc ff ff ff          call   XXXX <inline_copy_from_user_3+0x24>
+       eb 0b                   jmp    XXXX <inline_copy_from_user_3+0x35>
+       31 c9                   xor    %ecx,%ecx
+       31 d2                   xor    %edx,%edx
+       31 c0                   xor    %eax,%eax
+       e8 4f 01 00 00          call   XXXX <__constant_c_and_count_memset>
        5b                      pop    %ebx
        c9                      leave
        c3                      ret

oops... we've got files which do not honor 'inline' on
__constant_c_and_count_memset()! For example,

fs/open.c:
==========
#include <linux/string.h>
        this pulls __constant_c_and_count_memset()
#include <linux/mm.h>
        this pulls <compiler.h>, re#defining
        inline == __inline__ __attribute__((always_inline)).
        too late!
#include <linux/utime.h>
#include <linux/file.h>
#include <linux/smp_lock.h>
#include <linux/quotaops.h>
#include <linux/dnotify.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/tty.h>
#include <linux/namei.h>
#include <linux/backing-dev.h>
#include <linux/security.h>
#include <linux/mount.h>
#include <linux/vfs.h>
#include <asm/uaccess.h>
#include <linux/fs.h>
#include <linux/pagemap.h>

Will do patch tomorrow.
--
vda
