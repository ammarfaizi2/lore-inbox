Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVGQMt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVGQMt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 08:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVGQMt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 08:49:28 -0400
Received: from main.gmane.org ([80.91.229.2]:30402 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261275AbVGQMt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 08:49:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: Volatile vs Non-Volatile Spin Locks on SMP.
Date: Sun, 17 Jul 2005 08:51:54 -0400
Message-ID: <dbdk3i$8si$1@sea.gmane.org>
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl> <20050714051653.GP8907@alpha.home.local> <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl> <BAY108-DAV714C888634D31F28B5A5D93D00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <BAY108-DAV714C888634D31F28B5A5D93D00@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

multisyncfe991@hotmail.com wrote:
> Hello,
> 
> By using volatile keyword for spin lock defined by in spinlock_t, it 
> seems Linux choose to always
> reload the value of spin locks from cache instead of using the content 
> from registers. This may be
> helpful for synchronization between multithreads in a single CPU.
> 
> I use two Xeon cpus with HyperThreading being disabled on both cpus. I 
> think the MESI
> protocol will enforce the cache coherency and update the spin lock value 
> automatically between
> these two cpus. So maybe we don't need to use the volatile any more, right?
> 
> Based on this, I rebuilt the Intel e1000 Gigabit network card driver 
> with volatile being removed,
> but I didn't notice any performance improvement.
> 
> Any idea about this,
> 

Volatile is meaningless as far as threading is concerned.  Technically, its
meaning is implementation defined and since for Linux we're talking about
gcc, I suppose someone could claim it has some meaning although most of us
will have no way of verifying those claims.  You might see some usage
of volatile in the Linux kernel which makes it appear as though it
has some meaning but you might want to be careful in depending on that
since there's no way of knowing if your interpretation of the meaning
is the same as what the authors of that code have in mind.

For synchronization you need memory barriers in most cases and the only
way to get these is using assembler since there are no C or gcc intrinsics
for these yet.  For inline assembler, the convention seems to be to use
the volatile attribute, which I take as meaning no code movement across
the inline assembler code.  It if doesn't mean that then a lot of stuff
is broken AFAICT.

Assuming you're doing this in assembler, using volatile on the C declaration
will have no effect on performance in this case.  You're seeing the most
"recent" value due to the cache implementation.

--
Joe Seigh

