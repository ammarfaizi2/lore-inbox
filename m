Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSEDLtd>; Sat, 4 May 2002 07:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSEDLtd>; Sat, 4 May 2002 07:49:33 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:15633 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312529AbSEDLtb>;
	Sat, 4 May 2002 07:49:31 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Sat, 04 May 2002 20:33:53 +1000."
             <15571.47377.913702.639488@argo.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 21:49:21 +1000
Message-ID: <23739.1020512961@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002 20:33:53 +1000 (EST), 
Paul Mackerras <paulus@samba.org> wrote:
>Keith Owens writes:
>> md5sums alone are not enough, people touch source or header files, even
>
>Surely the dependencies on the dates of source and header files are
>handled by make itself?  The global makefile wouldn't change just
>because I touch a source file would it?

phase1 gathers timestamps to use for _all_ kbuild processing, not just
generating the global makefile.  NFS timestamp skew between edit and
build systems can make timestamps go backwards.  Edit a file, decide
you made a mistake, restore from a backup or a repository and the
timestamp goes backwards.

make does not detect timestamps going backwards, it is a common source
of build error, especially over NFS.  kbuild 2.5 detects _all_
timestamp changes, forwards and backwards, using the data gathered in
phase1.  phase1 must always run, you cannot optimize it away.

>Finding all the files in a tree and stating them doesn't take very
>long:
>So that is not why phase1 takes a couple of seconds.

It is the database processing, see scripts/pp_makefile1.c.  Besides
gathering timestamps, there are 6 passes over the kbuild database in
phase1 to get the data ready for the rest of kbuild.

The comments on each phase are only summaries.  Every phase does more
than you think, please look at the code before assuming that you know
everything about the kbuild processing.

>But when have you known a kernel hacker to be satisfied with just
>"faster than the previous system", as distinct from "as fast as I can
>reasonably make it go"? ;-)

make NO_MAKEFILE_GEN=1.  Bypass everything and go straight to the
build.  No integrity checks of course.

>> It is the config dependency, integrity checks and special case
>> processing that take the bulk of phase4, writing the makefile is a
>> small percentage.  "Optimizing" could only save a small amount of time
>> and would require extra code and time to work out if I could save any
>> time.
>
>Actually, from the profiles I have done it looks to me like it is
>spending the bulk of the time inside mdbm.  So presumably what is
>taking up most of the time is fetching and storing the persistent data
>needed for the processing, not the actual processing itself.

I have not done any tuning on mdbm.  The source came from Larry McVoy
and I do not want to change it.

>> kbuild 2.5 provides additional features, is far more accurate
>> and is 30% faster than kbuild 2.4.  I even provide an option for
>> bypassing everything and going straight to the build step, that option
>> is also faster and more accurate than the kbuild 2.4 equivalent.
>> 
>> If all of that is not enough justification for replacing the old
>> system, then shaving a few seconds off the startup code is not going to
>> make any difference.
>
>Don't get me wrong, I think it's great to have all the advantages that
>kbuild-2.5 brings.  However, I also think that those seconds spent in
>the startup code will tend to have a disproportionate effect on
>people's perceptions of the new system.  I know you have already spent
>a lot of effort on this, but I want to get in and have a look myself
>to see if I can spot anything that could be improved there.

Code can always be improved.  At the moment kbuild 2.5 is stable and
ready to go into the kernel.  This is not the time to redo the
pre-processing programs or to try tuning the database code.  I am only
tracking kernel changes and doing bug fixes to kbuild 2.5 until it has
been accepted into the kernel.  Once it is in the kernel I have a list
of enhancements to be done, one change at a time.

