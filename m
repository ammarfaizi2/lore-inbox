Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWBFEGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWBFEGR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWBFEGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:06:17 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:42978 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750940AbWBFEGQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:06:16 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 6 Feb 2006 14:02:53 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041954.22484.nigel@suspend2.net> <20060204192924.GC3909@elf.ucw.cz>
In-Reply-To: <20060204192924.GC3909@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200602061402.54486.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sunday 05 February 2006 05:29, Pavel Machek wrote:
> Complexity in userspace: ungood.
>
> Complexity in kernel: doubleplusungood.
>
> It is not that hard to understand :-).

Heh. you'll soon be submitting patches to move interrupt handling and 
scheduling to userspace then?

Seriously, though, thanks for the opportunity to explain how Suspend2 works 
and show that it's not complex, and simpler than what you're going to end 
up with if you continue down the userspace track and seek to match 
Suspend2 in functionaltiy (apples for apples would be the fairest 
comparison, so that's what I'm aiming for here).

I've downloaded Rafael's userspace files and the latest mm, and used them 
to figure out how userspace swsusp works as you have it at the moment. 
>From there, I've extended the analogy to try to include the extra 
functionality you're talking about implementing. Feel free to correct 
misunderstandings or wrong assumptions :)

a. Freezing processes, freeing memory and preparing the image.

Freezing processes maps nice and cleanly to userspace because the kernel 
still does all the work. Extra ioctls to freeze and thaw other processes 
are all that's needed. There is no serious possibility of moving more of 
the work of freezing processes to userspace.

Freeing memory and preparing the image is significantly simpler for swsusp 
at the moment because it doesn't support swap files, and doesn't worry so 
much about being reliable under memory and process load. If this was to 
change, swsusp would probably want more of the modifications to the 
freezer that suspend2 includes, particularly the ability to thaw just the 
kernel threads. When userspace is being memory hungry and/or processor 
intensive, being able to thaw just the kernel threads helps a lot, because  
we can then put pressure on the VM without worry about deadlocking against 
frozen filesystems or racing against userspace processes that are grabbing 
memory and/or processor while we're trying to meet our constraints on 
memory and storage.

c. Compression and encryption.

The current implementation has no direct support for compressing, 
encrypting or otherwise transforming the data to be written. This could 
never-the-less be achieved by writing to a device that was configured 
using the standard support, and reconfiguring access to the 
compressed/encrypted devices before reading the image at resume time. 
Adding support for compressing and/or encrypting an image from within 
uswsusp would presumably require adding dependencies upon existing 
libraries or using cryptoapi functions via ioctls or such like. Making 
such support optional and configurable would require further modification. 
Using userspace libraries for compression and encryption would increase 
the complexity of configuring uswsusp for a developer (extra packages to 
download/configure/install), and create greater potential for support 
issues for developers and distributions (uswusp gets blamed for any 
problems in those libraries but can't do anything to fix them!).

If any flexibility was going to be allowed in methods of encrypting and 
compressing the image, a standardised interface would need to be 
developed. This interface would almost certainly be approximately 
equivalent 

Back in the days of Suspend1, or maybe before, I had compression code 
inlined in the read/write-a-page loop. Based on my experience in having 
implemented the modular architecture, changing the compression method from 
gzip to lzf and then to cryptoapi support, I can't see how you'd want to 
to hardwire this. (Besides, with the modular architecture, CONFIG_SUSPEND2 
+ !CONFIG_CRYPTOAPI is really simple - we just don't compile in the 
compression and encryption modules).

d. Storage of the image.

As it currently stands, the interface between userspace and the kernel for 
uswsusp looks clean and simple. This is mainly, however, because it only 
supports writing to swap, and strictly synchronously.

If you were going to match the functionality in suspend2, you would be 
looking at adding support for (a) asynchronous I/O, (b) for ordinary 
files, (c) for multiple swap devices (d) for swapfiles and (e) for the 
varying blocksizes of filesystems. I assume uswsusp won't currently work 
with swapfiles (as opposed to swap partitions) as it stands because I see 
a check for !S_ISBLK(resume_device) in suspend.c::main.

The simplest way I can see to achieve parity of functionality would be to 
treat all storage as a lists of sectors on bdevs, and simply have 
different storage allocation routines depending on where you want to 
storage the image. To do that, you'd want to use the current swap 
allocation procedure, with the ioctls you have already exported to enable 
this being controlled from userspace. You'd also want to utilise bmap from 
userspace for getting the sector numbers of storage. Finally, you'd want 
to use bio functions to submit the I/O, and a kernel routine to handle the 
completion. Then you'd need some mechanism to wait for or check for 
completion of I/O on a particular page or all pages. Of course you might 
decide not to do async I/O because it's too complex, but then you'd take 
the performance hit you currently have, and we wouldn't have an apples 
with apples comparison.

This is another place where the modular architecture in Suspend2 helps. The 
I/O modules have the same basic read/write routines as the 
compression/encryption support, so compression, encryption and I/O are 
just strung together in a pipeline fashion. The core doesn't care whether 
it's sending data directly to the I/O module, or first to a compressor or 
encryptor. It just asks for the first module in the pipe, and sends each 
page in the pageset to it one at a time. That module then sends data to 
the next when its output buffer fills, and so on down the chain. At the 
tail, the writer makes a copy of its input buffer and submits I/O on the 
copy asynchronously. Simple!

e. Atomic copy/restore.

This is currently achieved in kernelspace, as it is for Suspend2. It would 
seem to be extremely unlikely that this could be implemented in userspace. 
Both implementations do roughly the same things, invoking the driver 
model, disabling interrupts and doing the copy. Suspend2 has 
DEBUG_PAGEALLOC support that adds some extra code, but the complexity 
factor is minimal. (It should however be tested more frequently - IIRC I 
recently got a report that it's currently broken).

f. User tuning and configuration.

uswsusp doesn't have much support for tuning and configuration at the 
moment. The resume device is set from swsusp.h in the userspace program 
and can be overridden using a command line option to the userspace 
program. The default image size is hardwired in the userspace 
swsusp.h.

Suspend2 offers far more support for tuning and configuration via a proc 
interface. Suspend2 implements an additional layer on top of the base proc 
routines, which might be useful elsewhere in the kernel. This layer allows 
additional entries to be created at very little cost, and avoid 
duplicating code for each entry. This is an area of additional complexity 
that Suspend2 has at the moment, but similar additions would be helpful in 
the userspace program for the same reasons.

g. Writing a full image of memory.

Not possible in uswsusp right now. If the algorithm of Suspend2 was used 
(wherein LRU pages are saved separately), support would need to be added 
for marking which LRU pages should be in the atomic copy (because they 
belong to the freezing process), and for reading and writing the sets of 
pages separately.

h. Powering down.

uswsusp currently supports using the sys_reboot restart and power off 
functions. There is no support for entering the ACPI S4 state, or for 
suspending-to-ram instead of powering off. Adding these would require 
additional ioctls and kernelspace functions, and the capability of 
configuring which powerdown method to use.

i. Status display.

The intention to implement this in userspace has been mentioned a number of 
times. It is certainly possible, and is already done in Suspend2 in 
userspace. It used to be done in kernel space, but was moved to userspace 
because of objections by kernel developers. Moving the code to userspace 
has created extra hassles for users (they now have to download extra 
libraries to use the splashscreen, which were not required with the 
bootsplash patch, and need to check whether an update to the userui code 
is required when updating the kernel). It has also created additional 
complexity in that the code for doing the userui in the kernel didn't 
really go away - it was just replaced by code to communicate with 
userspace and get it to do the work. On the positive side, though, it is 
less code to have in the kernel, and having a font renderer in the kernel 
was definitely not ideal!).

The main danger for uswsusp here would be avoiding the death of the whole 
process if the userui bit hits a snag. In Suspend2, the kernel happily 
continues if it can't start the userui program or talk to it. In uswsusp, 
some extra measures might need to be taken to avoid this problem.

j. Summary.

At their cores, Suspend2 and uswsusp work in basically the same way. They 
make an atomic copy of some/all portions of memory, saving the CPU state 
in the process, and write that image to disk, doing the inverse at resume 
time. The variations come in the methods by which meta-data is stored in 
memory, by which the image is prepared, and in which it is stored on disk. 

Suspend2 is more complex than uswsusp, but only because it has more 
functionality that uswsusp. If uswsusp were to match the current Suspend2 
for functionality, it would require at least a slightly greater degree of 
complexity, due to the extra logic and code for implementing the 
kernelspace/userspace interface. Interaction between kernespace and 
userspace might be a little simpler than the current suspend2 code due to 
the difference between using ioctls and using a netlink socket (but, of 
course, Suspend2 code be modified to use ioctls too).

uswsusp currently moves none of the real functionality to userspace, but 
rather just the controlling logic. Longer term, it might move the 
compression and encryption to userspace if userspace libraries are used 
for that, and eye candy might be implemented there too. In reality, 
though, the bulk of the work (freezing, atomic copy, implementation of the 
I/O) continues to be done in kernelspace. Doing suspend to disk in 
userspace would thus be a bit of a misnomer.

It seems most likely that uswsusp would never match the current Suspend2 in 
terms of functionality, or would take a very long time to get there. 
Support for implementing a full image of memory will likely never happen, 
and asynchronous I/O would be unlikely too. If the flexibility in how to 
compress/encrypt and write the image that Suspend2 currently has were to 
be implemented in uswsusp, it would require a modular architecture along 
the lines of the one that has been rejected in the Modules support thread. 

In short, the only way you would avoid making uswsusp at least as complex 
as Suspend2 would be by failing to implement the same level of 
functionality. That would of course be acceptable, but it should then be 
remembered whenever you're making comparisons between the two 
implementations, particularly in terms of metrics such as lines of code.

Hope this helps us progress in our discussions.

Regards,

Nigel
-- 
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode
