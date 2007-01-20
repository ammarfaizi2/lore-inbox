Return-Path: <linux-kernel-owner+w=401wt.eu-S1750749AbXATXJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXATXJS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 18:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbXATXJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 18:09:18 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:33838 "EHLO
	taverner.cs.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXATXJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 18:09:17 -0500
X-Greylist: delayed 2862 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jan 2007 18:09:17 EST
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] Undo some of the pseudo-security madness
Date: Sat, 20 Jan 2007 21:58:08 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eou39g$a8r$1@taverner.cs.berkeley.edu>
References: <87y7nxvk65.wl@betelheise.deep.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1169330288 10523 128.32.168.222 (20 Jan 2007 21:58:08 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sat, 20 Jan 2007 21:58:08 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff  wrote:
>This patch removes the dropping of ADDR_NO_RANDOMIZE upon execution of setuid
>binaries.
>
>Why? The answer consists of two parts:
>
>Firstly, there are valid applications which need an unadulterated memory map.
>Some of those which do their memory management, like lisp systems (like SBCL).
>They try to achieve this by setting ADDR_NO_RANDOMIZE and reexecuting
>themselves.
>
>Secondly, there also are valid reasons to want those applications to be setuid
>root. Like poking hardware.

This has the unfortunate side-effect of making it easier for local
attackers to mount privilege escalation attacks against setuid binaries
-- even those setuid binaries that don't need unadulterated memory maps.

There's a cleaner solution to the problem case you mentioned.  Rather than
re-exec()ing itself, the application could be split into two executables:
the first is a tiny setuid-root wrapper which sets ADDR_NO_RANDOMIZE and
then executes the second program; the second is not setuid-anything and does
all the real work.  Such a decomposition is often better for security
for other reasons, too (such as the fact that the wrapper can drop all
unneeded privileges before exec()ing the second executable).

Why would you need an entire lisp system to be setuid root?  That sounds
like a really bad idea.  I fail to see why that is a relevant example.  
Perhaps the fact that such a lisp system breaks if you have security features
enabled should tell you something.

It may be possible to defeat address space randomization in some cases,
but that doesn't mean address space randomization is worthless.

It sounds like there is a tradeoff between security and backwards
compatibility.  I don't claim to know how to choose between those tradeoffs,
but I think one ought to at least be aware of the pros and cons on both
sides.
