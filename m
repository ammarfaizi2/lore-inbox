Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289600AbSAKTR6>; Fri, 11 Jan 2002 14:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289601AbSAKTRj>; Fri, 11 Jan 2002 14:17:39 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:5393 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289600AbSAKTRa>; Fri, 11 Jan 2002 14:17:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: trond.myklebust@fys.uio.no
Subject: Re: [NFS] some strangeness (at least) with linux-2.4.17-NFS_ALL patch
Date: Fri, 11 Jan 2002 20:17:26 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de> <15422.65459.871735.203004@charged.uio.no>
In-Reply-To: <15422.65459.871735.203004@charged.uio.no>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111191744.7A9CE1426@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 11. January 2002 16:07, Trond Myklebust wrote:
> >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
>      > The problem is, ls on the client side complains about an I/O
>      > error, when listing the conf/ dir.
>
> What server is this?

Oups, sorry: 
Linux shrek 2.4.13-ac7 #6 SMP Son Dez 2 20:02:04 CET 2001 i686 unknown
(on patches, IIRC)
>
>      > After removing this symlink (within the server), ls is OK
>      > within the client. Trying to copy servers /etc/ou.conf file to
>      > /usr/share/openuniverse within the client, cp complains about

Oups, correction: /usr/share/openuniverse/conf

>      > to many levels of symlinks?!? (/usr is shared)
>
> That can happen, yes. The symlink is still in the dcache, and so the
> VFS thinks that we want to open whatever it is that the symlink is
> pointing to (not the symlink itself). For this reason, less strict
> checking is performed, and so the client does not immediately see the
> change.

Shouldn't the client invalidate the dcache entry some time?
Now, 5 hours later, the dcache entry isn't invalidated, yet.

I think, this is a thinko. I'm not familiar with nfs internals,
but have done stuff like this before (anybody remember BioNet?).

Please try this:

shrek is the server, elfe the client
/raid is shared (reiserfs, no raid), /tmp isn't

shrek:/raid/tmp# touch /tmp/huhu
shrek:/raid/tmp# ln -s /tmp/huhu
shrek:/raid/tmp# l
total 1
drwxr-xr-x    2 root     root           55 Jan 11 20:07 ./
drwxr-xr-x    9 root     root          218 Jan 11 20:06 ../
lrwxrwxrwx    1 root     root            9 Jan 11 20:07 huhu -> /tmp/huhu

elfe:/raid/tmp# echo "huhu" > /tmp/huhu
elfe:/raid/tmp# l
insgesamt 1
drwxr-xr-x    2 root     root           55 11. Jan 20:07 ./
drwxr-xr-x    9 root     root          218 11. Jan 20:06 ../
lrwxrwxrwx    1 root     root            9 11. Jan 20:07 huhu -> /tmp/huhu
elfe:/raid/tmp# cat huhu 
huhu

shrek:/raid/tmp# rm huhu

elfe:/raid/tmp# l
insgesamt 1
drwxr-xr-x    2 root     root           35 11. Jan 20:07 ./
drwxr-xr-x    9 root     root          218 11. Jan 20:06 ../
elfe:/raid/tmp# touch huhu
elfe:/raid/tmp# l
ls: huhu: Eingabe-/Ausgabefehler
insgesamt 1
drwxr-xr-x    2 root     root           55 11. Jan 20:08 ./
drwxr-xr-x    9 root     root          218 11. Jan 20:06 ../

Pretty simple. Can you reproduce this?

> If, however, you had first done 'ls -l' or something that tries to
> read the symlink itself, more strict revalidation checks are
> performed, and the stale dentry would have been detected.

Not sure.

> I can tighten the checks on this sort of thing a bit, but if so, it
> needs to be done carefully. It is important to make sure that
> operations like
>    'ls /usr/lib/*'
> (in which you want the system to repeatedly look up the same path) are
> efficient by caching the '/usr/lib' bit even if that /usr/lib is a
> symlink.
> Of course every time we do open("/usr/lib/libc.so"), we *do* want to
> make sure that we perform strict checks when we do the lookup of the
> last element of the path (on the actual file "libc.so").
>
> Cheers,
>   Trond

Thank for your patience,
Hans-Peter
