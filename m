Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTDRIyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTDRIyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:54:31 -0400
Received: from hera.cwi.nl ([192.16.191.8]:31983 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262945AbTDRIya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:54:30 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 18 Apr 2003 11:06:24 +0200 (MEST)
Message-Id: <UTC200304180906.h3I96OX01783.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: [PATCH] struct loop_info
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andrew Morton <akpm@digeo.com>

    Andries.Brouwer@cwi.nl wrote:
    >
    > Until now as the source already says, we had a very unpleasant
    > situation with struct loop_info:

    This patch makes me pull faces, sorry.

    a) The name "loop_info2" is meaningless.  Something like loop_info64
       would communicate something to the reader.

The 2 communicates that this is a second version of the same struct.
For userspace that is very true, since literally the same definition
can be used.

    b) It is impossible for the reader to tell _why_ loop_info and loop_info2
       exist.  

       It will be especially mysterious in 2.8, where there is no loop_info,
       only a loop_info2.

       Hence covering commentary is compulsory.

OK.

    c) Could we not save a lot of noise by putting:

        typedef unsigned short legacy_dev_t;    /* <= linux-2.4.x */

       into asm/posix_types.h and then keep all this stuff just in
       <linux/loop.h>?

Yes. I considered that and preferred the completely explicit version.
But if you prefer the compact version, and shift a little bit more
work to user space, that also is a possibility.

    d) Would it be possible to just add a u64 to the _end_ of the existing
       loop_info and, in the legacy ioctl(), simply massage it?

Everything is possible, but a smaller change in the kernel corresponds
to a larger change in userspace (and I happen to maintain mount and
losetup and family :-), and there is a largish body of crypto code).
The version as given allows one to keep the user space code unchanged,
except that obscure gymnastics with the dev_t definition may be replaced by

#define LOOP_SET_STATUS    0x4C04
#define LOOP_GET_STATUS    0x4C05

(note that the kernel has loop_info2, but user space can just continue
to call it loop_info; the kernel has LOOP_SET_STATUS2, but user space
can just continue to call it LOOP_SET_STATUS, should it desire to do so).

So what I am saying is that the picture seen from kernel perspective only
differs a bit from the picture seen from both kernel and userspace.
I prefer the kernel changes that lead to minimal textual changes
in user space code.

Andries


[Conclusion:
Ask, and I'll add legacy_dev_t. I slightly prefer the present version.
Ask, and I'll do s/2/64/. No strong opinion.
If I send a second version it'll contain one more line of comment.]
