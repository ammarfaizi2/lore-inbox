Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264031AbTIBQtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbTIBQtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:49:21 -0400
Received: from hera.kernel.org ([63.209.29.2]:12737 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264031AbTIBQqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:46:35 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Date: Tue, 02 Sep 2003 09:45:31 -0700
Organization: OSDL
Message-ID: <bj2hfc$a4c$1@build.pdx.osdl.net>
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi> <20030902015702.GA10265@osdl.org> <20030902095628.GB7616@wohnheim.fh-wedel.de> <16212.28592.322946.64754@gargle.gargle.HOWL>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Trace: build.pdx.osdl.net 1062521132 10380 172.20.1.2 (2 Sep 2003 16:45:32 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 2 Sep 2003 16:45:32 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> If data is a local variable then this is perfectly valid example of a
> C99 variable-length array (VLA). This works at least with gcc-2.95.3
> and newer, and gcc handles it by itself w/o calling alloca().

"alloca()" is not a function. It's a compiler intrisic, and Jörn is correct:
a variable-length array is _exactly_ the same as the historic "alloca()"
thing, and will generate the same code (modulo syntactic changes due to the
fact that one generates a pointer and the other generates an array).

And yes, it is legal in C99. However, it's not supposed to be legal in the
kernel, because it makes it impossible to check certain trivial things
about stack usage automatially. In particular, it totally breaks the
"objdump + grep" approach for finding bad stack users.

Also, trivial bugs (like not checking ranges etc) cause total stack
corruption with the feature, which means that such a kernel bug gets really
hard to track down.

So I consider the sparse warning to be appropriate.

That said, I do want to have a code-generation back-end for sparse some day,
if only because it's the only practical way to validate the front-end (ie
seeing if the back-end generates code that actually works - performance
doesn't matter). So I'd like to eventually extend sparse to handle variable
arrays, but I'd still want to have a flag to warn about them.

                Linus
