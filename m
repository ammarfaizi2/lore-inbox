Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVISEl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVISEl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVISEl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:41:26 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:33253 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S932193AbVISElZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:41:25 -0400
Message-ID: <432E416E.6090207@v.loewis.de>
Date: Mon, 19 Sep 2005 06:41:18 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "D. Hazelton" <dhazelton@enter.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NXfZ-5P0-1@gated-at.bofh.it> <4NYlM-7i0-5@gated-at.bofh.it> <4Olip-6HH-13@gated-at.bofh.it>
In-Reply-To: <4Olip-6HH-13@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hazelton wrote:
>>I would need to write a compiled C program to do all
>>sorts of fragile hackish things like calling a script
>>/sbin/init.sh.
> 
> 
> Problem is, the program 
> would not be fragile or hackish - it'd be almost as simple as a 
> "hello world" program.
> 
> #include <unistd.h>
> 
> int main() {
>   /* if this fails the system is busted anyway */
>   return execve( "/bin/sh", "/sbin/init.sh", 0 );
> };

This attempt nicely illustrates Kyle's point. This program *is*
fragile and hackish. It is fragile because, even though it is only
five lines, contains two major bugs:
1. execve takes an argv array, not a null-terminated list of
   strings. So this compiles with a warning about incompatible
   pointer types; you meant to use execl(3).
2. In the exec family, the path to the program is different from
   argv[0]. So the correct line would be

     return execl("/bin/sh", "sh", /sbin/init.sh", 0);

It is hackisch, because it also lacks a feature commonly
found in such wrappers:
3. arguments passed to the wrapper are not forwarded to the
   executable. In particular, init takes several arguments
   (e.g. the runlevel), which should be forwarded to the
   final executable.

Just try completing the wrapper on your own.

Regards,
Martin
