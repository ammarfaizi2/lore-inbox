Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312344AbSDJHeI>; Wed, 10 Apr 2002 03:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312525AbSDJHeH>; Wed, 10 Apr 2002 03:34:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27406 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312344AbSDJHeG>; Wed, 10 Apr 2002 03:34:06 -0400
Message-Id: <200204100731.g3A7VkX05193@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: 2.4.16+perl+noatime: bug?
Date: Wed, 10 Apr 2002 10:34:59 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Weird problem: perl can't read file's atime if fs is mounted noatime!
Was found during Mozilla 0.9.9 build.
Verified to be related to mount -o noatime (i.e. it works fine on
normally mounted fs)! Can you imagine this?

See http://bugzilla.mozilla.org/show_bug.cgi?id=136123
for full story. Abridged version:

Was getting perl errors in config/make-jars.pl:
===============================================
        unlink $destPath;       # in case we had a symlink on unix
        copy($file, $destPath) || die "copy($file, $destPath) failed: $!";

        # fix the mod date so we don't jar everything (is this faster than just jarring everything?)
======> #vda: my $atime = stat($file)->atime || die $!;
        #vda: my $mtime = stat($file)->mtime || die $!;
        #vda: utime($atime, $mtime, $destPath);

        return 1;
    }
    return 0;
}
=========
Commented offending lines (those with #vda: above).
This helped.

[snip]

------- Additional Comment #4 From Vlasenko Denis 2002-04-09 01:05 -------
>I faintly recall a kernel option to disable atime

Yes! This is it. I mount all my filesystems -o noatime.
But how can this be related? Build process should never pay
attention to atime. Only mtime/ctime is important, right?

Nevertheless, I'll enable atime update and report back.
(this means tomorrow, I'm playing with 0.9.9 at home, not here)

[snip]

------- Additional Comment #13 From Vlasenko Denis 2002-04-09 21:57 -------
>you're saying that you had no trouble whatsoever running
>the mozilla build or just the test perl script?

Only test script. Have to compile 2.5.7 at home to test mozilla.

>I see nothing to indicate that the
>usage of atime is wrong or non-standard.

atime is standard, thats ok, but using atime in build process
is _logically_ wrong. Remember make? It compares *mtime* of
source and target files in order to decide which target needs
rebuilding! atime is _irrelevant_.

>FWIW, I mounted my build partition using noatime and I was
>not able to reproduce the problem.  I'm running RH's 2.4.9-31.

I tried that at home:
noatime mount + fresh configure+make, got an error.
normal mount + fresh configure+make, everything is ok.
(2.4.16 kernel, had no opportunity to try 2.5.7 -
was compiling KDE 3.0 at the same time and having some sleep)

Tried to look into perl sources (there are a handful of stat*
files) but since I don't know perl, I was scared by ugly syntax
and ran away. YMMV. :-)
--
vda
