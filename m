Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbSALCFB>; Fri, 11 Jan 2002 21:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbSALCEm>; Fri, 11 Jan 2002 21:04:42 -0500
Received: from mons.uio.no ([129.240.130.14]:739 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S280126AbSALCEh>;
	Fri, 11 Jan 2002 21:04:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15423.39344.864108.741338@charged.uio.no>
Date: Sat, 12 Jan 2002 03:04:32 +0100
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] some strangeness (at least) with linux-2.4.17-NFS_ALL patch
In-Reply-To: <20020111191744.7A9CE1426@shrek.lisa.de>
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de>
	<15422.65459.871735.203004@charged.uio.no>
	<20020111191744.7A9CE1426@shrek.lisa.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
     >> What server is this?
     > Oups, sorry:
     > Linux shrek 2.4.13-ac7 #6 SMP Son Dez 2 20:02:04 CET 2001 i686 unknown
     > (on patches, IIRC)

And the knfsd server daemons (not the user-space 'unfsd')?

     > Shouldn't the client invalidate the dcache entry some time?
     > Now, 5 hours later, the dcache entry isn't invalidated, yet.

5 hours??? Unless you have set some crazy value for acdirmax, then it
should indeed have been revalidated under normal circumstances.

The default is for all attribute/dcache entries to time out at least
once every 60 seconds. That is what happens on my test setup at least.

     > I think, this is a thinko.

It shouldn't be. There might be a bug lingering somewhere, but
revalidation *is* normally supposed to occur.

Are you sure that you didn't mess up the fixups with 2.4.18-pre1? That
might explain things, since you would be messing with
nfs_refresh_inode. What you need to do against 2.4.18-pre1 is first to
revert the patch linux-2.4.17-fattr.dif. After that you should be able
to apply linux-2.4.17-NFS_ALL.dif directly without any rejections...

     > Please try this:

     > shrek is the server, elfe the client /raid is shared (reiserfs,
     > no raid), /tmp isn't

<snip>

     > Eingabe-/Ausgabefehler insgesamt 1 drwxr-xr-x 2 root root 55
     > 11. Jan 20:08 ./ drwxr-xr-x 9 root root 218 11. Jan 20:06 ../

     > Pretty simple. Can you reproduce this?

Nope. With /mnt/trondmy == NFS share, /tmp == local:

[trondmy@fyspc-epf03 gnurr]$ pwd
/mnt/trondmy/gnurr
[trondmy@fyspc-epf03 gnurr]$ touch /tmp/huhu
[trondmy@fyspc-epf03 gnurr]$ ln -s /tmp/huhu
[trondmy@fyspc-epf03 gnurr]$ ls -al
totalt 8
drwxr-xr-x    2 trondmy  trondmy      4096 jan 12 02:43 .
drwxr-xr-x   41 trondmy  trondmy      4096 jan 12 02:42 ..
lrwxrwxrwx    1 trondmy  trondmy         9 jan 12 02:43 huhu ->
/tmp/huhu
[trondmy@fyspc-epf03 gnurr]$ echo "huhu" > /tmp/huhu
[trondmy@fyspc-epf03 gnurr]$ ls -al
totalt 8
drwxr-xr-x    2 trondmy  trondmy      4096 jan 12 02:43 .
drwxr-xr-x   41 trondmy  trondmy      4096 jan 12 02:42 ..
lrwxrwxrwx    1 trondmy  trondmy         9 jan 12 02:43 huhu ->
/tmp/huhu
[trondmy@fyspc-epf03 gnurr]$ cat huhu
huhu
[trondmy@fyspc-epf03 gnurr]$ rm huhu
[trondmy@fyspc-epf03 gnurr]$ ls -al
totalt 8
drwxr-xr-x    2 trondmy  trondmy      4096 jan 12 02:44 .
drwxr-xr-x   41 trondmy  trondmy      4096 jan 12 02:42 ..
[trondmy@fyspc-epf03 gnurr]$ touch huhu
[trondmy@fyspc-epf03 gnurr]$ ls -al
totalt 8
drwxr-xr-x    2 trondmy  trondmy      4096 jan 12 02:44 .
drwxr-xr-x   41 trondmy  trondmy      4096 jan 12 02:42 ..
-rw-r--r--    1 trondmy  trondmy         0 jan 12 02:44 huhu

Cheers,
  Trond
