Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUBVP5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUBVP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:57:14 -0500
Received: from imap.gmx.net ([213.165.64.20]:4767 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261242AbUBVP5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:57:11 -0500
X-Authenticated: #20799612
Date: Sun, 22 Feb 2004 16:54:10 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040222155410.GA3051@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222020911.2c8ea5c6.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 02:09:11AM -0800, Paul Jackson wrote:
> In addition to the incompatible changes you note:
>   1) "#! cmd x y" to pass single arg "x y" with embedded space broken
>   2) Use of '\' char changed

Well, as noted, this part can be removed easily. As I consider this part
least important, I maybe should have deleted it before sending the patch
(some "#ifdef CONFIG_xxxx" could be used instead).

But as I sent the patch also because I wanted to know what other people
think about the issue, I did not change it (passing \t was the topic of
the newsgroup discussion I mentioned).

>   3) Handling of long line changed
> doesn't this also
>   4) risk breaking shells that look to argv[2] for the name of the
>     shell script file for error messages?  This argument
>     has moved out to argv[argc-1], for some value of argc.

Well, if the shell can't handle some parameters, you shouldn't add them
to the shebang line. If you have some example.script

#!cmd -x

executed as "example.script -a -b", exec will still pass
{"cmd", "-x", "example.script", "-a", "-b"} as argv to cmd.

The patch just allows

#!cmd -x -y

to become {"cmd", "-x", "-y", "example.script", "-a", "-b"}.

If I understand you right, your argument could be used to say: passing
arguments is not good at all, because some interpreter expects the name
of the script in argv[1] (as it's usual with "normal" "#!/bin/sh"
scripts). In my opinion, you just can't use a shebang line
"#!interpreter argument" in this case. And it's the same with my
proposal: you don't have to pass two arguments -- and you shouldn't if
the interpreter can't handle it.

BTW, which shell expects the name of the script in argv[2]?

> I'll wager you have to make a better case for this than simply:
> 
>     As I'm really missing this feature in Linux and changing this
>     would not break any (unless ...
> 
> before the above incompatibilities in a critical piece of code are
> overcome with the compelling need to change these details.

Yes, you may be right. But please note, that the "incompatibilities"
are rather theoretical, in my opinion (please correct me if I'm wrong):

- I don't think there are many scripts with "#!cmd -a -b" that must be
  parsed like {"cmd", "-a -b"}. And scripts like this would not be
  portable among the Unices, anyway.
- I think it's much better to get an error on a too long shebang line.
  It's rather dangerous to drop excessive characters silently as this
  can change the meaning of the command totally.

It's just a pain to have to use wrappers; they make a system
unnecessarily complex and error-prone and the arguments needed by the
interpreter cannot be found, where it's most logical to search.

I think, handling the shebang line "my" way (as it's already done by
FreeBSD) makes writing complex scripts easier and cleaner and has no
real disadvantages.

Thanks for the response,

	Hansjoerg Lipp
