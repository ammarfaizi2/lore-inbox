Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318853AbSH1Oeh>; Wed, 28 Aug 2002 10:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318855AbSH1Oeh>; Wed, 28 Aug 2002 10:34:37 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:519 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318853AbSH1Oeg>;
	Wed, 28 Aug 2002 10:34:36 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208281438.g7SEcoQ22578@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: From "(env:" "ptb)" at "Aug 27, 2002 09:28:42 pm"
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Wed, 28 Aug 2002 16:38:50 +0200 (MET DST)
Cc: Thunder from the hill <thunder@lightweight.ods.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago ptb wrote:"
> "A month of sundays ago Thunder from the hill wrote:"
> > > And for the O_DIRECT flag we seem to do alloc_kiovec(1, &f->f_iobuf).
> > 
> > Perhaps we should go biovec here?

State of play:

1) I abandoned doing the dentry_open with O_DIRECT flags bit
from within the driver, because every external access then errored
with EINVAL without getting to my driver functions.

2) I then just tried opening the device normally from userspace
but with O_DIRECT set. This is harder than it should have been - I had
to set nearly everything in features.h on before I got the desired
compilation (was it _XOPEN_SOURCE that did it? I forget), and surprise,
surprise, I get exactly the same effects as in (1). Every access
errors with EINVAL and my driver code never gets called. An open
with code compiled without O_DIRECT works fine, as usual.

I put a little debugging in the driver open call. With O_DIRECT
in the userspace open:

#881[12]: _open have O_DIRECT iobuf 0xcf935000 for part 0
#883[12]: _open have i_mapping 0xcce7f874 for part 0
#885[12]: _open have a_ops 0xc029ef40 for part 0
#889[12]: _open have direct_IO 0xc013edc0 for part 0

(I presume the latter is generic_file_direct_IO - it's not in my
map, but it's static so shouldn't be).

and without:

#881[14]: _open have ~O_DIRECT iobuf 0x0 for part 0
#883[14]: _open have i_mapping 0xcce7f874 for part 0
#885[14]: _open have a_ops 0xc029ef40 for part 0
#889[14]: _open have direct_IO 0xc013edc0 for part 0

So it looks as though some driver cooperation is required in
order for direct_IO/O_DIRECT to work.

What? Anyone know?


Peter
