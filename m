Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWFSMr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWFSMr1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWFSMr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:47:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11467 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932416AbWFSMr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:47:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
	<m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
	<20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com>
Date: Mon, 19 Jun 2006 06:47:04 -0600
In-Reply-To: <20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com>
	(Nobuyuki Akiyama's message of "Mon, 19 Jun 2006 16:30:53 +0900")
Message-ID: <m1y7vtia7r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com> writes:

> On Fri, 16 Jun 2006 10:37:05 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> > The processing of the notifier is to make a SCSI adaptor power off to
>> > stop writing in the shared disk completely and then notify to standby-node.
>> 
>> The kernel has called panic no new SCSI operations were execute.
>> I'm not saying don't notify your standby-node
>
> As you say, the kernel does not do anything about SCSI operations.
> But many SCSI adaptors flush their cache after a few seconds pass
> after a SCSI write command is invoked, especially RAID cards.
> To completely stop writing immediately, we should make the adaptor
> power off.

Yes.  Although I don't have a clue what big scsi has to do with a
telco systems.

>> Please walk me through a real world kernel failure, and show me how
>> your millisecond requirement is met.
>> 
>> In the example please answer:
>> - What causes the kernel to call panic?
>> - From the real failure to the kernel calling panic how long
>>   does it take?
>
> For instance, if a file system inconsistency is detected,
> it takes few time until invoking panic.

What is a few time?

> I have seen various kernel failure so far and these will
> unfortunately occur.

Yes kernel failures will occur, people and hardware are imperfect.
But the should be quite rare, on the telco gear you were talking
about.

>> - What actions does the notifier take to tell the other kernel
>>   it is dead.
>
> The operation is only writing to BMC a few times to use IPMI
> interface. That operation using outb is very simple.

Ok.  A simple outb to the BMC through the IPMI interface.

>> - Why do we think the kernel taking that action will be reliable?
>
> I agree the notifier may spoil reliability as compared with doing
> nothing. It depends on quality of the notifier processing.
> But I think the one is needed because it is more effective.

It depends very much on what you are doing.  We have C code that
runs before the dump kernel is started.  It would be absolutely
trivial to modify that C code to tell the IPMI controller that
something has happened.  That operation can happen then after
it has checked a checksum of itself.  

>> - From the point where we call panic() how long does it take until
>>   the kdump kernel is active?
>
> On my box it takes about one second or so, but on a actual enterprise
> system which have many disks(hundreds or more) it becomes more.

Certainly.  But a system with hundreds of disks isn't the system
with a millisecond response time limit.  In general you don't need
to initialize all of your disks just to take a crash dump so even
without optimizing the kernel the kernel things are slow.

Eric
