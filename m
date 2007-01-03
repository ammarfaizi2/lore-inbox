Return-Path: <linux-kernel-owner+w=401wt.eu-S1753681AbXACCZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbXACCZ0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbXACCZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:25:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:52023 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbXACCZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:25:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=jPdUVY4jUkkazWVPN/+JMouDTvwK//u6SH3iQ4ozbp53NyxTcfmeR9u4Hq6DUliYdFefvb4ic0Wp+aciWtKtoIG+sD5LecBNSRHwqfo4sA988qnv9/4twVSNUknRDFN7t1QHXevn/DPQcyTzpzHo99UApxyaKXlXcOvd/XQBUUM=
Message-ID: <459B140C.1060401@gmail.com>
Date: Wed, 03 Jan 2007 11:25:16 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: bbee <bumble.bee@xs4all.nl>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com> <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org>
In-Reply-To: <loom.20070103T020347-255@post.gmane.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ing linux-ide]

bbee wrote:
> Tejun Heo <htejun <at> gmail.com> writes:
>> Andrew Lyon wrote:
>>> My system is gigabyte ds3 motherboard with onboard SATA JMicron
>>> 20360/20363 AHCI Controller (rev 02), drive connected is WDC
>>> WD740ADFD-00 20.0, I am running 2.6.18.6 32 bit, under heavy i/o I get
>>> the following messaegs:
>>>
>>> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
>>> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
>>>
>>> Is this condition dangerous?
>> Not usually.  Might indicate something is going wrong in some really
>> rare cases.  I think vendors are getting NCQ right these days.  Maybe
>> it's time to remove that printk.
> 
> Hi Tejun, it's funny you should say that, because in the subthread at
> http://thread.gmane.org/gmane.linux.ide/10264/focus=10334
> you seemed to have major issues with this very error and were saying there
> could even be data corruption.

Yeap, I have major issues with SDB FISes which contains spurious
completions but most other spurious interrupts shouldn't be dangerous
and I haven't seen spurious completions for quite some time, so I was
thinking either removing the message or printing it only on SDB FIS
containing spurious completions.

But, Andrew Lyon *is* reporting spurious completions.  Now I just wanna
update those printks such that more info is reported only on spurious
SDB FISes.

> I too have this error, on a Asrock 939Dual-SATA2 board wich has the same
> controller. Syslog lines like
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0xf4)
> every so often.
> 
> However, in my case it gets a lot worse. The following happens infrequently,
> usually within 15 days of uptime on a light I/O load:
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (irq_stat 0x48000000, interface fatal error)
> ata1.00: tag 0 cmd 0xea Emask 0x12 stat 0x37 err 0x0 (ATA bus error)
> ata1: soft resetting port
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: qc timeout (cmd 0xec)
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> ata1.00: revalidation failed (errno=-5)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: hard resetting port
> ata1: SATA link down (SStatus 0 SControl 300)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: hard resetting port
> ata1: SATA link down (SStatus 0 SControl 300)
> ata1.00: disabled
> ata1: EH complete
> ata1.00: detaching (SCSI 0:0:0:0)
> scsi 0:0:0:0: rejecting I/O to dead device
> 
> The drive then dissapears from the system. This is not preceded by any
> spurious interrupt messages, but I have a hunch it is related because
> following your grave comments in the referenced thread, I looked for a kernel
> option to disable NCQ. Astonished to find none, I changed the source using the
> flag you added in this patch:

Yeah, it usually indicates lousy NCQ implementation on drive's side.  I
can't tell whether the drive going offline is directly related tho.

> http://article.gmane.org/gmane.linux.ide/11527
> With NCQ disabled, the spurious interrupt messages as well as the exceptions
> go away.

Hmmm... How certain are you about disabling NCQ fixing the problem?  Are
other conditions controlled?  How many times did you verify the fix?  If
you undo the change and leave everything else the same, does the
exception come back?  Can you post the results of 'dmesg' and 'hdparm -I
/dev/sdX'?

> This has been happening for a few months on a box whose log I'd been neglecting
> and I hadn't even noticed the issue since the drive is part of a md array. The
> drive would get re-detected when I rebooted the box and md would rebuild the
> array.
> 
> Here comes the weird part. When I discovered the problem, I backtracked through
> the syslog to see when the problems started. They started a few months ago when
> I added a DVB card to the system (it is a mythtv box). I noticed in Andrew's
> dmesg that he also has a DVB card.
> 
> Could the DVB subsystem have anything to do with this? I realize the systems
> are completely unrelated..
> Perhaps the JMicron chip has noise issues? These are often triggered by adding
> tuner cards..
> 
> It probably won't make any difference to system performance, but it would be
> nice if we could resolve this so I can re-enable NCQ and stop patching my
> kernels ;)

Yeap, I'm definitely interested in resolving this problem.  It's not
likely but possible that the *controller* is responsible for spurious
interrupts.

Thanks.

-- 
tejun
