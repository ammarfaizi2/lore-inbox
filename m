Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160216-215>; Tue, 16 Mar 1999 22:44:05 -0500
Received: by vger.rutgers.edu id <160175-215>; Tue, 16 Mar 1999 22:43:53 -0500
Received: from zen.Stanford.EDU ([171.65.16.116]:21786 "HELO zen.stanford.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <160085-212>; Tue, 16 Mar 1999 22:41:29 -0500
Message-ID: <19990316194144.45898@zen.stanford.edu>
Date: Tue, 16 Mar 1999 19:41:44 -0800
From: David Hinds <dhinds@zen.stanford.edu>
To: linux-kernel@vger.rutgers.edu
Subject: Ideas for abstracting driver IO from bus implementation?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.76e
Sender: owner-linux-kernel@vger.rutgers.edu

This is sort-of a PCMCIA specific issue at the moment, but could be
thought of as a more general kernel driver issue, so I thought I'd put
it out for comments, to see if anyone [Alan??] has any clever thoughts.

On a normal x86 (or PowerPC) laptop, PCMCIA bridges are designed to
map cards directly into the host IO and memory spaces at arbitrary
addresses, and a stock ISA or PCI driver generally doesn't care if it
is talking to a normal device or a device on a PCMCIA card.  However,
there are a number of PCMCIA architectures in which cards are not
accessed through the same abstractions used to access other types of
system devices.  For example, there are SCSI-to-PCMCIA adapters,
parallel-to-PCMCIA adapters, SBUS-to-PCMCIA adapters, and various
specialized bridge chips that sit on the system bus but do not allow
PCMCIA devices to be arbitrarily configured to mimic the corresponding
type of directly connected system device.

In the official PCMCIA way of doing things, say in the Windows world,
these each require a dedicated Card Services stack, and client drivers
that know about how a particular bridging system works.  There is some
support for an abstraction layer for memory cards, but that's all, and
I don't know if it is even implemented by any existing software.

So, I'm wondering how to deal with this in some clean fashion.  I've
had a whole bunch of inquiries about this in the past month or two,
for all sorts of unusual hardware setups (ARM embedded designs, Sparc
platform, Amiga, etc).  And I think it would be nice to handle all of
these cases.

My thought is to have a socket driver publish a set of entry points
for primitive IO operations: effectively, replacements for readw,
writew, inb, outb, and friends.  These would be passed out to any
client driver for that socket.  Solaris has an equivalent sort of
abstraction layer, where you make a DDI call to indirectly access any
device register.  I'm wondering if such an abstraction layer would be
of any use for other types of Linux drivers, and if so, how I should
design my API to make it as broadly useful as possible.

One option is to do it mostly through macro trickery, and make all the
usual Linux calls map to other things behind the scenes.  That's not
completely trivial because different sockets in the same system might
have different access methods.  I'd like to have the option of
compiling a driver for native or indirect access methods from the same
source code, but this probably means replacing inb(port) with, say,
read_io_byte(sock_handle, port) (or sock_handle->read_io_byte(port),
or io_handle->read_byte(port)), and having a header file that could
collapse this to inb() based on a configuration option.

So I guess my questions are, do people see uses for this sort of thing
for non-PCMCIA drivers?  Should I try to implement something like a
stripped-down Solaris DDI layer that isn't PCMCIA-centric, or should I
not worry about generality?  In either case, this will cause trouble
with code sharing between PCMCIA and regular Linux drivers: for the
scheme to work, various standard Linux drivers would need to be
retooled to support indirect device accesses.  I guess the 8390 driver
has already had something like this hacked in for a special case, so
there's some precedent for it.  Any comments?

-- Dave Hinds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
