Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311439AbSCaDDc>; Sat, 30 Mar 2002 22:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311434AbSCaDDV>; Sat, 30 Mar 2002 22:03:21 -0500
Received: from mail.webmaster.com ([216.152.64.131]:9896 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S311322AbSCaDDQ> convert rfc822-to-8bit; Sat, 30 Mar 2002 22:03:16 -0500
From: David Schwartz <davids@webmaster.com>
To: <mra@pobox.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Sat, 30 Mar 2002 19:03:13 -0800
In-Reply-To: <m3663hjte0.fsf_-_@khem.blackfedora.com>
Subject: Re: How to tell how much to expect from a fd
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020331030314.AAA15293@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 Mar 2002 18:52:39 -0800, Mark Atwood wrote:
>
>Does there exist a fcntl or some other way to tell how much data is
>"ready to be read" from a fd?
>
>I'm doing this thing where I make the fd non-blocking, select on it,
>and then read on it into a buffer that I am pregrowing with realloc.
>
>When the high water mark is up to the top of the buffer, I realloc the
>buffer to make it bigger.  At present, I'm just adding a constant
>value to the buffer size each time I need to do this, but if there was
>a way to easily tell how much was "ready to be read" from the fd.
>
>It's not necessary to be exact. If more becomes available between the
>time I do this wanted magic and do the read, read's 3rd parameter will
>keep me safe, and if it's too low, like if a dup of the fd already
>snarfed the data, also no big deal, I'm non-blocking and check the
>return value.
>
>So, is this "nice to have" available?

	It is possible that you are the one-in-a-million case that really needs 
this, but the vast majority of the time people ask for this, they don't 
really want it.

	Consider two very important points:

	First, by the time you get this information, it's obsolete. If more data 
becomes available in-between when you make this call and when you attempt to 
read, you'll take a double penalty. You'll need an extra 'read' later to get 
the rest and your next poll/select will break out immediately (which can be 
very expensive if you're dealing with a large number of fds).

	Second, this would double the number of system calls you need to read the 
data from the socket. There's almost no conceivable scenario in which it's 
worth the cost of doing this when you can either keep a buffer that's a bit 
too large around or copy it into a right-sized buffer and you can choose 
which option after you know how many bytes you got.

	DS


