Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWCHEC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWCHEC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWCHEC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:02:56 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:9874 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750863AbWCHECz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:02:55 -0500
Message-ID: <440E5746.7070003@comcast.net>
Date: Tue, 07 Mar 2006 23:02:14 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sound userspace drivers (fishing for insight)
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This isn't really a serious question, but I just encountered some stuff
about userspace sound drivers for Linux and was like O_o so now I'm
curious as to the design aspect here.  I can't think of a good way to do
it (where 'good' means something more than 'ugly hack').

So here's my input on this, and if anyone cares to enlighten me maybe
you can bounce some responses back.  It'll be a good learning experience
for me.

 - General transport and context switches

In general, transporting sound data in and out of kernel space is a
horrid thought.  Consider the latencies, which all real-time audio
people will quickly get angry about.  Write sound; context switch; sound
in driver; context switch back.  This over and over?  Now we all know
better than that.

So my first impulse would be using the generic kernel-user transport
facilities like NETLNK.  But at a glance this doesn't seem to do
anything for me; this would still be writing to a socket, which causes a
syscall into kernel space.  In short, you're stuck with context switches.

On the up-side, in any scheme the user space program has to shift data
into the kernel; with alsa it's written to a /proc interface, which
causes a context switch into kernel space AFAIK because it calls write()
to an fd.  Still, we're wasting time copying to another process' memory
space.


 - Ring-1, Ring-2

I have heard that these mysterious privilege levels allow bitmaps to
give direct hardware access, i.e. to PCI devices.  Through this mystical
magic, a driver could directly access a sound card.  This opens up new
possibilities. . or does it?

First off how the heck complex is userspace PCI control, and what gains
do you really get?  Won't every syscall() become a sudden context
switch?  Or (as I suspect and would like to find out) does the "overhead
of context switching" mainly imply the copy_from_user() function and the
process of rewriting a lot of PTEs into a new privilege level (kernel
instead of user)?

Assuming that you can implement direct hardware access or at least
direct access to memory to avoid the context switch (in the manner I'm
assuming the latency comes from), this may become actually faster.
Still you're copying memory from Ring-3 (user) to Ring-1 or Ring-2, so
there are no gains here.


 - Shared mapping?

If my assumption on how this works is correct, then copy_from_user() is
difficult because you have to walk the range of passed VM addresses and
change/copy affected PTEs.  The old PTEs become non-writable
(copy-on-write trigger) and the new PTEs are created (non-writable CoW
and of course Ring-3 privilege) for the kernel.

This assumption brings an interesting thought:  what about a shared
mapping?  An area of memory writable by userspace and readable by the
kernel?  This seems silly.  Under the assumptions I've made, this would
still require CoWing existing PTEs or flat out copying things over.
Obviously I lack understanding of the problem; none of this solves
anything, and this is typical overhead whenever you allocate memory,
even from userspace.




So we come to an interesting thought:  I've found yet another
interesting bit of kernel design that I don't understand, and am curious
of.  I understand basic memory management concepts and preemptive
multitasking just because of pestering the LKML from time to time; might
as well go for a little more and see if you guys bite again.  Any takers?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRA5XQws1xW0HCTEFAQLr7g//Yqnj5hIbANQR/SsiirkLhYAcM7DC3lGe
vi50fu7YZSwaDNJ/NKWjHVmiuI1UWLehEe6n8BWHYR9tq0JzNzwwpEPUWUxIv7tp
TsKKWR4uP8YYbFoFoNo8zK/kJQiV0ynVvuBCVCYm3OUqBi8hIqKut0GgyZc4qo7M
aOmq3mFlw5zITfYV2pYVq9ttTU2ZJ36pXU4gJJi0+V5KVO51ZuAXDxDB6oaLewq7
csayDae/yy9Aene44fSSuO+bfS6JPNq9uTXS42v0bcYkZm+DppSTaZcPetj1cMcU
qM1d/0jh6bQwVpDRb7A7xumP+TfQM7J8/5rR2TFTpgc63qA1Fyzu5qd/hJ9xz28A
pum/36ZbF/fiLR5qwMB3tlwN9z6f1MrEmEzOKtCap/Mq3IklSnyc429mpTs8smjZ
WzbRaLU2rNxgL2KFDOZvhrfN0PP4nu+DDSauTmYdaSHfdNQ0tlvZAapq8SMQy5LU
VAY3ZDEMP4qAIGMfXTRR49JAuM0OLWpV/fXeE9Uwv0KIyomfw/TJvW20O2vblN06
Ryj4HGwELeaZpc+D8E6eWXSllX/16qp5zgXAFnNgvBAXfRnaKPzSnhNOdEozNhxM
oFk3Kf9PoyEn3fqRFXJi+f9o02VvDAEY/6EOwsALUOAWADqbW+D/ku7MKEMt7pFT
Jo/dyODrxfA=
=YKVj
-----END PGP SIGNATURE-----

