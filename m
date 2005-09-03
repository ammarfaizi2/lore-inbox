Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVICQzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVICQzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVICQzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:55:17 -0400
Received: from smtpout.mac.com ([17.250.248.71]:32749 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751101AbVICQzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:55:16 -0400
In-Reply-To: <4319BEF5.2070000@zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <4319330C.5030404@zytor.com> <20050903055007.GA30966@codepoet.org> <43193A4F.5030906@zytor.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Sat, 3 Sep 2005 12:55:05 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 3, 2005, at 11:19:17, H. Peter Anvin wrote:
> Thus, an ABIzed <linux/abi/stat.h> or whatever it's called might  
> export
> "struct __kabi_stat" and "struct __kabi_stat64" with the  
> expectation that
> the caller would "#define __kabi_stat64 stat" if that is the  
> version they
> want.  A typedef isn't good enough for C, since you can't typedef  
> struct
> tags.

Didn't you mean "#define stat __kabi_stat64"?  Also, I can see that  
would
pose other issues as well say my app does "struct stat stat;"  Any error
messages would refer to a variable "__kabi_stat64" instead of the  
expected
"stat":

A userspace program:
struct stat stat;
stat.invalid = 1;

Preprocesses into:
struct __kabi_stat64 __kabi_stat64;
__kabi_stat64.invalid = 1;

And gives an error something like this for that line, confusing the
programmer:
Invalid member "invalid" for "__kabi_stat64"


As far as I can tell, this is not a solvable issue unless GCC can  
come up
with a way to either:
     typedef struct foo struct bar;
or
     struct bar { unnamed struct foo; };
the former being much nicer.  On the other hand, I think the following
should work, because the st_* names are within the C namespace and  
should
be much easier to redefine, although misuse of one of those names might
be a bit more catastrophic for the user app.

struct stat {
     struct __kabi_stat64 __stat64;
};
#define st_dev __stat64.st_dev
#define st_ino __stat64.st_ino
[...]

Then the userspace program could do this:
struct stat foo;
foo.st_ino = 0;

And it would be preprocessed into:
struct stat foo;foo.__stat64.st_ino = 0;

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because
life wouldn't have any meaning for them if they didn't. That's why I  
draw
cartoons. It's my life."
   -- Charles Shultz


