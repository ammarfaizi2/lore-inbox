Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSALRBs>; Sat, 12 Jan 2002 12:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSALRB3>; Sat, 12 Jan 2002 12:01:29 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:62050 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287189AbSALRBN>; Sat, 12 Jan 2002 12:01:13 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: trond.myklebust@fys.uio.no
Subject: [NFS] some strangeness (at least) with linux-2.4.18-NFS_ALL patch
Date: Sat, 12 Jan 2002 18:01:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de> <15423.39344.864108.741338@charged.uio.no> <15423.40571.772367.676896@charged.uio.no>
In-Reply-To: <15423.40571.772367.676896@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020112170111.12E601431@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Howdy, Hey Trond, [forgive me, watched Toy Story 2 dvd today :)]

me again ;-)

On Saturday, 12. January 2002 03:24, Trond Myklebust wrote:
> >>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:
>      > Are you sure that you didn't mess up the fixups with
>      > 2.4.18-pre1? That might explain things, since you would be
>      > messing with nfs_refresh_inode. What you need to do against
>      > 2.4.18-pre1 is first to revert the patch
>      > linux-2.4.17-fattr.dif. After that you should be able to apply
>      > linux-2.4.17-NFS_ALL.dif directly without any rejections...

I've messed it up, mea culpa. Sorry!

I redid my kernel today, using your 2.4.18-NFS_ALL from last night ;-),
based on 2.4.18-pre3, but kept out Andrea's 00_lowlatency-fixes-4 for 
now:
imon-0.0.2-2.4.12-hp
linux-2.4.18-NFS_ALL.dif
00_nanosleep-5.dif
pnpbios.patch_latest
vmscan.patch.2.4.17.dif
ide.2.4.16.12102001.patch.bz2
bttv-0.7.88-2.4.17
btaudio-2.4.17
and my symlink problem disappeared. I thought, I could reproduce a
longer standing problem, which bites me from time to time.

Here we go:

When it came to the usual lm_sensors 2.6.2 modules install within 
the client, this happened:

[...]
gcc -shared -Wl,-soname,libsensors.so.1 -o lib/libsensors.so.1.2.0 
lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo 
lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc
make: stat:lib/libsensors.so.1: Eingabe-/Ausgabefehler
rm -f lib/libsensors.so.1
rm: Entfernen von »lib/libsensors.so.1« nicht möglich: Eingabe-/Ausgabefehler
make: *** [lib/libsensors.so.1] Error 1
hp@elfe:~/Downloads/linux/lm_sensors/lm_sensors-2.6.2> l lib/libsensors.*   
ls: lib/libsensors.so.1: Eingabe-/Ausgabefehler
-rw-rw-r--    1 hp       lisa         6559  8. Feb 1999  lib/libsensors.3
-rw-rw-r--    1 hp       lisa        87100 12. Jan 16:58 lib/libsensors.a
lrwxrwxrwx    1 hp       lisa           19 12. Jan 16:58 lib/libsensors.so -> 
libsensors.so.1.2.0*
-rwxrwxr-x    1 root     root        83142 12. Jan 16:59 
lib/libsensors.so.1.2.0*

server's view:
hp@shrek:~/Downloads/linux/lm_sensors/lm_sensors-2.6.2/lib> l libsensors.*
-rw-rw-r--    1 hp       lisa         6559 Feb  8  1999 libsensors.3
-rw-rw-r--    1 hp       lisa        87100 Jan 12 16:58 libsensors.a
lrwxrwxrwx    1 hp       lisa           19 Jan 12 16:58 libsensors.so -> 
libsensors.so.1.2.0*
lrwxrwxrwx    1 hp       lisa           19 Jan 12 16:58 libsensors.so.1 -> 
libsensors.so.1.2.0*
-rwxrwxr-x    1 root     root        83142 Jan 12 16:59 libsensors.so.1.2.0*

Somehow, gcc managed it to create an invalid link in the above sequence.
Really bad is, you cannot get around this within the client. After 
rm'ing lib/libsensors.so.1 on the server, make install succeeds on the client.

[...]
rm -f lib/libsensors.so.1
ln -sfn libsensors.so.1.2.0 lib/libsensors.so.1
mkdir -p /usr/lib /usr/include/sensors /usr/man/man3 /usr/man/man5
install -o root -g root -m 644 lib/libsensors.a lib/libsensors.so.1.2.0 
lib/libsensors.so.1 lib/libsensors.so /usr/lib
ln -sfn libsensors.so.1.2.0 /usr/lib/libsensors.so.1
ln -sfn libsensors.so.1 /usr/lib/libsensors.so
[...]

I can reproduce this now. Do you?

Hope, I don't bother you above the critical mass, because I don't want
to trigger the third world war, in case you get out of control and explode
unconditionally. Warn me in time plz :)

Happy NFSing'ly yours,
Hans-Peter
