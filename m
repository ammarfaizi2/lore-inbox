Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272401AbRIFDmu>; Wed, 5 Sep 2001 23:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272399AbRIFDml>; Wed, 5 Sep 2001 23:42:41 -0400
Received: from foghorn.airs.com ([63.201.54.26]:43280 "HELO foghorn.airs.com")
	by vger.kernel.org with SMTP id <S272423AbRIFDmb>;
	Wed, 5 Sep 2001 23:42:31 -0400
Mail-Followup-To: bug-binutils@gnu.org,
  linux-kernel@vger.kernel.org,
  gcc-bugs@gcc.gnu.org,
  jonathan.bright@onebox.com,
  aron@cs.rice.edu,
  znmeb@aracnet.com
From: Ian Lance Taylor <ian@zembu.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: <bug-binutils@gnu.org>, <linux-kernel@vger.kernel.org>,
        <gcc-bugs@gcc.gnu.org>, <jonathan.bright@onebox.com>,
        <aron@cs.rice.edu>
Subject: Re: gprof, threads and forks
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEKODKAA.znmeb@aracnet.com>
Date: 05 Sep 2001 20:42:44 -0700
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEKODKAA.znmeb@aracnet.com>
Message-ID: <siu1yhvvbf.fsf@daffy.airs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. Edward Borasky" <znmeb@aracnet.com> writes:

> It's rare that I cross-post to this many lists, but
> 
> 1. I blew a week trying to track this little monster down, and
> 2. It isn't at all clear to me where the appropriate fixes and documentation
> changes need to be applied.
> 
> So here goes:
> 
> If you have an executable compiled with *gcc* using the "-pg" option, it is
> supposed to generate a "gmon.out" file, which you can later process with the
> *binutils* utility "gprof" to produce a profile. All this magic works just
> dandy for a single threaded executable, but apparently child threads and
> child processes created with "fork" don't get their execution time counted.
> See the following links for the gory details:
> 
> http://sources.redhat.com/ml/bug-binutils/2001-q3/msg00090.html
> 
> http://uwsg.iu.edu/hypermail/linux/kernel/0101.3/1516.html
> 
> The second link implies that it's possible to fix this at the *kernel*
> level. So my question to all of you is, "what's the best way to get this
> fixed?" I need to profile a multi-threaded executable and personally don't
> care about the "fork" case, but I'm sure there are others who would care
> about forks and not threads.

Fork is easy enough to handle, at least on GNU/Linux.  If you set the
environment variable GMON_OUT_PREFIX, glibc will automatically append
the process ID when writing the gmon.out file.  If you then also do
this in the child after calling fork:
		extern void _start (void), etext (void);
		monstartup ((u_long) &_start, (u_long) &etext);
you will a set of ${GMON_OUT_PREFIX}.pid files, one for the parent and
one for each child.

As far as I know, none of this is documented, though that might just
mean that I missed it.  I think glibc ought to document
GMON_OUT_PREFIX and the right way to call monstartup.

In principle threading could be handled the same way, but glibc would
need to cooperate when generating the profiling output file so that
each thread doesn't overwrite the same file.

Ian
