Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271896AbRIMRHl>; Thu, 13 Sep 2001 13:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271900AbRIMRHc>; Thu, 13 Sep 2001 13:07:32 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:35591 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S271896AbRIMRHT> convert rfc822-to-8bit; Thu, 13 Sep 2001 13:07:19 -0400
Date: Thu, 13 Sep 2001 19:07:41 +0200
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: some possible bugs around (race conditions etc.)
Message-ID: <20010913190741.A8184@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we (Kamil Toman <ktoman@email.cz> and me) were studying linux source
and trying to make some "audit". We went over 2.4.7 source and in the
time of this writing I'm looking at 2.4.9-ac10 to compare if it was
changed. This is a list of possible things we have found:

[ definitely - we're kernel newbies so take us easy ;-) ]

lines according to 2.4.9-ac10:

kernel/capability.c:
59-63, 91-93, 203-206: SMP race, possible fix: rwlock

kernel/exit.c:
485: sys_exit doesn't return anything (nor long type)
        why it isn't void ?
442-447: is this signal handling correct?
501: task INTERRUPTIBLE - possible ineffectivity, couldn't this task
        be woken up too often (early)?

kernel/fork.c:
586: isn't memcpy() more effective?

kernel/acct.c:
SMP race ?:
----------------------------------------------------
CPU1                            CPU2

sys_acct(file)
{
    ....
    if (old_acct)

                                sys_acct(NULL)
                                sys_acct(nextfile)
                                {

                                    ....
        do_acct_process() -- BUG!
        filp_close() -- BUG!
----------------------------------------------------

kernel/sys.c:
1217: mixed signed/unsigned - doesn't it return EINVAL even when it
        shouldn't?
1042: what if strlen < len? can we get rid of chars after null?
428: why wmb() ?

kernel/sched.c:
1303-1309: isn't there a same race cond. as in kmod.c:65 ?
1323: is this needed on UP?
603:  is this correct on SMP? shouldn't there be some penalty
        accounted for being "randomly" woken/run?

kernel/kmod.c
211: shouldn't module_name be tested a bit?

Comments are welcomed.

Have a nice day

-- 
   Martin Maèok
  underground.cz
    openbsd.cz
