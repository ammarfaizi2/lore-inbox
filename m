Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267849AbTBJNq4>; Mon, 10 Feb 2003 08:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbTBJNq4>; Mon, 10 Feb 2003 08:46:56 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:62482 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267849AbTBJNqy>;
	Mon, 10 Feb 2003 08:46:54 -0500
Message-ID: <3E47AF93.8030807@mvista.com>
Date: Mon, 10 Feb 2003 07:56:35 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com>
In-Reply-To: <20030210174243.B11250@in.ibm.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Suparna Bhattacharya wrote:

|>I am still digesting the crash dump code I have seen, but as far as I
|>can tell what it does is to compress the contents of memory, for
|>writing out later.
|
|
|Yes. It actually saves a formatted compressed dump in memory,
|and later writes it out to disk as is.

MCL coredump does funny memory shuffling, too.  It compresses
pages into a contiguous area of memory, and as it runs into output
pages that it has not yet compressed, it moves them into pages that
it has already compressed and keeps track of where everything is
located.  That a lot of the complexity of MCL coredump.

|
|>To handle the hard cases for kexec on panic I would recommend the
|>following.
|>
|>- Place the recovery code in a reserved area of memory that the normal
|>  kernel will not touch, and actually run the code there.  This
|>  trivially solves the DMA problem because the hardware is not DMA'ing
|>
|>- Setup the kernel that does the recovery so that the pool of memory
|>  it uses for dynamic allocations is also in the reserved area of
|>  memory so that it is equally free of DMA dangers.
|>
|>- Modify the kernel that does the recovery so it can be run at
|>  different physical address from the standard kernel, so it will not
|>  need to be moved out of the reserved area of memory.
|
|
|Are you trying to address the possibility that DMA is overwriting
|memory we are using in the recovery code, due to a runaway driver
|or other code passing a wrong memory address to a device (e.g. in
|a corrupted command area) ? I'm wondering if just reserving
|an area of memory would help. As long as the address is visible/
|accessible by the device (i.e. unless we have the h/w support to
|apply protection at that level), can we really be safe in those
|weird or rare cases ?  Disabling the bus-master sounds like a
|more dependable option for that (via device shutdown or reboot
|notifiers as suitable) if it can be done.
|
|Placing the recovery code in a safe reserved area (that the
|running kernel may not know about or may be protected),
|may reduce the possibility of the panic/buggy kernel overwriting
|it, but will it help the DMA case ?

Eric, I'd suggest you go with your previous advice and start simple
and go one step at a time.  You will never be able to build a system
that can perfectly protect from anything that can go wrong.  So start
with the simple case that covers 95% of the problems.  Build a
system first that lets the driver quiesce the chip, then think about
moving those functions and their data into special protected memory.

I've actually never seen a core dump with the MCL core dump that
had a memory corruption so bad it couldn't take the dump.

|
|
|While the patch I'd posted has been designed so that ideally
|it should be possible to preserve everything, I'm still not
|certain if the compression we get is good enough for all cases
|(e.g a heavily loaded system with lots of non-redundant data)
|-- we really need to play around with the implementation and
|tune it. Secondly, for a large memory system, it could take a
|bit of time to compress all pages, and we might just want to
|dump potentially more relevant data (e.g kernel pages) for
|some kind of problems. It was easy enough to do this with some
|simple heuristics like dumping inuse pages which are nonlru.

~From my experience, data is memory is very compressible
(moreso than the average text file).  Perhaps some pieces are
not very compressible, but in the whole they are.  Plus you don't
have to have that much compressions for this to work, just enough
to give you memory to boot the next kernel and save off a dump.
And speed is probably not a big issue here, since this should be a
very rare occurrance.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+R6+OmUvlb4BhfF4RAhW7AJ9ZUCbWk6TBLvbwYunyKMN0dAxf+QCff21/
WoOfzq4NrjYv3E0bOYhwSD8=
=T9Y9
-----END PGP SIGNATURE-----


