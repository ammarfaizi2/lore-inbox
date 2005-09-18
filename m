Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVIRG7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVIRG7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVIRG7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:59:08 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:40839 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751199AbVIRG7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:59:07 -0400
Message-ID: <432D1033.6040801@v.loewis.de>
Date: Sun, 18 Sep 2005 08:58:59 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "D. Hazelton" <dhazelton@enter.net>
CC: 7eggert@gmx.de, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4N6EL-4Hq-3@gated-at.bofh.it> <200509170028.59973.dhazelton@enter.net> <432BB77E.3050501@v.loewis.de> <200509172231.33872.dhazelton@enter.net>
In-Reply-To: <200509172231.33872.dhazelton@enter.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hazelton wrote:
> This is news to me. The last time I handed execve() a script as a 
> paramter I had errors returned from execve() -- I must admit that 
> this was not on my current system and I had assumed that the behavior 
> would be consistent.

The kernel checks for #!<path>, and that <path> is an existing
executable. If not, execve fails.

> You are correct. It is fairly trivial. However my point still is valid 
> that the Kernel has the whole binfmt_misc system -- I will admit that 
> I have recently been shown numbers that show a noticeable difference 
> in the speed of a binary executed using the binfmt_misc system and 
> the binfmt_script system, but the fact remains that offering handling 
> for UTF8 and ASCII scripts directly in the kernel will likely lead to 
> at least one more patch in which the the full Unicode standard is 
> implemented.

The problem with the binfmt_misc approach is that you need *another*
execve call: with binfmt_misc, you register <utf8sig>#!, and a
generic binary. Then, this generic binary will interpret the #!
signature *again*, and invoke the proper interpreter. This will
intepret the first line *yet again* (finding that it is a comment),
and continue processing the file.

However, this is not the real problem. The real problem is that
the specific binfmt_misc "backend" would not be universally
available, and then the same script would start on some systems,
and break on others. This may be acceptable for large or specific
applications (e.g. you have to setup the ibcs2 module to run
SCO applications); it is not for scripts.

Now, the "universally available" part would not apply right now,
as only the most recent kernels would provide the feature. However,
within a few years, the feature would be part of "Linux" - then
people can start using it extensively.

> That, and my point remains that the kernel should know absolutely 
> nothing about how to execute a text file - the kernel should return 
> an error to the extent of "I don't know what to do with this file" to 
> the shell that tries to execute it, and the shell can then check for 
> the sh_bang. I do admit that this change would break a lot of 
> existing code, so I'll leave the argument to the experts.

The point is that it is not necessarily the shell which starts
programs - the shell is but one creator of new processes. It is
very common today that, say, httpd starts new programs - this
mechanism is called CGI. Your approach was in use until 1985 or
so, when Unix implementations started to support #! natively.
This was done both for convenience and for performance: if
programs would always use system(3) to start new processes,
there would always be a shell that execs the eventual
interpreter.

I'm not sure, but I believe that most current shells have "forgotten"
how to do the #! magic, since, by now, "traditionally" this is
a kernel responsibility.

Regards,
Martin
