Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315791AbSEDJDR>; Sat, 4 May 2002 05:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSEDJDQ>; Sat, 4 May 2002 05:03:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:61200 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315791AbSEDJDP>;
	Sat, 4 May 2002 05:03:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Sat, 04 May 2002 16:44:08 +1000."
             <15571.33592.365558.215598@argo.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 19:03:02 +1000
Message-ID: <23023.1020502982@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002 16:44:08 +1000 (EST), 
Paul Mackerras <paulus@samba.org> wrote:
>Keith Owens writes:
>> be reused is horribly error prone.  And it would take just as long as
>> rebuilding the global makefile from scratch.
>
>I seriously doubt that last statement.  Building the global makefile
>takes about 20 seconds on the box I compile on.  On a kernel tree
>without object files I can read all the files in the kernel tree in
>about 0.8 seconds, and I can calculate an md5sum of every file in 3.2
>seconds.  I can do an md5sum of all the Makefile.in's in 0.1 seconds.
>This is with pp_makefile* compiled with -O2 -DNDEBUG=1.

Those times do not look right, the build times look too long.  On a
Pentium III 700MHz with 1GiB ram, I get

# cd $KBUILD_SRCTREE_000
# time md5sum -c ../sums > /dev/null
7.10user 0.73system 0:07.82elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
# time make -f $KBUILD_SRCTREE_000/Makefile-2.5 phase4
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/kgcc' CPP='/usr/bin/kgcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
4.31user 0.15system 0:04.45elapsed 100%CPU (0text+0data 0max)k
  phase 2 (convert all Makefile.in files)
1.66user 0.03system 0:01.69elapsed 99%CPU (0text+0data 0max)k
  phase 3 (evaluate selections)
1.10user 0.91system 0:01.91elapsed 104%CPU (0text+0data 0max)k
  phase 4 (integrity checks, write global makefile)
10.02user 0.08system 0:10.10elapsed 99%CPU (0text+0data 0max)k
17.40user 1.40system 0:18.59elapsed 101%CPU (0avgtext+0avgdata 0maxresident)k

Doing all the setup work on this machine takes ~2.5 times as long as
md5sum, but it does more work than just md5sum.  phase4 also does all
the integrity checks, cleans up dead files, checks for timestamp skew,
runs the config dependency chains etc.

What would it require to optimize for the "no config/makefile change"?

md5sums alone are not enough, people touch source or header files, even
config options and expect objects to be rebuilt, timestamps are
required as well.  A change to the KBUILD_SRCTREE_nnn environment
variables adds or deletes entire trees.  So phase1 is still required,
to find all the files in all the trees and get their current
timestamps.  "Optimizing" will not save any time there, kbuild always
needs current timestamp data.

That gives 7.8 seconds to check the md5sums compared to 14.2 seconds to

* convert the Makefile.in files (using the latest values for the kbuild
  variables from the environment and the command line)
* evaluate the selections (which can be overridden on the command line)
* run the config dependency chains
* do all the integrity checks
* handle special cases like asking for a .i or .s file on the command
  line
* write the global makefile.

Not a huge difference, especially considering it is doing more than a
simple checksum.

It is the config dependency, integrity checks and special case
processing that take the bulk of phase4, writing the makefile is a
small percentage.  "Optimizing" could only save a small amount of time
and would require extra code and time to work out if I could save any
time.

When I build the pp_ programs with -O2 -NDEBUG=1, the times go down to

  phase 1 (find all inputs)
2.78user 0.11system 0:02.88elapsed 100%CPU (0text+0data 0max)k
  phase 2 (convert all Makefile.in files)
1.09user 0.02system 0:01.10elapsed 100%CPU (0text+0data 0max)k
  phase 3 (evaluate selections)
1.04user 0.97system 0:01.89elapsed 106%CPU (0text+0data 0max)k
  phase 4 (integrity checks, write global makefile)
6.10user 0.10system 0:06.19elapsed 100%CPU (0text+0data 0max)k
11.35user 1.38system 0:12.53elapsed 101%CPU (0avgtext+0avgdata 0maxresident)k

Not bad for something that is doing a lot more work than a simple
checksum, 1.6 times as long as md5sum for complete kbuild support.  As
it stands kbuild 2.5 provides additional features, is far more accurate
and is 30% faster than kbuild 2.4.  I even provide an option for
bypassing everything and going straight to the build step, that option
is also faster and more accurate than the kbuild 2.4 equivalent.

If all of that is not enough justification for replacing the old
system, then shaving a few seconds off the startup code is not going to
make any difference.

