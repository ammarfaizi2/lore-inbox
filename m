Return-Path: <linux-kernel-owner+w=401wt.eu-S1751618AbXAPSNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbXAPSNt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbXAPSNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:13:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44980 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbXAPSNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:13:48 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Tony Luck <tony.luck@intel.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<45AD02FF.605@zytor.com>
Date: Tue, 16 Jan 2007 11:12:44 -0700
In-Reply-To: <45AD02FF.605@zytor.com> (H. Peter Anvin's message of "Tue, 16
	Jan 2007 08:53:19 -0800")
Message-ID: <m164b6den7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC list trimmed.

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>>
>> - Removal of sys_sysctl support where people had used conflicting sysctl
>>   numbers. Trying to break glibc or other applications by changing the
>>   ABI is not cool.  9 instances of this in the kernel seems a little
>>   extreme.
>>
>
> It would be highly advantageous if we could have a file that acts as a central
> registry of architectural sysctl numbers *and have the numbers in the kernel
> derived from there*.  As I've said before, I don't really think sys_sysctl is
> any worse than ad hoc system calls (sys_mips and the like), but the real problem
> is that there are architectural and non-archtectural numbers, and they're mixed
> in all over the place.

Conflicting with generic sys_sysctl numbers is a problem.  Period.
All of the conflicts were with the binary version of:
/proc/sys/kernel or /proc/sys/dev/cdrom
Which are respectively: 1 and 7/1.

The conflicts were because people were simply not-trying.  I didn't
look hard and scrutinize things I just stumbled on them while C99
converting the tables.  So I could remove the stupid proc_dir_entry
field from ctl_table.

All you need for an architecture depending sys_sysctl is your own
top level architectural number.  After that you get a unique path.
It's easy.  If anyone had really cared these problems simply would
not have happened because in most cases the conflicting sysctl
were not exported to user space because they were masked, or
similarly architecture entities like /proc/sys/kernel/ostype and
/proc/sys/kernel/osrelease were masked.

Currently I'm happy with the current maintenance situation if someone
does not care to deal with the binary interface they don't have to.
And we can just mark them CTL_UNNUMBERED in the table.  I would say
that is the real problem with the entries I fixed, they didn't want
to use the binary interface in the first place.

> I think it would be fair to say that if they're not in <linux/sysctl.h> they're
> not architectural, but that doesn't resolve the counterpositive (are there
> sysctls in <linux/sysctl.h> which aren't architectural?  From the looks of it, I
> would say yes.)  Non-architectural sysctl numbers should not be exported to
> userspace, and should eventually be rejected by sys_sysctl.

This last bit doesn't make much sense.  I believe you are saying all sysctl
numbers should be per architecture.

To your query about what the state of sys_sysctl is please go look
there are only 79 instances of register_sysctl_table in the kernel.
It's big but in an hour or two you can look at everything.  Or at least
read my patchset.

At this point there are no significant users of sysctl in the architecture
code.  The only big user of sysctl is the network stack and it uses sysctl
responsibly.  

The biggest blunders in using sysctl happen in the per architecture code
and it is very much because the people writing the code didn't even
try to get the binary interface right.

So I think making sysctl numbers per architecture is a hideous idea because
that is not where the maintenance is happening, and instead it places a big
burden on people who by the evidence don't care enough to get it right.

I think a much better idea is to maintain the current situation and just
insist that people use CTL_UNNUMBERED for their binary number when
they don't care about the binary interface.  That is easy and it works.

Personally I expect the binary interface to largely remain fixed with exactly
the set of non-architectural numbers we have today with any new sysctl users
not allocating a sysctl number.

Eric
