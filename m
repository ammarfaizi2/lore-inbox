Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWHOMXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWHOMXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHOMXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:23:03 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:56504 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S932069AbWHOMXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:23:00 -0400
Message-Id: <44E1D8CD.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 15 Aug 2006 14:23:09 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@muc.de>, "Andrew Morton" <akpm@osdl.org>
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>, <torvalds@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
	/usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
 <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
 <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com>
 <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com>
 <20060805024947.GE13393@redhat.com> <20060805064727.GF13393@redhat.com>
 <6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com>
 <20060806123243.826105fc.akpm@osdl.org> <20060807012638.GA42404@muc.de>
In-Reply-To: <20060807012638.GA42404@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >  [<c0171577>] vfs_write+0xcd/0x179
>> >  [<c0171c20>] sys_write+0x3b/0x71
>> >  [<c010318d>] sysenter_past_esp+0x56/0x8d
>> This "unwinder stuck" thing seems to be very common.
>
>Yes, there are still a lot of bugs in the unwind annotation
>unfortunately.
>
>We're also slowly discovering that some things we do cannot
>even be expressed in CFI, so some code has to change.
>
>> 
>> It's a false-positive in this case - the backtrace was complete.  It
would
>> be good if we could make the did-we-get-stuck detector a bit
smarter.  Even
>> special-casing "sysenter_past_esp" would stop a lot of this..
>
>Actually it's not completely false in this case -- it should
>have reached user mode and stopped there, but for some reason
>I didn't and already stopped still in the kernel.
>
>Most likely the CFI annotation for that sysenter path is not
complete.

They seem to be correct, at least on the default path. I have no
problem with it finding and stopping at the first user frame; I'd like
to note, however, that this (a) is *with* the patches I sent earlier
today (they didn't change anything annotation-wise) and (b) the
size reported for sysenter_past_esp is slightly different on my
system (above trace says 0x8d, mine is 0x79), while the offsets
are 0x56 in both cases. I'd assume the size delta is due to
CONFIG_TRACE_IRQFLAGS, which then I can't see how it would
make a difference other than in the case where
trace_hardirqs_{on,off} themselves would fault (as their call
sites are un-annotated), which doesn't appear to be the case
here.

Again, if "unwinder stuck" messages appear, I'll need a raw
stack dump to accompany the stack trace.

>It's on my todo list to investigate but I still hope Jan does it first
;-)

Jan
