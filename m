Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTEYDkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 23:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTEYDkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 23:40:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45573 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261300AbTEYDkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 23:40:04 -0400
Date: Sat, 24 May 2003 20:52:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben Collins <bcollins@debian.org>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
In-Reply-To: <20030525000701.GG504@phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 May 2003, Ben Collins wrote:
>
> Given that the problem with KOBJ_NAME_LEN == 20 affecting one snd driver
> has so far only been explained as a compiler bug, can I suggest this
> patch be applied? Even aside from the KOBJ_NAME_LEN == 20, the snprintf
> changes will keep things from breaking in other ways that are current
> now.

I hate using snprintf() for this kind of mindless string copy opertation.

Yeah, "strncpy()" is a frigging disaster when it comes to '\0', in many
ways. We should probably disallow using strncpy(), and aim for a _sane_
implementation that does what we actually want (none of that zero-padding
crap, and _always_ put a NUL at the end). I bet that is what most current
strncpy() users actually would want.

But switching it over to "snprintf()" is overkill. 

How about just adding a sane

	int copy_string(char *dest, const char *src, int len)
	{
		int size;

		if (!len)
			return 0;
		size = strlen(src);
		if (size >= len)
			size = len-1;
		memcpy(dest, src, size);
		dest[size] = '\0';
		return size;
	}

which is what pretty much everybody really _wants_ to have anyway? We 
should deprecate "strncpy()" within the kernel entirely.

		Linus

