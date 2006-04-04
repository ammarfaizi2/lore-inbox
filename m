Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWDEEii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWDEEii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 00:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWDEEii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 00:38:38 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:45991 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750805AbWDEEih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 00:38:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=o287n1YvicT2cSTiWteii+fSdQ9M0JEfQgZvjGtIVWPZMMt3Ln3ZlhIW38hw9EE4UBRmeC5k7egZB4wMwQknF1nhbDPbWJIHqvh0pGLtqgG8bGRD9L3uZLXSRek0raDyA6KNbIcldy4/HiMiOdsxCnge9emfuWTKbRfv2RND3Sk=  ;
Message-ID: <4432515F.4030108@yahoo.com.au>
Date: Tue, 04 Apr 2006 20:58:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Keys: Improve usage of memory barriers and remove IRQ
 disablement
References: <20060404095529.31311.3892.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060404095529.31311.3892.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

> diff --git a/security/keys/key.c b/security/keys/key.c
> index 99781b7..d8a6e00 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -619,6 +619,7 @@ void key_put(struct key *key)
>  	if (key) {
>  		key_check(key);
>  
> +		smp_mb__before_atomic_dec();
>  		if (atomic_dec_and_test(&key->usage))
>  			schedule_work(&key_cleanup_task);

Shouldn't be needed: Documentation/atomic_ops.txt specifies that any atomic_
which both modifies its atomic operand and returns something is to be a full
barrier before and after the operation.

This misuse occurs a few times in core code, which makes it a bit confusing.

However, I think it is nice to add a comment if these implicit barriers are
used, if the purpose is not really obvious.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
