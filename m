Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTH1TNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbTH1TNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:13:11 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:18854
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264231AbTH1TM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:12:59 -0400
Message-ID: <3F4E5426.6050401@redhat.com>
Date: Thu, 28 Aug 2003 12:12:38 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ->pid in filesystem code
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I looked briefly through the filesystem code.  That's all definitely out
of my league so I don't try to make a final call or change something.
Anyway, this is what I found, the owners of that code should probably
look at it.  Filesystems not mentioned are fine.  I've ignored uses of
- ->pid in print statements; it's ok, any maybe preferable, there.


cifs:

  apparently uses current->pid to keep track of locking.  This might
  mean that the current implementation is actually getting things very
  wrong, at least from the Unix semantics.  Locking happens on process
  basis.  I count 11 uses of ->pid, all suspicious.  Using this
  filesystem with NPTL seems to be risky in the moment.

coda:

  One use in upcall.c.  Seems fishy if it is assumed that the code can
  be executed by any process.  If it is only meant to be used by the
  userlevel part of CODA then it should be fine.  Might be good to
  add a comment, though.

intermezzo:

  Wow, don't know where to start.  A gazillion uses of ->pid.  Some are
  print statements but there are others where the value is assigned to
  elements of some internal data structures.  I think I would strongly
  suggest to avoid this filesystem when using NPTL until it is clear
  that there are no issues.

lockd:

  In clntproc.c the ->pid value is used to generate some kind of token.
  Again, the thread can go away and take the PID with it while the
  process remains.  Don't know whether this is a problem here.

nfs:

  Should be ok.  Only mentioned in nfsXproc.c where the PID of the
  server is returned to the client.

umsdos:

  The pid seems to be used for some kind of locking.  Might be that
  using ->pid is correct here.  In that case it needs comments.


There rest seems to be fine.  Including ext2/3 which use the ->pid value
for coloring.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/TlQm2ijCOnn/RHQRAmyWAKCBC+cPr3ebdoeiqpusTZPn6+3cVwCffBLS
6hWR3C2+8NKck8FxAAlZun8=
=9UyG
-----END PGP SIGNATURE-----

