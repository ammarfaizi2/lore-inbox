Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316214AbSEVPzJ>; Wed, 22 May 2002 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316216AbSEVPzI>; Wed, 22 May 2002 11:55:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10255 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316214AbSEVPzG>; Wed, 22 May 2002 11:55:06 -0400
Date: Wed, 22 May 2002 08:55:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.16 IDE 68
In-Reply-To: <3CEB475B.1040601@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205220848100.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Martin Dalecki wrote:
>
> - Make the different ATAPI device type drivers use a unified packet command
>    structure. We have to start to push them together.

Good.

However, I suggest you really look at the big picture, and realize that
this is NOT an ATA-only issue.

The unified packet command thing should be started at a higher level,
where the command creation itself should create them into "rq->cmd[]", and
the interfaces to the _user_ should also be unified.

If you think it's stupid to have different packet mechanisms for IDE CD vs
disk, imagine how stupid it is to have different packet interfaces for
SCSI CD vs IDE CD and expose those different interfaces to user mode.

This is why I think you made a mistake to move ll_10byte_cmd_build() into
the IDE layer. We want to move the packet building _up_, not down.

And you should put the command into "rq->cmd[]", _not_ into "pc->c[]" like
the curren code does. And strive to standardize on a command set (where
the obvious target is a very SCSI-like one - for all the same reasons
that ATAPI commands themselves tend to look like SCSI commands).

So please don't lose sight of the fact that there is more than just IDE
out there, and _please_ get rid of the atapi-specific command. Think ahead
a bit, and notice how you have the "scsi" parts in the
"atapi_packet_command", and realize that you shouldn't need to have that,
if you were just to share the same request cmd layout.

		Linus

