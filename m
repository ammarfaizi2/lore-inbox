Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUBQGyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUBQGyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:54:18 -0500
Received: from dp.samba.org ([66.70.73.150]:1423 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266094AbUBQGyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:54:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16433.47753.192288.493315@samba.org>
Date: Tue, 17 Feb 2004 17:54:01 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > Kernel-level case insensitivity is a total disaster, and your "very
 > painful and potentially quite complex" assertion is the understatement of
 > the year. The thing is, you can't sanely do dentry caching, since the case
 > insensitivity has to be per-open or at least per-process (you MUST NOT be
 > case-insensitive in a POSIX process).

right, and the patches to add this support to Linux that I have been
involved with in the past have been per-process. You are right that it
is messy, but it is not *horribly* messy. In fact I'd say it is no
worse than many of the other things we already have in the kernel,
although it certainly is much harder than sticking to the "bag of
bytes" interpretation of filenames. I just think that in this case the
simple solution is also wrong.

 > So the only way to do case-insensitive names is to do all lookups very 
 > slowly.

I don't agree with this at all. I agree that the worst-case will get
worse, but I see absolutely no reason why the average case will get
sigificantly worse and I think that the worst case will be rare.

In fact, John Bonesio did a patch to the 2.4 kernel with XFS that
implemened per-process case-insensitivity. It's been a long time since
I played with that patch, but I certainly don't recall any significant
slowdowns. The patch was messy, but it wasn't grossly
inefficient. (that patch was just a proof of concept, and just used
strcasecmp() instead of doing a proper UTF-8 case-insensitive compare,
so there will be some amount of additional cost to adding that).

>From memory, the patch added new classes of dentries to the current
"+ve" and "-ve" dentries. It added concepts like a "-ve
case-insensitive" dentry and a "-ve case-sensitive" dentry. It
certainly adds more code in trying to deal with these variants, but I
see no reason why it should be significantly computationally less
efficient.

 > I'm willing to bet that WNT opens files a hell of a lot slower 
 > than Linux does, and one big portion of that is exactly the fact that 
 > Linux can do a really good job with the dentry cache.

Anyone have any lmbench filesystem numbers for w2k3? The only windows
boxes I use are in vmware sessions, so running performance tests
myself is pretty pointless.

 > And that _depends_ on a well-defined and unique filename setup (by
 > changing the hashing function and compare function, a filesystem can do a
 > limited kind of case-insensitivity right now in Linux, but then it will
 > have to be not only fairly slow, but also case-insensitive for _everybody_
 > which is unacceptable in a mixed POSIX/samba environment).

right, and thats why bones made it per-process in his patch. It was
set using a process personality bit, which really wasn't ideal (that
was one of my contributions to the patch) but it did work.

 > In other words, just forget the whole notion. The only set people who have
 > any reason at _all_ to want it is the samba team, and we can solve the 
 > samba-specific problems other ways.

Nope, its not just Samba, though perhaps Samba is the app that cares
the most about the actual performance. The other obvious people who
care are wine and anyone porting an application from windows. Also,
the problem isn't just one of performance, its also hard to make it
raceless from userspace.

I also think that if the choice were given then some linux distros
(the likes of Lindows comes to mind) would choose to run all processes
case-insensitive. These sorts of distros are aiming at the sorts of
users that would want everything to be case-insensitive.

 > Just take that as a simple fact - case insensitivity in the kernel is such 
 > a horribly bad idea, that you really shouldn't go there.

I'm yet to be convinced :)

 >  - MOST name lookups are likely results of some kind of "readdir()" 
 >    lookup, and tend to have the case right in the first place. So that 
 >    should go fast. Maybe Tridge has some statistics on this one?

ok, the first thing you need to understand about case-insensitivity on
a case-sensitive system is that the hardest thing to do is prove that
a file doesn't exist. File operations on non-existant files are *very*
common. If you can come up with a solution that allows me to prove
that a file doesn't exist in any case combination then we will be most
of the way there.

That immediately throws out most of the "why don't you just use a
cache" arguments that everyone seems to come up with. We *do* use a
cache that primes the "most likely" filename code, its just that a
cache is almost useless when you are trying to prove that a file
definately doesn't exist.

 >  - samba probably has certain pretty well-defined special patterns for 
 >    what it wants to do with a filename, do you probably don't need a 
 >    generic "everything that takes a filename should be case-insensitive", 
 >    and it would be acceptable to have a few _very_ specific system calls.

yes, if we had a single function that took a pathname and gave us
either -1/ENOENT or the pathname of a file that matches
case-insensitively then that would be great. Then again, if we had
such a function then it would be really easy to use that function in
the VFS to make the Linux case-insensitive on a per-process basis.

So lets imagine we have such a function like this:

  int ci_normalize(char *path);

Lets assume it takes a pathname and returns either -1/ENOENT or
modifies the pathname in place (totally ignoring the fact that the
length of the pathname could change, and that the "char *" is really a
"const char *" - pedants go home).

now lets build a ci_unlink() on top of that:

   int ci_unlink(char *path)
   {
	if (task_is_case_sensitive(current)) {
		return unlink(path);
	}
	if (ci_normalize(path) == -1) {
		return -1;
	}
	return unlink(path);
   }

The problem is the negative dentries. If you do the above then
case-sensitive processes will be fast, but case-insensitive processes
will effectively be running without the negative dcache, so unlink()
on paths that don't exist will be slow each and every time. That's why
doing this with any sort of decent efficiency needs dcache changes.

btw, I already know that Al is completely and utterly opposed to
putting any case-insensitivity in the dcache (I think the phrase "over
my dead body" was mentioned), so I know that I'm fighting an uphill
battle here, but I like trying every now and again to see if I can
make any progress.

 > With those assumptions out of the way, we could think of an interface that
 > exports some partial functionality of the "lookup_path()" code the kernel
 > as a special system call. In particular, something that takes an input
 > pathname, and is able to stop at any point of the name when a lookup
 > fails.
 > So some variation of the interface
 > 
 > 	int magic_open(
....

how would this interact with the negative dcache entries? That is the
key.

 > I suspect we can do case-insensitive names faster than WNT even with a 
 > fairly complex user-mode interface. Just because _not_ having them in the 
 > kernel allows us to have much faster default behaviour.

on this I completely disagree. Any solution that doesn't cope with
case insensitive properties of negative dentries is just going to
start filling the dcache with lots of useless entries (case
combinations) or effectively not end up using the dcache at
all. Either way its a big loss compared to making the dcache know
about case insensitivity properly.

Cheers, Tridge

PS: ahh, what timing, someone just posted a request to the rsync list
asking for case-insensitivity in rsync.
