Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156610AbPLNLKL>; Tue, 14 Dec 1999 06:10:11 -0500
Received: by vger.rutgers.edu id <S156609AbPLNLDk>; Tue, 14 Dec 1999 06:03:40 -0500
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:42235 "EHLO oxmail.ox.ac.uk") by vger.rutgers.edu with ESMTP id <S156681AbPLNK7E>; Tue, 14 Dec 1999 05:59:04 -0500
Subject: Compartments (was Re: Per-Processor Data Page)
In-Reply-To: <199912140102.RAA09517@griffin.engr.sgi.com> from Scott Lurndal at "Dec 13, 1999 05:02:30 pm"
To: linux-kernel@vger.rutgers.edu
Date: Tue, 14 Dec 1999 10:59:01 +0000 (GMT)
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
X-Mailer: ELM [version 2.4ME+ PL54 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E11xpfZ-0006ti-00@sable.ox.ac.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

Scott Lurndal writes:
> ------ From Andi Kleen <ak@suse.de>
> 
> > On Thu, Dec 09, 1999 at 04:32:31PM -0600, Bret Indrelee wrote:
> > > If processes can get a highly accurate time value from some sort of global
> > > clock, it allows a pair of processes to create a covert channel for passing
> > > information. The less secure program monitors the time variences of the
> > > high-security program in order to get information about or from them.
> 
> > Linux simply does not support real compartmentation and probably never will.
> 
> While the first part is true, I really hope that the latter isn't.

I'm in the middle of adding Mandatory Access Control support to the
kernel and it's turning out to be mostly easier than I expected. I'm
concentrating on the integrity/compartment side (Biba model) and
leaving out sensitivity (Bell-LaPadula) labels since they're not
really useful in real life. Currently, tasks, sockets, network
packets and filesystems (super blocks) are marked with a mac_label
(grade, compartment, flags) triple and tasks can only see other tasks
and filesystems with appropriate labels. IP firewall rules can mark
incoming packets with labels and drop outgoing packets if the sending
task isn't allowed access to a label.

One useful configuration allows one Linux box to behave like many
virtual machines, each can only see their own filesystems (and any
system-wide filesystems--it's more flexible than chroot) and their own
tasks (so "ps auxw" only shows up their compartment/virtual machine
and they can't communicate directly with other compartments).
A pseudo-filesystem lets you redirect, say, /etc to different
subdirectories based on the task's label so that each compartment
sees its own /etc/*.conf etc. The overall admin, though, can see all
process and all filesystems which makes it much easier to look after
(apply updates etc.) than lots of smaller machines. I'm currently
fighting my way through all the marvellously flexible routing code so
that you can set outgoing routes based on mac_labels: then even with
INADDR_ANY sockets you'll get outgoing data stamped with the
compartment's own IP address (or you can allocate different labels
differing access to networks/bandwidth/etc.

The basics work but I've just done a rewrite (I'd called it "Linux
zones" but I've made the labels match the Biba model properly now that
so it was worth calling it mac_label instead). Patches and stuff will
be available on the
    http://users.ox.ac.uk/~mbeattie/linux-kernel.html
page soonish. You can get real-life useful practical configurations
without having mac labels at the file level but I may add that too
eventually (except that needs hacking of real current filesystems
rather than a transparent add-on).

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
