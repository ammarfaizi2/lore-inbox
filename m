Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWH2BSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWH2BSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWH2BSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:18:50 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:24417 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750833AbWH2BSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:18:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Bolnzz7dODf8rZlPIQ/lYaRKVMAYp2/n7kOS1vhkG2tUU6B3F4GQnc2e0vhqXI5ssFcX6cuPMkplJjKRQlxK0d/6zkUkv1IXSqKdsTyLpiX2ereaIinI3l/SJ5Lb4ouSRmg6ZBW0D0Nhd/81ShK7kWP/o7386GQNsWxI5oz0j5U=  ;
Message-ID: <44F395DE.10804@yahoo.com.au>
Date: Tue, 29 Aug 2006 11:18:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: Why Semaphore Hardware-Dependent?
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org>
In-Reply-To: <1156750249.3034.155.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2006-08-28 at 03:22 +0800, Dong Feng wrote:
> 
>>Why can't we have a hardware-independent semaphore definition while we
>>have already had hardware-dependent spinlock, rwlock, and rcu lock? It
>>seems the semaphore definitions classified into two major categories.
>>The main deference is whether there is a member variable _sleeper_.
> 
> 
> btw semaphores are a deprecated construct mostly; mutexes are the way to
> go for new code if they fit the usage model of mutexes. And mutexes are
> indeed generic (with a architecture hook to allow a specific operation
> to be optimized using assembly)

That's true, although rwsems are still very important for mmap_sem (if
nothing else). There is not yet an rw/se-mutex.

rwsem is another place that has a huge proliferation of assembly code.
I wonder if we can just start with the nice powerpc code that uses
atomic_add_return and cmpxchg (should use atomic_cmpxchg), and chuck
out the "crappy" rwsem fallback implementation, as well as all the arch
specific code?

That would seem to be able to rid us of vast swaths of tricky asm, and
also double the test coverage of the out of line lib/ code. Should still
generate close to optimal code on i386. The only architectures that might
slightly care are those who's atomics hash to locks (in that case, you'd
really rather take a lock in the rwsem's cacheline than a random atomic
lock... but I don't think incredible parisc/sparc SMP performance is
worth the current situation!)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
