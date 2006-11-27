Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757078AbWK0GR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbWK0GR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 01:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757080AbWK0GR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 01:17:29 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:7551 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1757078AbWK0GR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 01:17:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EL7zxuFzlJDvhbmNjPsi0TALV0dtQJ8lVnOkprHsN0Ah30Jh3Tr7ufidVDhemWjAw3ksq2ExHSxFzXadpvYswyEHsJxHeCblp8UTQPz8fxId7pAULzle/wbkQ8kkjCopVfncOHcnp999LnXJXANP14sfuoi8wfQ1eXWUEt+uW1M=  ;
X-YMail-OSG: swumzZwVM1kJEklUVORH1nFn6neVkneD5jgB4C9jNGb3697semcEfJD6bsSMGVossCdhwwUQUHfOUfBfbDSi7MT3BUHH60O.B5oeGBrVKz6p7_KwgolTew--
Message-ID: <456A9115.3020101@yahoo.com.au>
Date: Mon, 27 Nov 2006 18:17:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Orlov <bugfixer@list.ru>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc4-mm1: writev() _functional_ regression
References: <20061112223024.GA4104@nickolas.homeunix.com> <20061112154553.459d6a63.akpm@osdl.org>
In-Reply-To: <20061112154553.459d6a63.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 12 Nov 2006 17:30:24 -0500
> Nick Orlov <bugfixer@list.ru> wrote:
> 
> 
>>Andrew,
>>
>>Somewhere in between 2.6.18-mm3 and 2.6.19-rc4-mm1 writev() got screwed.
>>It does not accept zero-length segments anymore.
>>
>>Bad thing that it is extremely easy to trigger (even w/o explicit writev calls).
>>For example the following innocent program will fail with 2.6.19-rc4-mm1:
>>
>>======================
>>#include <string.h>
>>#include <fstream>
>>
>>int main()
>>{
>>  char buf[1024];
>>  memset(buf, 'A', sizeof(buf));
>>  std::ofstream ofs("test");
>>  //ofs << 1 << '\n';
>>  ofs.write(buf, sizeof(buf));
>>  return 0;
>>}
>>======================
>>
>>
>>Here is the corresponding part if strace:
>>
>>======================
>>open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
>>writev(3, [{NULL, 0}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = -1 EFAULT (Bad address)
>>close(3)                                = 0
>>======================
>>
>>
>>With 2.6.18-mm3 it works
>>
>>======================
>>open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
>>writev(3, [{NULL, 0}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = 1024
>>close(3)                                = 0
>>======================
>>
>>
>>It works with 2.6.19-rc4-mm1 _if_ zero-length segments are eliminated
>>(by uncommenting ofs << 1 << '\n'):
>>
>>======================
>>open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
>>writev(3, [{"1\n", 2}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = 1026
>>close(3)                                = 0
>>======================
>>
>>
>>Given that _all_ applications using C++ streams are potentially affected
>>I think it's better to preserve the previous behavior even if it is
>>something from "undefined behavior world" (or a plain bug).
>>
>>The bug is quite dangerous (I was really close to wipe out my mp3 collection).
>>
> 
> 
> OK, thanks.  Those patches do need more work.  I'll shelve them for a while.

Yeah, this just needs some kind of 0 size check in the access check
(arguably fault_in_pages_readable could check for zero size, but it could
go into the caller just as easily).

Thanks for reporting.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
