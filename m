Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946056AbWJaWQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946056AbWJaWQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946057AbWJaWQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:16:14 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:9051 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946056AbWJaWQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:16:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Jk21QM7oF6nZ1gkfcjfUouMGsA/8Q/HDSw3drP2DDJoFfPH2GUIWU0HW+EAvwUyop4d3Y4xy8DAKp6sW/IxgtST8ir7pvA5SKNs9SLUzmfnDcqAy8ewlUUlrQEo1TAE3e/6T2Ob2u1DWpZUWQK2hAHN5WPDL5I1ezLmgHSpfAWE=  ;
Message-ID: <4547CB25.3080603@yahoo.com.au>
Date: Wed, 01 Nov 2006 09:16:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
References: <1162199005.24143.169.camel@taijtu> <4546FA81.1020804@cosmosbay.com> <45471A05.20205@yahoo.com.au> <200610311151.33104.dada1@cosmosbay.com>
In-Reply-To: <200610311151.33104.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

>On Tuesday 31 October 2006 10:40, Nick Piggin wrote:
>
>
>>Uh, there is nothing that says mutex_unlock or any unlock
>>functions contain an implicit smp_mb(). What is given is that the
>>lock and unlock obey aquire and release memory ordering,
>>respectively.
>>
>>a = x;
>>xxx_unlock
>>b = y;
>>
>>In this situation, the load of y can be executed before that of x.
>>And some architectures will even do so (i386 can, because the
>>unlock is an unprefixed store; ia64 can, because it uses a release
>>barrier in the unlock).
>>
>
>Hum... it seems your mutex_unlock() i386/x86_64 copy is not same as mine :)
>

OK, replace xxx with mutex, and what I've said still holds true for ia64.

>Maybe we could document the fact that mutex_{lock|unlock}() has or has not an 
>implicit smp_mb().
>

It does not, none of the unlock functions ever have.

>If not, delete smp_mb() calls from include/asm-generic/mutex-dec.h 
>

They should be deleted (and from mutex-xchg). NOT because there is no 
need for
a memory barrier, but because the atomic_alter_value_and_return_something
functions always provide a barrier before and after the operation, as per
Documentation/atomic_ops.txt

Again, lock / unlock operations require acquire / release consistency. 
This is a
memory ordering operation. It is not equivalent to smp_mb, though.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
