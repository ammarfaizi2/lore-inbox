Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbULPAgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbULPAgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbULPAeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:34:00 -0500
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:21167 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S262539AbULPAQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:16:58 -0500
Message-ID: <41C0D3F8.1020408@slaphack.com>
Date: Wed, 15 Dec 2004 18:16:56 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com> <1103059622.2999.17.camel@grape.st-and.ac.uk> <41BFC1C5.1070302@slaphack.com> <41BFCB66.3090809@namesys.com>
In-Reply-To: <41BFCB66.3090809@namesys.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
[...]
| Explain the value of caching executable output more please.

If executables become "plugins" (see below), there is a performance loss
to be made up by caching.  For instance, if we have an executable which
calls "tar", which we attach to a tarball, we want to cache the
extracted files.  It's even more urgent when people start writing
perl/python/ruby executables to deal with system configuration files,
such as /etc/passwd.  It's allright for passwd to take half a second to
generate, so long as we cache that output, and thus only spend the half
second when passwd is modified, instead of every time a user logs in.
|
|>
|> | The component objects themselves could be full objects, so they
|> | themselves could have sub-components.
|>
|> Right.
|>
|> Also, there should be an inverse. For instance, a file-as-directory type
|> object should have a "contents" object, usually a normal directory, but
|> which could conceivably be any type of object, including a code-ish
|> object which implements a filesystem. Accessing foo/ would be the same
|> as accessing foo/.../contents, only because "..." (or whatever we use
|> for meta-files) is outside the actual directory namespace,
|> foo/.../contents/... refers to the metas of object "contents", which are
|> different than the metas of object "foo".
|
|
| Are you sure that having more than one "...." is needed?  Hmmm,
| interesting, must think about it.

Yes. foo is a file, foo/contents is another file (an executable).  But
maybe the executable has contents too -- with an extra "...", you can do
things like "foo/.../contents/.../contents", where the first "contents"
controls what you get from "ls foo/", and the second "contents" controls
what you get from "ls foo/.../contents/".

|>
|> These two steps essentially create userspace "plugins", and do away with
|> having to mount other kernel layers such as lufs (or whatever its
|> current implementation is).
|
|
| I don't follow this point above.

lufs is (or was) a kernel filesystem which talks to a user daemon.  The
daemon does all the work, so you don't have to do things like windows
emulation in the kernel in order to get captive-ntfs to work.

The reason we don't do that for the whole filesystem is performance --
after all, userland things are easier to write, debug, upgrade, and
install/use than kernel things.

If an executable can generate a directory listing or a whole directory
structure, some files, and so on, then we only need a few reiser4 kernel
plugins, and these userland executables can implement all the
functionality of most kernel plugins people have thought of so far.

The only problem is, it would be much slower than a kernel plugin.
Caching solves that.

Of course, someone still might find a situation where people really need
to create a new kernel plugin, and that would be allowed.  But I doubt
it would help that much, or we'd all be using TUX instead of Apache.

[...]

|> I think the issues with directory-as-a-file were the same problems you
|> get when you allow hardlinked directories -- that you'd eventually have
|> to ditch reference counting for a garbage collector, which is hellishly
|> impractical. I don't have a solution to that, other than dropping
|> hardlinks entirely.
|
|
| This issue is overblown.  Other fields have solved this problem.

Nevertheless, it's an issue that I don't have the skills to solve, and
one that must be solved if we are ever to implement these concepts.

If you have a solution, I'd love to hear it.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQcDT93gHNmZLgCUhAQLn6g/+KXD5StI9m9Tpij0i3uwqXAc+oAdz/dX5
YHSwU7YYXSdVPPqNqUNnU4t7i8M1p8Mba0Jpc2rPZk6Is67txBnphLX2F7c9jLm8
wfqfkjrfOM7/+5/EDQbdGVch0gZnuLJrxjGcpvukkwi8hkiMQnOtZuKuZwn1ieMW
UlTy5e/IhDPl5zW/Dy3rpoAOw7hszvPv6fjpFDujUENHhhUQmWYoiIbIaV3rdbhY
De+9AOkCRDEYNOmreCQQYmTkJD6w4C9cHzqmx7FrVx8vhxU3k9CPwoGRGGIrn42+
UPKAtUCAZu6Mya1v9v6QnPFaqnPgQatIJl4edg91bBzktpRZg6oR2iS9QnnAxc+b
LFJr95OKtdjBVVNuJGLRVCi06xoQsIjNWe5rOajAGHw/YHr7mHMZF315XKcp7FPa
F1df8FwdpQgq2xM6OdIfSFlBxk2poj21w5NqVyOZoEMunTyyDnK0YQkigsz2AQeN
lOeryopJ1sh9eHkQOsxOh/JdpYCVSkOfWiPgDKMst9mZbFF4yWwsot9JP1rNIUOC
EtGHdQzUOtKPkKWNy2+VXKxd8F+5EUpAtmOrdG2B7FT0wjS5Ao1pz6c7boMo1x9D
+9QxS2W1DdWjsCR9WhZhg0+eWc2wkf/dyVQIipf3JTm5vLOFJvJ/jfV3GRg0Ye7f
gtjTMcGxzAc=
=CIsH
-----END PGP SIGNATURE-----
