Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQJaGKi>; Tue, 31 Oct 2000 01:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbQJaGK2>; Tue, 31 Oct 2000 01:10:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2579 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129057AbQJaGKT>; Tue, 31 Oct 2000 01:10:19 -0500
Date: Mon, 30 Oct 2000 22:10:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@linuxcare.com.au>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 
In-Reply-To: <20001031045711.3886A81FA@halfway.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10010302153040.6519-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Rusty Russell wrote:
> 
> Quiet suggestion:

If I understood the GNU make syntax correctly (which is possibly not the
case - GNU make is possibly the only example of "overkill" to rival GNU
emacs), this looks like a reasonable idea.

However, it also looks like much more of a change than to change the
fairly boiler-plate OX_OBJS etc stuff in new-style makefiles. And quite
frankly, I don't see how it would get the multi-part object file case
right, but that's probably because you left off some of the black magic
required to do that (and it's not as if the current Makefile magic doesn't
do black magic for that already).

Why do I really care? We actually have the same issue in the SCSI driver
directory, where the ordering restraints are much stricter than for USB.
Now that case has fewer export-objs, and that case isn't a part of a
multi-list, but I really want to have something that works for both these
cases with minimal (and reasonably straightforward) surgery.

In fact, I suspect the SCSI rules would work almost as-is. They break
ordering for the export-objs entry, but that looks fixable. This is how it
looks now:

	# Extract lists of the multi-part drivers.
	# The 'int-*' lists are the intermediate files used to build the multi's.
	multi-y         := $(filter $(list-multi), $(obj-y))
	multi-m         := $(filter $(list-multi), $(obj-m))
	int-y           := $(sort $(foreach m, $(multi-y), $($(basename $(m))-objs)))
	int-m           := $(sort $(foreach m, $(multi-m), $($(basename $(m))-objs)))

	# Files that are both resident and modular: remove from modular.
	obj-m           := $(filter-out $(obj-y), $(obj-m))
	int-m           := $(filter-out $(int-y), $(int-m))

	O_OBJS          := $(filter-out $(export-objs), $(obj-y))
	OX_OBJS         := $(filter     $(export-objs), $(obj-y))
	M_OBJS          := $(sort $(filter-out  $(export-objs), $(obj-m)))
	MX_OBJS         := $(sort $(filter      $(export-objs), $(obj-m)))
	MI_OBJS         := $(sort $(filter-out  $(export-objs), $(int-m)))
	MIX_OBJS        := $(sort $(filter      $(export-objs), $(int-m)))

In the above, the only problem is OX_OBJS and the breaking of ordering of
"export-objs" (which SCSI doesn't care about, unlike USB, partly because
SCSI uses the old-fashioned "every export in a special file" approach).
And it looks like even THAT could be fixed by changing it to

	O_OBJS		:= $(obj-y)
	OX_OBJS		:=
	MIX_OBJS	:= $(sort $(filter	$(export-objs), $(int-m) $(obj-y)))

(and the others are unchanged) which looks like it would handle it all
correctly. Basically, the changes would mean that the export-objs subset
of $(obj-y) would stay in O_OBJS instead of moving to OX_OBJS, but
additionally those objs would also be added to MIX_OBJS.

Would this satisfy everybody? It _is_ complex enough that I guess it
easily rates having it's own rule-file and be included by new-style
Makefiles instead of being copied over and over again..

Rusty's suggestion would mean having to actually change all the lists
themselves, which at this point sounds a bit dangerous.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
