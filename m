Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVGZTtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVGZTtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGZTrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:47:14 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:63892 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261886AbVGZTrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:47:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=l4sZGfMXkiUymvynR9WY2cOsLKRzXvxtc8k5wvbA5BdM/LQedF6/T66Y/UTR0fXynH40miNXBwQfu60DATJzev7WXWcM6zVmkraa8Vh3jKdq+h5C+hY+hrfXpbZVlz0lIjspyjQQ+eKPfXprsxAoYlJvRkjYsDPvK/Hkzb9FfHs=
Message-ID: <42E692E8.4020703@gmail.com>
Date: Tue, 26 Jul 2005 15:45:44 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cutaway@bellsouth.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 speed
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com> <1122248869.10835.25.camel@localhost.localdomain> <f8994115050724211071a3dbe1@mail.gmail.com> <012401c591a6$9a2e2040$0b00000a@solidwaste>
In-Reply-To: <012401c591a6$9a2e2040$0b00000a@solidwaste>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cutaway@bellsouth.net wrote:
> Anything time stamping things it processes many of will call some sort of
> time function pretty often.  Could happen frequently with certain classes of
> applications.

Right, but if the timestamp granularity is coarse and there's no 
blocking call in between it makes no sense to invoke 
gettimeofday()/time() repeatedly. I was referring to the kind of app 
that abuses them just because somebody is too lazy to reuse the previous 
value - calling gettimeofday() in 10 sequential printf() statements for eg.

There are legitimate scenarios of course, but this doesn't seem to be 
one of them:

15:22:38.825562 kill(2419, SIGRTMIN)    = 0
15:22:38.825748 gettimeofday({1122405758, 825765}, NULL) = 0
15:22:38.825801 gettimeofday({1122405758, 825812}, NULL) = 0
15:22:38.825845 gettimeofday({1122405758, 825856}, NULL) = 0
15:22:38.825888 gettimeofday({1122405758, 825899}, NULL) = 0
15:22:38.825931 time(NULL)              = 1122405758
15:22:38.825968 gettimeofday({1122405758, 825984}, NULL) = 0
15:22:38.826012 gettimeofday({1122405758, 826022}, NULL) = 0
15:22:38.826062 time(NULL)              = 1122405758
15:22:38.826099 time(NULL)              = 1122405758
15:22:38.826142 time(NULL)              = 1122405758
...

Here's another cute one, just in case you thought calling getpid() once 
should be enough ;)

15:31:15.376157 gettimeofday({1122406275, 376177}, NULL) = 0
15:31:15.376206 getpid()                = 2494
15:31:15.376238 getpid()                = 2494
15:31:15.376264 getpid()                = 2494
15:31:15.376291 getpid()                = 2494
15:31:15.376318 getpid()                = 2494
15:31:15.376344 getpid()                = 2494
15:31:15.376371 getpid()                = 2494
15:31:23.723801 getpid()                = 2494
15:31:23.723845 getpid()                = 2494
15:31:23.723873 getpid()                = 2494
15:31:23.723900 getpid()                = 2494
15:31:23.723927 getpid()                = 2494
15:31:23.723954 getpid()                = 2494
15:31:23.723984 getpid()                = 2494
15:31:23.724011 getpid()                = 2494
15:31:23.724038 getpid()                = 2494
15:31:23.724065 getpid()                = 2494
15:31:23.724091 getpid()                = 2494
15:31:23.724118 getpid()                = 2494
15:31:23.724145 getpid()                = 2494
15:31:23.724171 getpid()                = 2494
15:31:23.724198 getpid()                = 2494
15:31:23.724225 getpid()                = 2494
15:31:24.687109 getpid()                = 2494
15:31:24.687159 getpid()                = 2494
15:31:24.687197 getpid()                = 2494
15:31:24.687247 getpid()                = 2494
15:31:24.687283 getpid()                = 2494
15:31:24.687324 getpid()                = 2494
15:31:24.687364 getpid()                = 2494
15:31:24.687402 getpid()                = 2494
15:31:24.687442 getpid()                = 2494
15:31:24.687477 getpid()                = 2494
15:31:24.687512 getpid()                = 2494
15:31:24.687547 getpid()                = 2494
15:31:24.687583 getpid()                = 2494
15:31:24.687662 semop(32769, 0x430e2e0c, 1) = 0

My point: "real world" apps do stupid things.
