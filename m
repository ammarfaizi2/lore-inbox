Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSFUTlL>; Fri, 21 Jun 2002 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316773AbSFUTlK>; Fri, 21 Jun 2002 15:41:10 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:8404 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316770AbSFUTlJ>; Fri, 21 Jun 2002 15:41:09 -0400
Message-Id: <200206211941.g5LJfAI154858@pimout3-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: zaimi@pegasus.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
Date: Fri, 21 Jun 2002 09:42:44 -0400
X-Mailer: KMail [version 1.3.1]
References: <Pine.GSO.4.44.0206201600470.9816-100000@pegasus.rutgers.edu>
In-Reply-To: <Pine.GSO.4.44.0206201600470.9816-100000@pegasus.rutgers.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 04:19 pm, zaimi@pegasus.rutgers.edu wrote:
> Thanks for the responses especially Rob. I was trying to find previous
> threads about this and could not find them. Agreed, swsusp is a step
> further to that goal; the way that memory is saved though may not make it
> necessarily easier, at least in the current state of swsusp.

Several people have mentioned process migration in clusters.  Jessee Pollard 
says he expects to see checkpointing of arbitrary user processes working this 
fall, and then Nick LeRoy replied to him about the condor project, which 
apparently does something similar in user space...

http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.2/1017.html

http://www.cs.wisc.edu/condor/

You might also want to look at the crash dump code (and the multithreaded 
crash dump patch floating around in the 2.5 to-do list) as another starting 
point, since A) it's flushing user info for a single process into a file in a 
well-known format, B) such a file can already be loaded back in and at least 
somewhat resumed by the Gnu Debugger (gdb).

> As you were mentioning, the processes information needs
> to be summarised and saved in such a way that the new kernel can pick up
> and construct its own queues of processes independent on the differences
> between the kernels being swapped.

Which isn't impossible, I remember migrating WWIV message base files from 
version to version a dozen years ago.  Good old brute force did the job: 
new->field=old->field;  There's almost certainly a more elegant way to do it, 
but brute force has the advantage that we know it could be made to work...

As for maintaining a "convert 2.4.36->2.4.37" executable goes, (to be 
released with each kernel version,) the fact there's a patch file to take the 
kernel's source from version to version should help a LOT with figuring out 
what structures got touched and what exactly needs to be converted.  Still 
needs a human maintainer, though.  It's also bound to lag the kernel releases 
a bit, but that's not such a bad thing...

> Well, this does touch the idea of having migrating processes from one
> machine to others in a network. In fact, I dont understand why is it so
> hard to reparent a process. If it can be reparented within a machine, then
> it can migrate to other machines as well, no?

A process can touch zillions of arbitrary resources, which may not BE there 
on the other machine.  If you have an mmap into 
"/usr/thingy/rutabega/arbitrary/database/filename.fred" and on the remote 
machine fred is there, the contents are identical, but the directory 
"arbitrary" is owned by the wrong user so you don't have permission to 
descend into it (or the /etc/passwd file gives the same username a different 
pid/assigns that pid to a different username...)

Or how about fifos: are they all there on the resume?  Fifos are kind of 
brain damaged so it's hard to re-use them, so "create, two connects, delete" 
is a pretty common strategy.  The program has the initial setup and 
negotiation code, but not And can the processes at each end be restored, in 
pairs, such that they still communicate with each other properly?  What about 
a process talking to a one-to-many server like X11 or apache or some such?  
Freezing the server to go with your client is kind of overkill, eh?  Gotta 
draw a line somewhere if you're going to cut out a running process and stick 
it in an envelope...

The easy answer is have the restore fail easily and verbosely, and have 
attempt 0.1 only able to freeze and restore a fairly small subset of 
processes (like the distributed.net client and equivalents that sit in their 
corner twiddling their thumbs really fast), and then add on as you need more. 
 The wonderful world of shared library version skew is not something 
checkpointing code should really HAVE to deal with, just fail if the 
environment isn't pretty darn spotless and hand these problems over to the 
"migration" utility.

If you're restoring back on top of the same set of mounted filesystems, and 
you're only doing so once (freeze processes, reboot to new kernel, thaw 
processes, discard checkpoint files), your problem gets much simpler.  Still, 
did your reboot wipe out stuff in /tmp that running processes need?  (Hey, if 
it's on shmfs and you didn't save it...)

Also, restoring one of these frozen processes has a certain amount of 
security implications, doesn't it?  All well and good to say "well the 
process's file belongs to user 'barbie', and the saved uid matches, so load 
it back in", except that what if it was originally an suid executable so it 
could bind to some resource and then drop privelidges?  How do you know some 
user trying to attack the system didn't edit a frozen process file?  You 
pretty much have to cryptographically sign the files to allow non-root users 
to load them back in (public key cryptography, not md5sum.  Gotta be a secret 
key or a user, with your source code, could replicate the process of creating 
one of these suckers with arbitrary contents in userspace...)

Again, less of a problem in a "trusted" environment, but this is unix we're 
talking about, and unless you're makng an embedded system to put in a toaster 
it will probably be attached to the internet.  And another easy answer is 
"don't do that then", or "only allow root to restore the suckers" (that last 
one probably has to be the case anyway, make an suid executable to verify the 
save files via a gpg signature if you REALLY want users to be able to do 
this, I.E. shove this problem into user space... :)

> Rob, I am going to the Newark campus FYI, and have interests in some AI
> stuff.
> Thanks again,

I'm just trying to give you some idea how much work you're in for.  Then 
again, Linus is on record as saying that if he knew how much work the kernel 
would turn out to be, he probably never would have started it... :)

> Adi

Rob
