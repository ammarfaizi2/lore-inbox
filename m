Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289022AbSAZFPo>; Sat, 26 Jan 2002 00:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289024AbSAZFPY>; Sat, 26 Jan 2002 00:15:24 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:3459 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289022AbSAZFPM>; Sat, 26 Jan 2002 00:15:12 -0500
Date: Sat, 26 Jan 2002 05:11:19 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dan Maas <dmaas@dcine.com>, Andreas Schwab <schwab@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020126051119.B5996@kushida.apsleyroad.org>
In-Reply-To: <20020126034559.G5730@kushida.apsleyroad.org> <Pine.GSO.4.21.0201252327001.27397-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0201252327001.27397-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jan 25, 2002 at 11:33:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> Most likely it says very bad things about getcwd() implementation in Perl
> compared to sys_getcwd() in the kernel.  The latter just walks the chain
> of dentries copying ->d_name.name into the buffer.  The former... my guess
> would be stat ".", open "..", readdir from it, stat every damn object in
> there until you find one with the right ->st_ino, put its name as the
> last component and repeat the whole thing until you reach root...

I better correct my statement.  Just had a look at the old Perl script
in question.

I was originally using 'use Cwd; getcwd()'.  That was really slow and it
does exactly what Alex says.  Even though you don't need to call stat()
on each entry: the readdir system call returns the inode numbers for all
directories that aren't mount points, but Perl doesn't give that
information to its libraries (for the sake of portability).

Then I switched to 'use POSIX; getcwd()'.  That was faster, but still
distressingly slow (i.e. noticable in human terms).  POSIX::getcwd()
forks and execs to call /bin/pwd, and is quite fast.  But 'use POSIX' is
quite slow.  Shame really, because the implementation is in a shared
library; it's just the 'use POSIX' importing part that's slow.

Then I tried `/bin/pwd' myself since the POSIX function uses it.  That
was pretty fast and I was impressed with Linux for being that fast.  Of
course it is still 1.7 million cycles which is not brilliant, but it was
faster than I'd expected for a pipe/fork/exec.

Finally I just did the getcwd() system call myself.  Used a hard-coded
system call number, because reading it from a header file was slow.
Linus was right about startup times in this case.

enjoy,
-- Jamie
