Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUAHRfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUAHRfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:35:53 -0500
Received: from terminus.zytor.com ([63.209.29.3]:44724 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265776AbUAHRfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:35:42 -0500
Message-ID: <3FFD9498.6030905@zytor.com>
Date: Thu, 08 Jan 2004 09:34:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
CC: Mike Waychison <Michael.Waychison@Sun.COM>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
In-Reply-To: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:
> 
> If wildcard map entries are not in autofs v3 then Jeremy implemented this
> in v4.
> 

v3 has had wildcard map entries and substitutions for a very, very, very 
long time... it was a v2 feature, in fact.

> And yes the host map is basically a program map and that's all. Worse, as
> pointed out in the paper it mounts everything under it. This is a source
> of stress for mount and umount. I have put in a fair bit of time on ugly
> hacks to work around this. This same problem is also evident in startup
> and shutdown for master maps with a good number of entries (~50 or more).
> A consequence of the current multiple daemon approach.

This is why one wants to implement a mount tree with "direct mount 
pads"; which also means keeping some state in the daemon.

For example, let's say one has a mount tree like:

/foo		server1:/export/foo \
/foo/bar	server1:/export/bar \
/bar		server2:/export/bar

... then you actually have four diffenent filesystems involved: first, 
some kind of "scaffolding" (this can be part of the autofs filesystem 
itself or a ramfs) that hold the "foo" and "bar" directories, and then 
foo, foo/bar, and bar.

Consider the following implementation: when one encounters the above, 
the daemon stashes this away as an already-encountered map entry (in 
case the map entries change, we don't want to be inconsistent), creates 
a ramfs for the scaffolding, creates the "foo" and "bar" subdirectories 
and mount-traps "foo" and "bar".  Then it releases userspace.  When it 
encounters an access on "foo", it gets invoked again, looks it up in its 
"partial mounts" state, then mounts "foo" and mount-traps "foo/bar", 
then releases userspace.

In many ways this returns to the simplicity of the autofs v3 design 
where the atomicity constraints where guaranteed by the VFS itself, *as 
long as* mount traps can be atomically destroyed with umounting the 
underlying filesystem.

	-hpa
