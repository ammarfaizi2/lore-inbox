Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUHUCDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUHUCDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 22:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268818AbUHUCDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 22:03:45 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:42126 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268816AbUHUCDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 22:03:43 -0400
Message-ID: <4126AD76.5060006@yahoo.com.au>
Date: Sat, 21 Aug 2004 12:03:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Oliver Neukum <oliver@neukum.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, arjanv@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <4125B111.2040308@yahoo.com.au> <20040820014005.73383a43@lembas.zaitcev.lan> <200408201650.07513.oliver@neukum.org> <20040820150257.GC6812@devserv.devel.redhat.com>
In-Reply-To: <20040820150257.GC6812@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, Aug 20, 2004 at 04:50:07PM +0200, Oliver Neukum wrote:
> 
>>>This is what made me suspect that it's the diry memory writeout problem.
>>>It's just like how it was on 2.4 before Alan added PF_MEMALLOC.
>>
>>If we add PF_MEMALLOC, do we solve the issue or make it only less
>>likely? Isn't there a need to limit users of the reserves in number?
> 
> 
> PF_MEMALLOC won't recurse. You might run out of memory however. The old
> world scsi drivers run in the thread of the I/O so are protected already
> by PF_MEMALLOC in those cases, its the thread nature of the USB driver which
> makes it more fun. Unless 2.6 vm is radically different I think PF_MEMALLOC
> is the right thing to set although it would always eventually be better to
> find out who is guilty of the blocking allocation that recurses.
> 
> Are any of the VM guys considering PF_LOGALLOC so you can trace it down 8)
> 
> 

The problem isn't necessarily a recursing allocation - although that
wouldn't be helping. The main thing is an inversion in the PF_MEMALLOC
reserve logic.

Memory goes below pages_min, thread A is in the allocator, sets
PF_MEMALLOC and tries to clean some pages. The USB thread then can't
allocate memory to service these requests because it is not PF_MEMALLOC.

If you make the USB thread PF_MEMALLOC, you solve this problem at the
cost of making the PF_MEMALLOC reserve more fragile. If you're pretty
sure that it only allocates a small, bounded amount of memory then that
may be a good enough fix for now.
