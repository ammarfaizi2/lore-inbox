Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVJEVFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVJEVFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVJEVFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:05:45 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:5856 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S932200AbVJEVFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:05:44 -0400
Date: Wed, 5 Oct 2005 23:05:34 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Marc Perkel <marc@perkel.com>
cc: Florin Malita <fmalita@gmail.com>, lsorense@csclub.uwaterloo.ca,
       nix@esperi.org.uk, 7eggert@gmx.de, lkcl@lkcl.net,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <43442D19.4050005@perkel.com>
Message-ID: <Pine.LNX.4.58.0510052208130.4308@be1.lrz>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
 <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca>
 <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com>
 <43442D19.4050005@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Marc Perkel wrote:

> What you don't get is that if you don't have rights to write to a file 
> then you shouldn't have the right to delete the file.

In unix, nobody but the kernel has the right to *delete* a file. Therefore 
nobody can delete a file without write permission.

Files are deleted if the last reference is gone. If you play a music file
and unlink it while it's playing, it won't be deleted untill the player
closes the file, since an open filehandle is a reference.


If you like, you can think of it as a kind of instant garbage collection:

Files are the objects referenced by these lists, and if you own 
the object, you can change it. However, as long as there is a reference, 
you can't destroy it, since this would invalidate all references.
Instead, you must remove all references.

Directories are lists of references, and these lists are independent from
the referenced file-objects. If you own the list, you can change it by 
adding or removing files. You can even link files not owned or accessable 
by you:

7eggert@be1:~/tmp > ls -l /tmp/foo/foo
----------    1 7eggert_b users           0 2005-10-05 22:32 /tmp/foo/foo
7eggert@be1:~/tmp > ln /tmp/foo/foo .
7eggert@be1:~/tmp > ls -l
total 0
----------    2 7eggert_b users           0 2005-10-05 22:32 foo
<snip>

Do you notice the link count in the second column?

Let's remove a link:

<snip>
*switch*
7eggert_b@be1:/tmp/foo> rm foo
rm: remove write-protected regular empty file `foo'? y
*switch*
7eggert@be1:~/tmp > ls -l
total 0
----------    1 7eggert_b users           0 2005-10-05 22:32 foo
<snip>

As you can see, each directory-owner can independantly unlink the file.

BTW: The owner can change the permissions on the linked file anytime, so
even if you couldn't link non-accessable files, you could end up with
entries in your private directory you could neither access nor delete.


I can also open the file as 7eggert_b, delete it from another tty and 
still access it's contents:

<snip>
7eggert_b@be1:/tmp/foo> cat > foo
as
*switch*
be1:/home/7eggert/tmp # rm /tmp/foo/foo
be1:/home/7eggert/tmp # ll /proc/4820/fd/1
l-wx------    1 7eggert_b users          64 Oct  5 22:43 /proc/4820/fd/1 
-> /tmp/foo/foo (deleted)
be1:/home/7eggert/tmp # cat /proc/4820/fd/1
as
*switch*
df
be1:/home/7eggert/tmp # cat /proc/4820/fd/1
as
df
<snip>

As you can see, the directory entry is deleted, but the file is still
there. However, making a hard link from a /proc/pid/fd entry is not (yet?)
possible: "ln: creating hard link `baz' to `/proc/4927/fd/1':  Invalid
cross-device link".


-- 
Fun things to slip into your budget
Not in a budget, but in an annual report:
An employee stole 500,000+. They accounted for it on the annual report as
'involountary employee relations expense'
