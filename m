Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTDHAWa (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbTDHAWY (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:22:24 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:24766
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263820AbTDHAMe (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 20:12:34 -0400
Message-ID: <3E92168D.6060700@redhat.com>
Date: Mon, 07 Apr 2003 17:23:41 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030406
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
References: <3E90746A.2010300@redhat.com> <b6scsk$18b$1@penguin.transmeta.com>
In-Reply-To: <b6scsk$18b$1@penguin.transmeta.com>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> If you really really think you need this (and not just do it because
> some random idiot-customer doesn't understand security), then I would
> suggest you add a O_CANLINK flag to open, and require that that flag is
> set in the file descriptor.

Nobody would be stupid enough to let me work on customer issues related
to the kernel.  The requests come in through glibc users.

Anyway, there are two or three ways I can see:

- - add safelink() instead of flink()

   int safelink (const char *oldname, int fd, const char *newname)

  As Jakub explained, this syscall would check that the file referenced
  by oldname really corresponds to fd before making the link.

  If you need an example, take the linker.  The linking can take a long
  time.  The temporary output file has to be created early and there is
  sometimes enough time before the linking finished for even a human
  to figure out the temporary file's name and replace the file.  If then
  the final file is installed as root (since the linking succeeds)
  you'll have problems.

  There is of course the possibility that one compares the ino/dev of
  the temporary file and the file after the link (or rename, btw) but
  this means the wrong output file existed for some time and all that
  is left to do is to remove the file which might be critical if the
  system depends on the file always being present.


- - add the O_CANLINK.  Sure it's possible.  But see the next variant


- - add an open() flag to create files which are not present in the
  filesystem (Hurd has something like this).  open() would get as the
  filename the name of a directory.  Such a feature can be
  used for all kinds of temporary files:

  + files which never need names, i.e., don't have to be accessed
    through the filesystem; the advantage is that there would never
    be stray files in the filesystem if the program forgets to clean
    them up

  + temp files which have to be completed first before renamed.  Here
    flink() and frename() would introduce the name in the filesystem.
    This is obviously useful in many many places, e.g., the linker
    scenario.  There is no way to attack the linker while it is doing
    its work since the output file isn't visible until it is installed
    under the final name.

  Maybe the O_CANLINK flag idea is also necessary for this, don't know.
  The O_ANONYMOUS flag might include setting O_CANLINK.


I'm certainly not qualified to say whether this is viable or not.  The
safelink() idea certainly is implementable, just 3-4 more lines on top
of the flink() patch.  But this wouldn't be necessary if we'd have the
more complete support with the new open() flag(s).  Al mentioned to me
some problems with network filesystem in the context of flink().  So
somebody who understands these issues might want to comment.  It seems
there is some interest in this.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+khaN2ijCOnn/RHQRAm09AJ9Fin1Js+Qla9vVSRzawSASl0dCNACfdoU1
VxrcNGyC06OxRiQZ0+reo0k=
=PosI
-----END PGP SIGNATURE-----

