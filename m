Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTAXGMP>; Fri, 24 Jan 2003 01:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbTAXGMP>; Fri, 24 Jan 2003 01:12:15 -0500
Received: from mx2.mail.ru ([194.67.57.12]:25105 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id <S267560AbTAXGMH>;
	Fri, 24 Jan 2003 01:12:07 -0500
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: "Brian King" <brking@charter.net>
Cc: "James Stevenson" <james@stev.org>, linux-kernel@vger.kernel.org
Subject: Re[2]: OOPS in idescsi_end_request
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Fri, 24 Jan 2003 09:21:16 +0300
In-Reply-To: <3E30AFE0.5060400@charter.net>
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E18bxDI-000Ic3-00@f15.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Can the interrupt handler even look at the request structure in this 
> scenario though? 

Which request? IDE or SCSI? It must look at IDE request of course, 
because it is request that is being served. As far as SCSI request is 
concerned, the problem remains the same even if it happens later, not 
in interrupt handler.

> I can't say I know much about the ide subsystem but it 
> seems like after ide-scsi returns success on the reset function then it 
> should have already pushed scsi_done for the op and should not be 
> looking at the request structure. 

Exactly. That is what I have suggested. The only problem is, there 
appear to be no easy way to discard request that is currently being 
executed. So my suggestion was a workaround to prevent looking at possibly already invalid request field.

The point is you cannot just discard current IDE request. The seems to be no equivalent of SCSI abort function.

> Would it be possible to have the 
> ide-scsi reset routine invoke ide_do_reset? 

It happens anyway later and is condirmed in kernel output. It is done 
from SCSI layer, SCSI first attempts to abort currently running 
command and then calls reset (on device, bus and host if needed).

> Is there a problem with 
> multiple callers of ide_do_reset? 

It is serialised if this is what you ask.

> I would think the right solution would 
> be to do this and not return success until the reset was successful and 
> the op was sent back to the mid-layer.
> 

Current IDE provides no way to wait for reset success. It just sends 
reset and then polls device to find out if reset was successful until 
time out expires. That is the main problem. My first reaction was as 
well "we must wait for reset completion". It is simply not possible 
without revamping IDE code (please, correct me if I am wrong). Besides
it does not help us in any way - even when reset is complete you still
must deal with old IDE request. This is exactly what happens here.

The problem is not that we do not call reset, but that we do not
really abort IDE command. We must either do that or simulate it.

> Andrey Borzenkov wrote:
> > As long as we cannot easily abort IDE request (correct me if I am wrong) the workaround seems to be to mark current request as aborted in idescsi_abort and ignore it later in idescsi_end_request, i.e. something like (with new flag PC_ABORTED)
> > 
> > struct request *rq = HWGROUP(idescsi_drives[cmd->target])->rq;
> > idescsi_pc_t *pc = (idescsi_pc_t *) rq->buffer;
> > pc->flags |= PC_ABORTED;
> > 
> > and later on assume we can ignore SCSI layer completely in this case in idescsi_end_request, just do general cleanup.

Forget this, it is nonsene of course. When idescsi_abort is called,
the request may not even be services yet. So it may be needed to add
pointer to IDE request in idescsi_pc_t and then search for request
in device queue. And properly lock the whole story of course.

Would you agree to test the patch (possibly next week).

cheers

-andrey

> > 
> > If you can reliably reproduce the problem you could give it a try.
> > 
> > Anybody sees yet another race condition here? :))
> > 
> > -andrey 
> > 
> > 
> >>While burning a CD tonight I ended up taking an oops on my system. I had 
> >>the lkcd patch applied to my 2.4.19 kernel, so I was able to look at the 
> >>  oops after my system rebooted. After digging into it a little and 
> >>looking at the ide-scsi code I think I found the problem but am not 
> >>sure. How can idescsi_reset simply return SCSI_RESET_SUCCESS to the scsi 
> >>mid layer? I think what is happening is that a command times out, 
> >>idescsi_abort is called, which returns SCSI_ABORT_SNOOZE. Later on 
> >>idescsi_reset gets called, which returns SCSI_RESET_SUCCESS. At this 
> >>point the scsi mid-layer owns the scsi_cmnd and returns the failure back 
> >>up the chain. Later on, the command gets run through 
> >>idescsi_end_request, which then tries to access the scsi_cmnd structure 
> >>which is it no longer owns.
> >>
> >>Any help is appreciated. I have a complete lkcd dump of the failure if 
> >>anyone would like more information...
> >>
> >>-Brian King
> >>
> >>
> >>Here is the last bit in the log buffer:
> >>
> >>     <4>scsi : aborting command due to timeout : pid 2534304, scsi0, 
> >>channel 0, id 1, lun 0 Write (10) 00 00 01 1e 91 00 00 1b 00
> >>     <4>hdk: timeout waiting for DMA
> >>     <4>ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> >>     <4>hdk: status timeout: status=0xd8 { Busy }
> >>     <4>hdk: drive not ready for command
> >>     <4>hdk: ATAPI reset complete
> >>     <4>hdk: irq timeout: status=0x80 { Busy }
> >>     <4>hdk: ATAPI reset complete
> >>     <4>hdk: irq timeout: status=0x80 { Busy }
> >>     <1>Unable to handle kernel NULL pointer dereference at virtual 
> >>address 00000184
> >>     <4> printing eip:
> >>     <4>e0fd22f1
> >>     <1>*pde = 00000000
> >>     <4>Oops: 0002
> >>     <4>CPU:    0
> >>     <4>EIP:    0010:[<e0fd22f1>]    Tainted: PF
> >>     <4>EFLAGS: 00010046
> >>     <4>eax: 00000000   ebx: 00000000   ecx: dfef8000   edx: c75bcbc0
> >>     <4>esi: 00000080   edi: c0491938   ebp: d5908000   esp: c0435ea4
> >>     <4>ds: 0018   es: 0018   ss: 0018
> >>     <4>Process swapper (pid: 0, stackpage=c0435000)
> >>     <4>Stack: c0491938 00000000 00000000 c0491938 00000088 000001f4 
> >>c03349e2 c75bcbc0
> >>     <4>       ce0a3b80 c0491938 00000080 00000080 c75bcbc0 c0222d6c 
> >>00000000 c1671580
> >>     <4>       00000080 c04918f4 c0491938 c0434000 c1671580 e0fd2550 
> >>c0223b30 c0491938
> >>     <4>Call Trace:    [<c0222d6c>] [<e0fd2550>] [<c0223b30>] 
> >>[<c0223990>] [<c0127af0>]
> >>     <4>  [<c01233d4>] [<c01232a6>] [<c01230ed>] [<c010a97f>] 
> >>[<c010d173>] [<c0106f80>]
> >>     <4>  [<c0106fa3>] [<c0107012>] [<c0105000>]
> >>     <4>
> >>     <4>Code: c7 80 84 01 00 00 00 00 07 00 75 72 9c 5e fa bb 00 e0 ff ff
> >>
> >>
> >> From lkcd:
> >>
> >>================================================================
> >>STACK TRACE FOR TASK: 0xc0434000 (swapper)
> >>
> >>  0 [ide-scsi]idescsi_end_request+129 [0xe0fd22f1]
> >>TRACE ERROR 0x800000000
> > 
> > 
> > 
> 
> 
> -- 
> Some days it's just not worth chewing through the restraints...
> 
> 
