Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRC0XsO>; Tue, 27 Mar 2001 18:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131729AbRC0XsE>; Tue, 27 Mar 2001 18:48:04 -0500
Received: from chmls06.mediaone.net ([24.147.1.144]:27809 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S131733AbRC0Xrz>; Tue, 27 Mar 2001 18:47:55 -0500
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Tue, 27 Mar 2001 18:44:25 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
Message-ID: <20010327184425.A7650@pimlott.ne.mediaone.net>
Mail-Followup-To: "H. Peter Anvin" <hpa@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <E14i0u8-0004N1-00@the-village.bc.nu> <3AC1109A.8459E52@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC1109A.8459E52@transmeta.com>; from hpa@transmeta.com on Tue, Mar 27, 2001 at 02:13:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 02:13:47PM -0800, H. Peter Anvin wrote:
> The problems with devfs (other than kernel memory bloat, which is pretty
> much guaranteed to be much worse than the bloat a larger dev_t would
> entail) is that it needs complex auxilliary mechanisms to make
> "chmod /dev/foo" work as expected (the change to /dev/foo is to be
> permanent, without having to edit some silly config file)

The elegant solution seems obvious to me.  What we have today is two
namespaces--device major/minor, and filesystem--that are bridged by
special files.  Special files live in the filesystem namespace and
point into the major/minor namespace.  Objects in the major/minor
namespace are directly accessible only by root (ie, only root can
mknod(2)); but when accessed through special files, access control
comes from the special file.

The concept that makes this work is that the special file is a
"pointer with permissions".  To make devfs work, you want the same
thing--except a pointer into filesystem space, not major/minor
space.  Unix doesn't have this, but it would be a simple cross of
symlinks (pointer living in the filesystem and pointing into the
filesystem) and special files (pointers with permissions).

To be concrete:  You'd have a root-only (or perhaps the directories
could be a+rx--but minimal policy) hierarchy under /devices, and the
admin would populate /dev with "special symlinks" that point into
/devices, and give the appropriate permissions to users.

I have no idea whether this is feasible, but it is much more
attractive to me than devfsd, or layered mounts, or tar at
shutdown, or anything else I've heard.

Andrew
