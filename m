Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129179AbQKBVAZ>; Thu, 2 Nov 2000 16:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQKBVAG>; Thu, 2 Nov 2000 16:00:06 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:35959
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129179AbQKBU75>; Thu, 2 Nov 2000 15:59:57 -0500
Date: Thu, 2 Nov 2000 22:52:21 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: #ifdefs vs. unused variables?
Message-ID: <20001102225221.A676@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Various parts of the kernel, notably the drivers, have sections
of code that is only relevant if certain defines are valid. The
obvious examples would be CONFIG_PROC_FS and MODULES. In both
cases the functions directly used in conjunction with these
defines evaluate to nops. But especially in the case of
CONFIG_PROC_FS helper functions are defined that are, in the case
where the define is undefined :), left unused but still compiled
into the object file. The best example of this I have found to
date is the advansys driver which (roughly) goes from 110K to 80K
if CONFIG_PROC_FS is undefined (and the appropriate #ifdefs are
placed).

The obvious way to fix this would be to place the necessary
#ifdefs in the code but ifdefs are not nice and some think they
should be avoided at all cost.

My question now is: What is the Right Thing to do? (I realise that
there probably are many opinions on this subject but perhaps some
of the people with high karma might make their feelings known?)

I see three scenarios for placing/not placing #ifdefs:

1) The code is purely functions that evaluate to noops if the
define is not set. E.g., create_proc_entry. An #ifdef here would
basically only underscore what the careful reader would already
know :)

2) The code is basically like 1) but with some conditionals/
support code around. drivers/block/cpqarray.c::ida_procinit would
be an example (yes, I know that it already has an ifdef around
it).

3) The code in question is variable definitions only used when
the define is valid. (Still in cpqarray.c) proc_array would be an
example of this.

4) The code in question is a support function for code like 1)
and 2) but not itself surrounded by #ifdefs. An example would be
arc_prt_board_devices from drivers/scsi/advansys.c.

OK, so that was four :)

My feeling would be that 1) and 2) would not require ifdefs. 3)
is trickier but for cleanliness sake we might forego the ifdefs
and endure the compiler warnings (but I dont like those!) and 4)
would be a good case to put in #ifdefs.

Comments? Was this even intelligible?

--
Regards,
        Rasmus(rasmus@jaquet.dk)

It is wonderful to be here in the great state of Chicago.
-Former U.S. Vice-President Dan Quayle
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
