Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLWQDE>; Sat, 23 Dec 2000 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLWQCz>; Sat, 23 Dec 2000 11:02:55 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:39338 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129183AbQLWQCo>; Sat, 23 Dec 2000 11:02:44 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 23 Dec 2000 07:32:17 -0800
Message-Id: <200012231532.HAA31091@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: fork/wait race in 2.4.0-pre?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I reported this problem a few months ago in bug-glibc and
did not get any response, although that is not unexpected since it is
unclear where the problem is.  So that bug report and this report
will probably serve just to chronicle the problem in case anybody
sees something similar.

	Anyhow, the problem is that somehow fork or vfork (makes no
difference) will return an apparently valid pid  and then the child
process will disappear.  Calling wait or waitpid will return errno 10
(ECHILD, "no child process"), and will continue to return errno 10
if wait or waitpid is called again.  I got lucky with some strategically
placed printf's at a point where this problem sometimes appears and
was able to determine that, at least when wait() is called, the
signal handler for SIGCLD (17) is SIG_IGN (1), so it seems less
likely that some userland facility is reaping the process, especially
since one of the places where this problem occurs is a very simple
program that does little more than fork and wait.

	This usually happens during the "configure" phase of our
build process, which is right after about 2.5GB of sources
have been extracted from CVS to a directory tree, so there may
be some IO congestion that could lead to unusual timing relationships,
leading to unsual results from race conditions.  Also, the problem
started occurring occasionally when the machine in question got
an 866MHz CPU, and started occuring more often when it got a 1GHz
CPU.  So, more instructions per time slice seems to be a relevant
factor.

	Anyhow, I know this is a very slippery bug and it may
be months before it is tracked down either here or elsewhere, but
I thought it would be helpful to at least document it for the
linux-kernel archives.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
