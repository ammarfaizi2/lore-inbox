Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTDGRYI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTDGRYI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:24:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263562AbTDGRYH (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 13:24:07 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] new syscall: flink
Date: Mon, 7 Apr 2003 17:35:16 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b6scsk$18b$1@penguin.transmeta.com>
References: <3E90746A.2010300@redhat.com>
X-Trace: palladium.transmeta.com 1049736919 25340 127.0.0.1 (7 Apr 2003 17:35:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 Apr 2003 17:35:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E90746A.2010300@redhat.com>,
Ulrich Drepper  <drepper@redhat.com> wrote:
>
>I got a couple of requests for a function which isn't support on Linux
>so far.  Also not supportable, i.e., cannot be emulated at userlevel.
>It has some history in other systems (QNX I think), though, and helps
>with some security issues.  It really not adding much new functionality
>and I hope I got it right with my "monkey see, monkey do" technique of
>looking up other places doing similar things.

As others have pointed out, there is no way in HELL we can do this
securely without major other incursions.

In particular, both flink() and funlink() require that you do all the
same permission checks that a real link() or unlink() would do. And as
some of them are done on the _source_ of the file, that implies that
they have to be done at open() time.

One check in particular is "is the opener willing to let this be linked
anywhere else in the namespace". Since the opener isn't necessarily the
same agent as the one doing the flink().

If you really really think you need this (and not just do it because
some random idiot-customer doesn't understand security), then I would
suggest you add a O_CANLINK flag to open, and require that that flag is
set in the file descriptor.

That way you get "flink()" behaviour, but you require that the opener be
aware of the fact that the file may be linked into another position.
That will fix the glaring security hole.

		Linus
