Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130364AbQKSCzG>; Sat, 18 Nov 2000 21:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbQKSCy4>; Sat, 18 Nov 2000 21:54:56 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:14858 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130364AbQKSCyn>;
	Sat, 18 Nov 2000 21:54:43 -0500
Date: Sun, 19 Nov 2000 03:24:39 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
Message-ID: <20001119032439.H23033@almesberger.net>
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001111171158.B17692@progenylinux.com> <m1bsvmcb4z.fsf@frodo.biederman.org> <20001114154953.E8753@almesberger.net> <m1vgtn7rfw.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vgtn7rfw.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Nov 16, 2000 at 10:33:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Well there is that.  Somehow implementing scatter/gather from 
> a user space process seemed like a potential mess, and extra work.

Did you look at kiobufs ? I think they may just have the right
functionality. I always wanted bootimg to be able to memory-map things
to reduce memory pressure, and it seems now all the ingredients are in
place. Your file-based approach could probably use brw_kiovec.

> I need to find time soon and write up all of the file format details
> in an RFC like the GRUB multiboot spec.  Possibly even submit it
> to the IETF as an RFC for compatible booting and multiple platforms.

Hmm, if you succeed in selling the format as an integral part of your
network boot protocol, this may even work ;-)

> This is the big reason I'm not in favor
> of the bootimg approach, that doesn't define anything.

Oh, it does - but the policy is implemented in user space. And, of
course, it's rather simple. But I'm a little confused with your
UBE. It only seems to copy the e820 information, so you still seem
to rely on e.g. the SMP tables the BIOS stores in memory. Also, I
don't quite see where you're using the saved information. What am
I missing ?

However, parameter passing like UBE may solve the following two
potential problems:

 - kernel 1 copies tables marked by "magic" numbers in memory,
   then boots kernel 2, which trips over the copy
 - kernel 1 doesn't know about a table and damages it, then boots
   kernel 2, which recognizes the table, and trips over it

But I think we don't need to copy or even convert the entire tables for
this. After all, any OS that boots on i386 already knows how to parse
the BIOS-provided tables, so I think it's better to directly re-use
this code than to invent a new format. A few flags or maybe a short
list should be sufficient for the problems I've described above.

> My primary non-linux target are the BSD's, and various experimental
> OS's.  And in those cases why go to the pain of dropping out of
> protected mode if you are going to just load back into it again.

Yep, I fully agree.

> Compiling the code in it's own file and putting it in it's own section
> of the kernel for size would probably do it though.

This is exactly what bootimg does :)

> Being sure the code is PIC is a little tricky though.

Yes, for now I cheat and depend on gcc to generate code that just
happens to be PIC.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
