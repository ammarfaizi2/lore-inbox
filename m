Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSEDKfL>; Sat, 4 May 2002 06:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSEDKfK>; Sat, 4 May 2002 06:35:10 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:56473 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312381AbSEDKfJ>;
	Sat, 4 May 2002 06:35:09 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15571.47377.913702.639488@argo.ozlabs.ibm.com>
Date: Sat, 4 May 2002 20:33:53 +1000 (EST)
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <23023.1020502982@ocs3.intra.ocs.com.au>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> Those times do not look right, the build times look too long.  On a
> Pentium III 700MHz with 1GiB ram, I get

I made a mistake, the 20 seconds was without -O2 -DNDEBUG=1, with
those options it was 12 seconds (dual 1GHz G4 powermac with 1GB of
RAM).

> md5sums alone are not enough, people touch source or header files, even

Surely the dependencies on the dates of source and header files are
handled by make itself?  The global makefile wouldn't change just
because I touch a source file would it?

> config options and expect objects to be rebuilt, timestamps are
> required as well.  A change to the KBUILD_SRCTREE_nnn environment
> variables adds or deletes entire trees.  So phase1 is still required,
> to find all the files in all the trees and get their current

Finding all the files in a tree and stating them doesn't take very
long:

bash-2.05a$ touch foo
bash-2.05a$ time find . -newer foo

real	0m0.100s
user	0m0.020s
sys	0m0.090s

So that is not why phase1 takes a couple of seconds.

> That gives 7.8 seconds to check the md5sums compared to 14.2 seconds to
> 
> * convert the Makefile.in files (using the latest values for the kbuild
>   variables from the environment and the command line)
> * evaluate the selections (which can be overridden on the command line)
> * run the config dependency chains
> * do all the integrity checks
> * handle special cases like asking for a .i or .s file on the command
>   line
> * write the global makefile.
> 
> Not a huge difference, especially considering it is doing more than a
> simple checksum.

But when have you known a kernel hacker to be satisfied with just
"faster than the previous system", as distinct from "as fast as I can
reasonably make it go"? ;-)

> It is the config dependency, integrity checks and special case
> processing that take the bulk of phase4, writing the makefile is a
> small percentage.  "Optimizing" could only save a small amount of time
> and would require extra code and time to work out if I could save any
> time.

Actually, from the profiles I have done it looks to me like it is
spending the bulk of the time inside mdbm.  So presumably what is
taking up most of the time is fetching and storing the persistent data
needed for the processing, not the actual processing itself.

> Not bad for something that is doing a lot more work than a simple
> checksum, 1.6 times as long as md5sum for complete kbuild support.  As
> it stands kbuild 2.5 provides additional features, is far more accurate
> and is 30% faster than kbuild 2.4.  I even provide an option for
> bypassing everything and going straight to the build step, that option
> is also faster and more accurate than the kbuild 2.4 equivalent.
> 
> If all of that is not enough justification for replacing the old
> system, then shaving a few seconds off the startup code is not going to
> make any difference.

Don't get me wrong, I think it's great to have all the advantages that
kbuild-2.5 brings.  However, I also think that those seconds spent in
the startup code will tend to have a disproportionate effect on
people's perceptions of the new system.  I know you have already spent
a lot of effort on this, but I want to get in and have a look myself
to see if I can spot anything that could be improved there.

Paul.
