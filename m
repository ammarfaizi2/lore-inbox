Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266321AbUAHTrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUAHTo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:44:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21266 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S266292AbUAHTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:42:19 -0500
Message-ID: <3FFDB272.8030808@zytor.com>
Date: Thu, 08 Jan 2004 11:41:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       raven@themaw.net, Michael.Waychison@sun.com, thockin@sun.com
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>
In-Reply-To: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trond.myklebust@fys.uio.no wrote:
> 
> Finally, because the upcall is done in the user's own context, you avoid
> the whole problem of automounter credentials that are a constant plague
> to all those daemon-based implementations when working in an environment
> where you have strong authentication.
> If anyone wants evidence of how broken the whole daemon thing is, then see
> the workarounds that had to be made in RFC-2623 to disable strong
> authentication for GETATTR etc. on the NFSv2/v3 mount point.
> 

It's not broken as much as what you want to do is outside the scope of
automount.  automount is one particular user of these facilities, and as
you correctly point out, it can't solve the problems for all of them.
The right thing for AFS and NFSv4 is clearly to do something different.

Mount traps by themselves are not sufficient for automount, which is why
I think we will always have a special "autofs" filesystem, for the
simple reason that automount in typical use doesn't either have an a
priori complete list of directories!  Even with ghosting you might find
that you're accessing a new key which has not yet been ghosted, and it
needs to be handled correctly.  Additionally, not all map types can be
enumerated, and some aren't even finite in size (consider /net, program
maps and wildcard map entries.)  Thus, for indirect mountpoints you
still need a filesystem which can trap on non-enumerated entries.

That being said, mount traps in particular, and possibly this "trap
filesystem" are more generic kernel facilities which should be of use to
other things than automount.  AFS/NFSv4 are the obvious examples, quite
possibly other things like intermezzo might be interested, and we don't
want to have to reinvent the wheel every time.

	-hpa

