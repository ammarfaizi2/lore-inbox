Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVIUUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVIUUYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVIUUYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:24:07 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:40610 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750797AbVIUUYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:24:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=pWW0JiMwqV8uWkXJPbaOLiCKHnvmfiQEIr/RJ48wVmtphjI+bSIYaYrETjhi0P/YWMmLlLRGvxaaOwRIlH/PCVuF4pBnyzoseESE9mkGItljgyENbb3+hn4H2BgK7b+58PDlcxj07615ZfqC1LXJZwE3OVbZttFxpZWLQ8L5ewo=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while atomic
Date: Wed, 21 Sep 2005 22:22:50 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <200509211923.21861.blaisorblade@yahoo.it> <20050921172908.10219.57644.stgit@zion.home.lan> <20050921124957.437cf069.akpm@osdl.org>
In-Reply-To: <20050921124957.437cf069.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509212222.50653.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 21:49, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> The in_atomic() test in x86's do_page_fault() is in fact a message passed
> into it from filemap.c's kmap_atomic().
Ok, this can be ok, but:
> It has accidental side-effects, 
> such as making copy_to_user() fail if inside spinlocks when
> CONFIG_PREEMPT=y.
Sorry, but should it ever succeed inside spinlocks? I mean, should it ever 
call down() inside spinlocks? (We never do down_trylock, and ever if we did 
the x86 trick, that wouldn't make the whole thing safe at all - they still 
take the spinlock and potentially sleep. And it's legal only if no spinlock 
is held).

Even if spinlocks don't always trigger in_atomic() - which means that we'd 
need to have a better fix for this.

(Btw, I took the above reasoning from something said, as an aside, on LWN.net 
kernel page, about the FUTEX deadlock on mm->mmap_sem of ~ 2.6.8 - yes, it 
wasn't the full truth, but not totally dumb).

> So I think this change is only needed if UML implements kmap_atomic, as in
> arch/i386/mm/highmem.c, which it surely does not do?
NACK, see above.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
