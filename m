Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWIMTzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWIMTzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWIMTzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:55:13 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:40197 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751154AbWIMTzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:55:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 13 Sep 2006 19:55:05.0355 (UTC) FILETIME=[81F85DB0:01C6D76E]
Content-class: urn:content-classes:message
Subject: Re: Assignment of GDT entries
Date: Wed, 13 Sep 2006 15:55:00 -0400
Message-ID: <Pine.LNX.4.61.0609131523390.28091@chaos.analogic.com>
In-Reply-To: <450854F3.20603@goop.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Assignment of GDT entries
thread-index: AcbXboIE1DOT6hHSRD+M2ztf+niHGg==
References: <450854F3.20603@goop.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Andi Kleen" <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Zachary Amsden" <zach@vmware.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Michael A Fetterman" <Michael.Fetterman@cl.cam.ac.uk>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2006, Jeremy Fitzhardinge wrote:

> What's the rationale for the current assignment of GDT entries?  In
> particular, this section:
>
> *   0 - null
> *   1 - reserved
> *   2 - reserved
> *   3 - reserved
> *
> *   4 - unused			<==== new cacheline
> *   5 - unused
> *
> *  ------- start of TLS (Thread-Local Storage) segments:
> *
> *   6 - TLS segment #1			[ glibc's TLS segment ]
> *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
> *   8 - TLS segment #3
> *   9 - reserved
> *  10 - reserved
> *  11 - reserved
>
>
> What are entries 1-3 and 9-11 reserved for?  Must they be unused for
> some reason, or is there some proposed use that has not been impemented yet?
>

In the ix86, the first descriptor in the GDT is not used. The are
TWO 32-bits words for each GDT entry. The GDT numbers are the offset from
the first, so they are numbered as offsets, there are multiplied by
8, the size of a GDT, by the processor when they are used to set segment
registers. This table is only accessed by the CPU when the LGDT
instruction in executed. When a segment register is set, the invisible
part of the segment, the top 16 bits, contains the information extracted
from the GDT, so no further access is necessary. This means that
it has nothing to do with cache-lines.

The entries 1 through 3 are used during the boot sequence, see
setup.S, search for "gdt" around line 983.

> Also, is there a particular reason kernel GDT entries start at 12?
> Would there be a problem in using either 4 or 5 for a kernel GDT descriptor?
>
> I'm asking because I'd like to use one of these entries for the PDA
> descriptor, so that it is on the same cache line as the TLS
> descriptors.  That way, the entry/exit segment register reloads would
> still only need to touch two GDT cache lines.  Would there be a real
> problem in doing this?
>

You can add other GDT entries up to 8192 if you want. If you set the
base, limit, type, etc., to something that's different than the
kernel DS, SS, CS, etc., then you need to reload the segment registers
and if the base is different, the code offset will be WRONG so you
will need to tell the linker the new relocation information.

I can't imagine a reason why you'd want to do this.

> Thanks,
>    J
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
