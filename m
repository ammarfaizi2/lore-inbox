Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUBRD2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBRD2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:28:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:5861 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262652AbUBRD14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:27:56 -0500
Date: Tue, 17 Feb 2004 19:27:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <4032D893.9050508@zytor.com>
Message-ID: <Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org>
 <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org>
 <c0uj52$3mg$1@terminus.zytor.com> <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
 <4032D893.9050508@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, H. Peter Anvin wrote:
> 
> Well, this is also true :)  I still say it belongs in userspace.

The thing is, I do agree with Tridge on one simple fact: it's very hard 
indeed to do atomic file operations from user space.

That's not necessarily a problem if samba is the only process accessing
the directories in question, since then samba could do all locking
internally and make sure that it never does anything inconsistent.

However, clearly people who run samba on a machine want to potentially 
_also_ export that same filesystem as a NFS volume, as a way to have both 
Windows and UNIX clients access the same data. And that pretty much means 
that other people _will_ access the directories, and that samba can't do 
its internal locking in that kind of environment.

This is why I am symphathetic to the need to add _some_ kind of support 
for this. And the only common place ends up being the kernel.

> For 100% bug-compatibility with Windows, though, it is probably
> worthwhile to have the filename in the native filesystem be not what a
> Windows user would see, but rather the normalized filename.  That makes
> a userspace implementation much easier.

Oh, absolutely. But that's something that samba can easily do internally: 
it can choose to just entirely ignore filenames that aren't normalized, or 
it can export it on the wire (obviously in the normalized UCS-2 format), 
and just consider non-normalized names to be another "case". In fact, 
that's what the naive implementation would do anyway, so that's not any 
added complexity.

(And samba clearly _cannot_ show the client a non-normalized name per se, 
since the smb protocol ends up using UCS-2).

		Linus
