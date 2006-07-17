Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWGQT6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWGQT6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWGQT6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:58:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6844 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751174AbWGQT6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:58:22 -0400
Message-ID: <44BBEC17.8020507@suse.com>
Date: Mon, 17 Jul 2006 15:59:19 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com> <44BBA4CF.8020901@suse.com> <44BBD4B6.5020801@namesys.com> <44BBD942.3080908@suse.com> <44BBDFFC.70601@namesys.com>
In-Reply-To: <44BBDFFC.70601@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Jeff Mahoney wrote:
>> 1) Because then the behavior of /proc/fs/reiserfs/ would be
>> inconsistent. Devices that contain slashes end up being one level deeper
>> than other devices, which is silly and a userspace visible change. 
> 
> And you think translating / to ! is less work for user space?

A one line s#/#!# to access devices they couldn't before versus now
having to deal with going deeper into a tree for no real reason? Yes, I do.

>> Tools
>> that wish to parse the information would then need added complexity to
>> traverse into the next level to reach that information.
>>
>> 2) The block-device-as-path-name-component behavior is already defined
>> by sysfs (/sys/block), and it should be consistent.
> 
> Translate that as, "I won't recompile my brain no matter what you do to
> make me."
> 
> You blindly copied how someone else in a hurry did it without a thought
> to whether it was done right, and now you don't want to change it.  You
> should have asked me about it before coding it.
> 
> Replace block-device-as-path-name-component with
> block-device-as-path-name-suffix, and everything is very consistent. 
> And elegant.

No, it's not, Hans. Adding another level is a user visible change. It is
*not* consistent, and requires users to change their tools. How is that
elegant?

> Jeff, you are a programmer, not an architect, and when you disregard
> architects we end up with things like the performance disaster that is
> V3 acls.

This again? The original reiser3 implementation was, and still is,
incomplete in comparison to the design document. The design touted the
extensibility of the tree and item types. My original xattr
implementation added another item type, but oh -- wait -- it turns out
that the file system isn't quite as extensible as claimed.. or, well, AT
ALL. Adding another item results in an incompatible file system change
that when mounted on another system, will panic the node. That's
friendly! There's not even any way to identify which items are in use on
a particular file system to issue a warning/error on mount. Outstanding
job "architecting" there.

If I could go back and do it again, I would have forked a reiserfs v3.7
that actually incorporated a compatibility block to identify which items
are in use on a particular file systems, so that the mount can succeed
or fail based on that. Xattrs would have been another item type as
expected, and the performance problems wouldn't be nearly as harsh as
they are. Not that you wouldn't have been just as resistant to that
change as well.

The thing is, you have a history of ignoring what users want. Users
wanted ACLs and xattrs on reiser3, but you said, "wait for v4, it'll be
out soon, and it'll have them." That was 4 years ago. Reiser4 still
isn't completely stable (or in mainline), and ACLs and xattrs still
aren't implemented. Users that demanded ACLs certainly aren't waiting
around for reiser4 to be released and have ACLs added. They've long
since switched to a file system that actually does what they need. They
wanted ACLs and xattrs added to the stable file system they were using
and you refused in an attempt to get more support for your latest
project. Further, reiser3 users remember what a long painful road it was
to reiser3 stability and aren't looking to use their production systems
as your guinea pigs. They don't want to go through that hell again.

> Replacing / with ! is hideous.  Someone added a nifty elegance to block
> device naming, and you are desecrating it.

No, someone added inconsistent names to block devices, and now we have
to pay for it.

If trying to understand what users actually want, and trying to keep
their experience consistent with the rest of the system makes me a
programmer instead of an architect, fine. It's a badge I'll wear
proudly. You can keep your ivory tower.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEu+wXLPWxlyuTD7IRAmroAJ0bbMSL7iSZ7TI29M/+e/jRQqbDPQCfYBcZ
w7OwY1/+G1UckaPURd0zTrg=
=3iaQ
-----END PGP SIGNATURE-----
