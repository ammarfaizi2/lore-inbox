Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbQKSK6k>; Sun, 19 Nov 2000 05:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbQKSK6a>; Sun, 19 Nov 2000 05:58:30 -0500
Received: from slc154.modem.xmission.com ([166.70.9.154]:28170 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129705AbQKSK6N>; Sun, 19 Nov 2000 05:58:13 -0500
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001111171158.B17692@progenylinux.com> <m1bsvmcb4z.fsf@frodo.biederman.org> <20001114154953.E8753@almesberger.net> <m1vgtn7rfw.fsf@frodo.biederman.org> <20001119032439.H23033@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2000 00:20:38 -0700
In-Reply-To: Werner Almesberger's message of "Sun, 19 Nov 2000 03:24:39 +0100"
Message-ID: <m1wve04ed5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <Werner.Almesberger@epfl.ch> writes:

> Eric W. Biederman wrote:
> > Well there is that.  Somehow implementing scatter/gather from 
> > a user space process seemed like a potential mess, and extra work.
> 
> Did you look at kiobufs ? I think they may just have the right
> functionality. I always wanted bootimg to be able to memory-map things
> to reduce memory pressure, and it seems now all the ingredients are in
> place. Your file-based approach could probably use brw_kiovec.

When I looked kiobufs seemed to do a good gather but not a good scatter.
The code wasn't trivially reusable, and the structures had a lot
of overhead.

> 
> > I need to find time soon and write up all of the file format details
> > in an RFC like the GRUB multiboot spec.  Possibly even submit it
> > to the IETF as an RFC for compatible booting and multiple platforms.
> 
> Hmm, if you succeed in selling the format as an integral part of your
> network boot protocol, this may even work ;-)

Well I'd sell it to promote interoperability.  What I'm doing protocol
wise has been RFC sanctions for years.  It's just that every vendor
invents their own format.  So interoperability is a problem.

> 
> > This is the big reason I'm not in favor
> > of the bootimg approach, that doesn't define anything.
> 
> Oh, it does - but the policy is implemented in user space. And, of
> course, it's rather simple. But I'm a little confused with your
> UBE. It only seems to copy the e820 information, so you still seem
> to rely on e.g. the SMP tables the BIOS stores in memory. Also, I
> don't quite see where you're using the saved information. What am
> I missing ?

Defining all of the parameters for the UBE is a separate issue.
It comes next in a couple of weeks.

The rebooting is done the rest is not yet.

As far as where I use the information is used, look in do_kexec.
Right after kimage_get_chunk which figures out where it is safe
to put the information.  

> However, parameter passing like UBE may solve the following two
> potential problems:
> 
>  - kernel 1 copies tables marked by "magic" numbers in memory,
>    then boots kernel 2, which trips over the copy
>  - kernel 1 doesn't know about a table and damages it, then boots
>    kernel 2, which recognizes the table, and trips over it
> 
> But I think we don't need to copy or even convert the entire tables for
> this. After all, any OS that boots on i386 already knows how to parse
> the BIOS-provided tables, so I think it's better to directly re-use
> this code than to invent a new format. A few flags or maybe a short
> list should be sufficient for the problems I've described above.

I agree writing the code to understand the table may be a significant
issue.  On the other hand I still think it is worth a look, being
able to unify option parsing for multiple platforms is not a small
gain, nor is getting out from short sighted vendor half standards.

Besides which most tables seem to contain a lot of information that
is probeable.  Which just makes them a waste of BIOS space, and
sources of bugs.

> > My primary non-linux target are the BSD's, and various experimental
> > OS's.  And in those cases why go to the pain of dropping out of
> > protected mode if you are going to just load back into it again.
> 
> Yep, I fully agree.
> 
> > Compiling the code in it's own file and putting it in it's own section
> > of the kernel for size would probably do it though.
> 
> This is exactly what bootimg does :)
> 
> > Being sure the code is PIC is a little tricky though.
> 
> Yes, for now I cheat and depend on gcc to generate code that just
> happens to be PIC.

Hmm. I wonder how hard it would be to add -fPIC to the compilation
line for that file.  But I'm not certain that would do what I want
in this instance...

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
