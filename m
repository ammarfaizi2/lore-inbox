Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUFKXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUFKXtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUFKXtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 19:49:04 -0400
Received: from science.horizon.com ([192.35.100.1]:11064 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S264411AbUFKXtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 19:49:02 -0400
Date: 11 Jun 2004 23:49:01 -0000
Message-ID: <20040611234901.18482.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: speedup strn{cpy,len}_from_user.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  static inline long
>>  strncpy_from_user(char *dst, const char *src, long count)
>>  {
>>          long res = -EFAULT;
>>          might_sleep();
>> -        if (access_ok(VERIFY_READ, src, 1))
>> -                res = __strncpy_from_user_asm(dst, src, count);
>> +        if (access_ok(VERIFY_READ, src, 1)) {
>> +                res = __strncpy_from_user_asm(count, dst, src);
>> +	}
>>          return res;
>>  }

> Shouldn't the access_ok() check be passed `count', rather than `1'?

This deserves a comment, but no.

"count" is the maximum length of the string, not the actual length.
If you passed it to access_ok(), you'd falsely EFAULT a short string
near the end of the address space.

Assuming that there's a guard page at the end of the user address space,
__strncpy_from_user_asm is guaranteed to hit it as part of normal
operations, and will get the fault.
