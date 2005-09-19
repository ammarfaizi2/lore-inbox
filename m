Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVISEza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVISEza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVISEza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:55:30 -0400
Received: from smtp.enter.net ([216.193.128.24]:61193 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932239AbVISEz3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:55:29 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Martin v. =?iso-8859-1?q?L=F6wis?=" <martin@v.loewis.de>
Subject: Re: [Patch] Support UTF-8 scripts
Date: Mon, 19 Sep 2005 00:31:43 +0000
User-Agent: KMail/1.7.2
Cc: 7eggert@gmx.de, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
References: <4N6EL-4Hq-3@gated-at.bofh.it> <200509172231.33872.dhazelton@enter.net> <432D1033.6040801@v.loewis.de>
In-Reply-To: <432D1033.6040801@v.loewis.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509190031.44460.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 September 2005 06:58, "Martin v. Löwis" wrote:
> D. Hazelton wrote:
> > This is news to me. The last time I handed execve() a script as a
> > paramter I had errors returned from execve() -- I must admit that
> > this was not on my current system and I had assumed that the
> > behavior would be consistent.
>
> The kernel checks for #!<path>, and that <path> is an existing
> executable. If not, execve fails.
>
> > You are correct. It is fairly trivial. However my point still is
> > valid that the Kernel has the whole binfmt_misc system -- I will
> > admit that I have recently been shown numbers that show a
> > noticeable difference in the speed of a binary executed using the
> > binfmt_misc system and the binfmt_script system, but the fact
> > remains that offering handling for UTF8 and ASCII scripts
> > directly in the kernel will likely lead to at least one more
> > patch in which the the full Unicode standard is implemented.
>
> The problem with the binfmt_misc approach is that you need
> *another* execve call: with binfmt_misc, you register <utf8sig>#!,
> and a generic binary. Then, this generic binary will interpret the
> #! signature *again*, and invoke the proper interpreter. This will
> intepret the first line *yet again* (finding that it is a comment),
> and continue processing the file.

True. I had forgotten that for truly generic rules about handling the 
#!  there would be double the overhead for the sh_bang.

> However, this is not the real problem. The real problem is that
> the specific binfmt_misc "backend" would not be universally
> available, and then the same script would start on some systems,
> and break on others. This may be acceptable for large or specific
> applications (e.g. you have to setup the ibcs2 module to run
> SCO applications); it is not for scripts.

Again  this is all too true. Doubly so with the problem of an initrd 
that has 'init' as a script.

> Now, the "universally available" part would not apply right now,
> as only the most recent kernels would provide the feature. However,
> within a few years, the feature would be part of "Linux" - then
> people can start using it extensively.

This sounds to me like you're saying in a few years my suggestion of 
using binfmt_misc would be tenable. Unfortunately, unless forced into 
it, no distro would ever use it. As I now see it, binfmt_script is 
pretty much a hard-coded hack that gives the system a bit more speed 
for running scripts. And since I've thought about the consequences of 
ripping it out after the posts yesterday - there is no clean way to 
remove it and still have a large number of systems still function.

> > That, and my point remains that the kernel should know absolutely
> > nothing about how to execute a text file - the kernel should
> > return an error to the extent of "I don't know what to do with
> > this file" to the shell that tries to execute it, and the shell
> > can then check for the sh_bang. I do admit that this change would
> > break a lot of existing code, so I'll leave the argument to the
> > experts.
>
> The point is that it is not necessarily the shell which starts
> programs - the shell is but one creator of new processes. It is
> very common today that, say, httpd starts new programs - this
> mechanism is called CGI. Your approach was in use until 1985 or
> so, when Unix implementations started to support #! natively.
> This was done both for convenience and for performance: if
> programs would always use system(3) to start new processes,
> there would always be a shell that execs the eventual
> interpreter.

True. In some cases, though, system(3) is really unusable - like you 
mentioned, httpd often starts new processes. Since daemons don't, 
technically, run on top of a shell, having one use system(3) to start 
a new process would add a lot of unnecessary overhead.

> I'm not sure, but I believe that most current shells have
> "forgotten" how to do the #! magic, since, by now, "traditionally"
> this is a kernel responsibility.

Not true. Bash, at least, still handles the sh_bang. (Provable by 
using it to call a perl script that doesn't have the exec bit set. 
This worked for me just a week ago :)

DRH
