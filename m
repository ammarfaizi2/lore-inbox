Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132127AbRC1A3y>; Tue, 27 Mar 2001 19:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132146AbRC1A3p>; Tue, 27 Mar 2001 19:29:45 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:13073 "EHLO saturn.cs.uml.edu") by vger.kernel.org with ESMTP id <S132127AbRC1A3c>; Tue, 27 Mar 2001 19:29:32 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103280028.f2S0SKK91379@saturn.cs.uml.edu>
Subject: Re: Larger dev_t
To: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Tue, 27 Mar 2001 19:28:20 -0500 (EST)
Cc: hpa@transmeta.com (H. Peter Anvin), alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com (Linus Torvalds), Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <20010327184425.A7650@pimlott.ne.mediaone.net> from "Andrew Pimlott" at Mar 27, 2001 06:44:25 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott writes:
> On Tue, Mar 27, 2001 at 02:13:47PM -0800, H. Peter Anvin wrote:

>> The problems with devfs (other than kernel memory bloat, which is pretty
>> much guaranteed to be much worse than the bloat a larger dev_t would
>> entail) is that it needs complex auxilliary mechanisms to make
>> "chmod /dev/foo" work as expected (the change to /dev/foo is to be
>> permanent, without having to edit some silly config file)
>
> The elegant solution seems obvious to me.  What we have today is two
> namespaces--device major/minor, and filesystem--that are bridged by
> special files.  Special files live in the filesystem namespace and
> point into the major/minor namespace.  Objects in the major/minor
> namespace are directly accessible only by root (ie, only root can
> mknod(2)); but when accessed through special files, access control
> comes from the special file.
> 
> The concept that makes this work is that the special file is a
> "pointer with permissions".  To make devfs work, you want the same
> thing--except a pointer into filesystem space, not major/minor
> space.  Unix doesn't have this, but it would be a simple cross of
> symlinks (pointer living in the filesystem and pointing into the
> filesystem) and special files (pointers with permissions).
> 
> To be concrete:  You'd have a root-only (or perhaps the directories
> could be a+rx--but minimal policy) hierarchy under /devices, and the
> admin would populate /dev with "special symlinks" that point into
> /devices, and give the appropriate permissions to users.

This can be done with an lchmod() and support for setuid symlinks.

Read     can see where the link points
Write    ignored, or XOR the on-disk data with 0222 and...?
Execute  can follow the link
Setuid   link followed as for the owner
Setgid   link followed as for the owner's group
Sticky   reserved for future use

Then you get:

lr-sr-xr-x 1 root root 17 Mar 21 2000 /dev/null -> /devices/mem/null
