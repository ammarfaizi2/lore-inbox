Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWIMTZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWIMTZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWIMTZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:25:55 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:64657 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750938AbWIMTZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:25:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DpewvwCA0PIdjxEDvm9L/ew0JkoDLypNKowdj8MphrYjhz079wiPWJmcoxh5j2ovRH25gcwjEMBEuJngNUCpAJAWB6Q04b+/7sBe81vuTezaZVT/9LaA0B0kZUNGiGeO7R+LB/pSVX396WjOfX5lTIifj75kA2TA67Ibs8eqSIc=  ;
Message-ID: <45085B31.3080504@yahoo.com.au>
Date: Thu, 14 Sep 2006 05:25:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
References: <45084833.4040602@yahoo.com.au>  <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <22461.1158173455@warthog.cambridge.redhat.com>
In-Reply-To: <22461.1158173455@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>+	while ((tmp = atomic_read(&sem->count)) >= 0) {
>>+		if (tmp == atomic_cmpxchg(&sem->count, tmp,
>>+				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> 
> 
> NAK for FRV.  Do not use atomic_cmpxchg() there as it isn't strictly atomic
> (FRV only has one strictly atomic operation: SWAP).  Please leave FRV as using
> the spinlock version which is more efficient on UP.

 From what I can read of the asm and the documentation, it is atomic. If
it were not atomic then it is badly broken.

BTW. if atomic_cmpxchg is slower than a local_irq_disable+local_irq_enable
on your architecture then you have probably not implemented cmpxchg well
because you may as well just implement it with local_irq_disable.

> Please also show benchmarks to show the performance difference between your
> version and the old version before Ingo messed it up and made everything
> unconditionally out of line without cleaning the inline asm up.

I'm not so interested in counting cycles so much as consolidating duplicated
code and reduce complexity and icache footprint. I'll leave you to benchmark
Ingo's changes if you're concerned about them.

Of course I will benchmark the end results when I finish the patch, though.

> If you are going to generalise, you should get rid of everything barring the
> spinlock-based version and stick with that.  It will cost you performance
> under some circumstances, but it's better under others than attempting to use
> atomic_cmpxchg() which may not really exist on all archs.

atomic_cmpxchg exists on all architectures.

I'm happy to go with the spinlock version (it is even simpler), but I will
have to benchmark that. I have seen small slowdowns there in high contention
situations but it was improved with my rwsem scalability patch. If
performance is no different between the two, then the spinlock version is a
no brainer.

> You've also caused another problem: the spinlock based version permits up to
> 2^31 - 1 readers at one time, the inline optimised version, on a 32-bit arch,
> will only permit up to 2^16 - 1 at most.  By doing this to x86_64, you've
> reduced the number of processes it can support.

Yep, Christoph pointed this out. I'll fix it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
