Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132243AbRBRAKr>; Sat, 17 Feb 2001 19:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132240AbRBRAKi>; Sat, 17 Feb 2001 19:10:38 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40630 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131228AbRBRAKZ>;
	Sat, 17 Feb 2001 19:10:25 -0500
Date: Sun, 18 Feb 2001 01:10:14 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102180010.BAA163601.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, swansma@yahoo.com
Subject: Re: Fwd: Re: System V msg queue bugs in latest kernels
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From swansma@yahoo.com Sat Feb 17 22:45:36 2001

    I'm sending this to you with the hope that lines like this (in ipcs.c)
    can be modified to report proper values:

     printf ("%-10o%-12ld%-12ld\n",
                    ipcp->mode & 0777,
                    /*
                     * glibc-2.1.3 and earlier has unsigned short;
                     * glibc-2.1.91 has variation between
                     * unsigned short, unsigned long
                     * Austin has msgqnum_t
                     */
                    (long) msgque.msg_cbytes,
                    (long) msgque.msg_qnum);  

    msg_cbytes and msg_qnum should be handled differently (as per Manfred's
    email).

Hmm. In 2.2.18 these fields are short in the kernel, so there is
no more information, and ipcs cannot print it.
In 2.4.1 these fields are long in the kernel, and are copied back
to user space using copy_msqid_to_user() which will give the longs
in case IPC_64 was set, and the shorts otherwise.

(By the way, "IPC_64" is rather a misnomer - it is more like IPC_32.
I could well imagine that we'll need something for 64-bits sooner or
later (and call it IPC_128 then?).)

Manfred's email does

    #define msg_lqbytes        __rwait

that is, his program stores information in, and retrieves information
from some field that maybe is unused. In fact the kernel also uses it,
so I don't think that would be very successful.

No, we must just use IPC_64 when it is available, and that is glibc's job.
Looking at the libc source I see that glibc-2.1.95 does this, but
glibc-2.1.3 doesn't. So, maybe, if you upgrade your glibc all will be well.

Andries
