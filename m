Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWDHU1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWDHU1V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWDHU1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:27:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:52183 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751403AbWDHU1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:27:20 -0400
Message-ID: <44381C9A.3050502@zytor.com>
Date: Sat, 08 Apr 2006 13:27:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, Herbert Xu <herbert@gondor.apana.org.au>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: + git-klibc-mktemp-fix.patch added to -mm tree
References: <200604080707.k38778VV023208@shell0.pdx.osdl.net> <20060408201412.GA26946@mars.ravnborg.org>
In-Reply-To: <20060408201412.GA26946@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sat, Apr 08, 2006 at 12:05:54AM -0700, akpm@osdl.org wrote:
>> diff -puN usr/dash/mkbuiltins~git-klibc-mktemp-fix usr/dash/mkbuiltins
>> --- 25/usr/dash/mkbuiltins~git-klibc-mktemp-fix	Sat Apr  8 14:51:11 2006
>> +++ 25-akpm/usr/dash/mkbuiltins	Sat Apr  8 14:51:11 2006
>> @@ -37,7 +37,7 @@
>>  
>>  tempfile=tempfile
>>  if ! type tempfile > /dev/null 2>&1; then
>> -	tempfile=mktemp
>> +	tempfile="mktemp /tmp/tmp.XXXXXX"
> 
> Shouldn't that be:
>> +	tempfile="$(mktemp /tmp/tmp.XXXXXX)"
> 

No, it's invoked later on as:

temp=$($tempfile)
temp2=$($tempfile)

Either which way; I have a better fix for the bison issue (this all has 
to do with the fact that make's handling of tools that output more than 
one file at a time is at the very best insane); however, I'm getting 
rather unhappy with some of the code in dash.

In particular, mksyntax.c seems to assume it runs on the same machine 
that the resulting code is going to execute on, for example, it tries to 
detect whether or not "char" is signed, but that doesn't work when 
cross-compiling.

dash isn't actually necessary in the in-kernel build, although it's a 
very nice bonus for customizing initramfs to have a shell to glue things 
together with.

Herbert: can the code be restructured with appropriate casts so that 
signed/unsigned is factored out of mksyntax?  As it currently stands, 
it's not cross-compile-safe, which is unacceptable.

	-hpa
