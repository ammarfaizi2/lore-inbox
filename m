Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWJRTmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWJRTmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbWJRTmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:42:35 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:6518 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422773AbWJRTme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:42:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ht3HODov7PKmuJVmQ0IbT5EmRAqJEmDm9IOX+sn2iNEHAH4TBGyTfqVeJUYTA4VaKTfGJ5FWcDo6L3FIkFOX7XhOFtw3NRFmGQwxTQ5wZg2BDjHl+ZDcNi3trD3zto9Wh6PxQ6QAreZxlCcyqsgdlh0wkAIGrF/hghyAw6jutfc=  ;
Message-ID: <453683A6.9090106@yahoo.com.au>
Date: Thu, 19 Oct 2006 05:42:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Gabriel C <nix.or.die@googlemail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org> <45367210.4040507@googlemail.com> <200610182118.31371.rjw@sisk.pl> <4536818E.3060505@fr.ibm.com>
In-Reply-To: <4536818E.3060505@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
> Rafael J. Wysocki wrote:
> 
>>On Wednesday, 18 October 2006 20:27, Gabriel C wrote:
>>
>>>Andrew Morton wrote:
>>>
>>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
>>>>  
>>>
>>>Hello,
>>>
>>>I got this build error with 2.6.19-rc2-mm1:
>>>
>>>CHK include/linux/compile.h
>>>UPD include/linux/compile.h
>>>CC init/version.o
>>>LD init/built-in.o
>>>LD .tmp_vmlinux1
>>>mm/built-in.o: In function `xip_file_write':
>>>(.text+0x19a47): undefined reference to `filemap_copy_from_user'
>>>make: *** [.tmp_vmlinux1] Error 1
>>
>>\metoo
> 
> 
> Here's a fix i sent to andrew.
> 
> C.
> 
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> ---
>  mm/filemap_xip.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: 2.6.19-rc2-mm1/mm/filemap_xip.c
> ===================================================================
> --- 2.6.19-rc2-mm1.orig/mm/filemap_xip.c
> +++ 2.6.19-rc2-mm1/mm/filemap_xip.c
> @@ -317,7 +317,7 @@ __xip_file_write(struct file *filp, cons
>  			break;
>  		}
>  
> -		copied = filemap_copy_from_user(page, offset, buf, bytes);
> +		copied = filemap_copy_from_user_atomic(page, offset, buf, bytes);
>  		flush_dcache_page(page);
>  		if (likely(copied > 0)) {
>  			status = copied;

This fix will work. You should really call the non atomic version though, just
so it is clear (and maybe some architectures care).

Because we must service a fault if it happens here. The fault_in_pages_readable
and comments are wrong AFAIKS.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
