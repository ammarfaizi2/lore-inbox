Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbQJaBtl>; Mon, 30 Oct 2000 20:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129768AbQJaBtc>; Mon, 30 Oct 2000 20:49:32 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:51728 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129730AbQJaBtW>;
	Mon, 30 Oct 2000 20:49:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@ns.caldera.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 16:47:15 -0800."
             <Pine.LNX.4.10.10010301643300.1789-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 12:49:12 +1100
Message-ID: <13675.972956952@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 16:47:15 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>Actually, I think I have an even simpler solution, which is to change the
>newstyle rule to something very simple:
>
>	# Translate to Rules.make lists.
>
>	O_OBJS          := $(obj-y)
>	M_OBJS          := $(obj-m)
>	MIX_OBJS        := $(export-objs)

It makes kbuild variables in USB mean something different from the rest
of the kernel.  Unless you plan to change all Makefiles (code freeze,
what code freeze?).

make modules depends on MIX_OBJS, with the above change make modules
now depends on kernel objects.  Can be fixed in Rules.make, but only if
every Makefile is changed (code freeze, what code freeze?).

You will compile all export objects, whether they are configured or
not.  The "obvious" fix does not work.

	MIX_OBJS        := $(filter $(export-objs),$(obj-y) $(obj-m))

export_objs contains usb.o, obj-y contains usb_core.o, it does not
contain usb.o.  Multi lists in obj-y and obj-m need to be expanded
while preserving the required link order (which is where we came in).

It still does not document the only real link order constraint in USB.
The almost complete lack of documentation on which link orders are
required and which are historical is extremely annoying and _must_ be
fixed, instead we just propagate the problem.

If you cannot do sort then you cannot (easily) remove duplicate objects
from the lists, resulting in make warning messages.  Doing an explicit
link first, list last then sort the rest also fixes the problem of
duplicate objects.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
