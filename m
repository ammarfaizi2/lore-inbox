Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267488AbUGNR5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbUGNR5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUGNR5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:57:52 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63659 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267488AbUGNR5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:57:47 -0400
Date: Wed, 14 Jul 2004 19:51:53 +0200 (MEST)
Message-Id: <200407141751.i6EHprhf009045@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Cc: akpm@osdl.org, dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, mikpe@csd.uu.se
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 11:59:01 -0400, Jeff Garzik wrote:
>Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>> 
>> On Wednesday 14 of July 2004 14:16, Mikael Pettersson wrote:
>> 
>>>gcc-3.4.1 errors out in 2.6.8-rc1-mm1 at drivers/scsi/sg.c:
>>>
>>>drivers/scsi/sg.c: In function `sg_ioctl':
>>>drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call to
>>>'sg_jif_to_ms': function body not available drivers/scsi/sg.c:930: sorry,
>>>unimplemented: called from here
>>>make[2]: *** [drivers/scsi/sg.o] Error 1
>>>make[1]: *** [drivers/scsi] Error 2
>>>make: *** [drivers] Error 2
>>>
>>>sg_jif_to_ms() is marked inline but used defore its function
>>>body is available. Moving it nearer the top of sg.c (together
>>>with sg_ms_to_jif() for consistency) fixes the problem.
>> 
>> 
>> While your patch is perfectly fine I think we can do better.
>> I think that we may try converting sg.c to use jiffies_to_msecs()
>> and msecs_to_jiffies() from <linux/time.h>.
>
>
>_Look_ at the patch.  It just moves code around for no reason.  Using 
>static inline prototypes should work just fine.  This patch isn't needed.

It's needed, and no it's not a compiler bug.

2.6.8-rc1-mm1 changed <linux/compiler-gcc3.h> to attach
__attribute__((always_inline)) to inline-declarations.
gcc-3.4, in turn, honors this literally: if it fails to
inline because the function body isn't visible at the
call site, then it generates a compiler error, exactly
as the kernel asked it to.

(And placing 'static inline' on a forward-declared function
is utterly pointless: if its body isn't visible it won't
be inlined, and if it is visible, the forward declaration
itself served no purpose.)

Now maybe Andrew shouldn't have merged that change, but
at least it shows us where inlining doesn't occur, allowing
us to fix the code or remove unnecessary inlines.

/Mikael
