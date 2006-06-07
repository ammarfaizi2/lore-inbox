Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWFGEtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWFGEtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 00:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWFGEtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 00:49:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55491 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750718AbWFGEtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 00:49:31 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
cc: ak@suse.de, "Brendan Trotter" <btrotter@gmail.com>
Subject: Re: NMI problems with Dell SMP Xeons 
In-reply-to: Your message of "Tue, 23 May 2006 15:03:39 +1000."
             <8303.1148360619@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Jun 2006 14:49:11 +1000
Message-ID: <6143.1149655751@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following a suggestion by Brendan Trotter, I ran some more tests to
track down the problem with sending NMI IPI on Dell Xeons.

BIOS Logical    OS ACPI     Cpus    IPI 2             NMI IPI
 Processor                BIOS  OS                 (APIC_DM_NMI)

Enabled         Enabled    4    4  Not delivered   Delivered as NMI
Enabled         Disabled   4    2  Machine reset   Machine reset
Disabled        Enabled    2    2  Not delivered   Delivered as NMI
Disabled        Disabled   2    2  Not delivered   Delivered as NMI

So the killer combination with this motherboard is when the BIOS knows
about logical processors but the OS does not.  Sending IPI 2 or NMI IPI
with that combination kills the machine.  Brendan suggested that the
BIOS is seeing the broadcast NMI on the logical processors which are
not under OS control and that the BIOS cannot cope.

Should we change the x86_64 send_IPI_allbutself() so it is only
delivered to cpus that the OS knows about, instead of doing a general
broadcast.  That would prevent offline or hidden cpus being sent an
interrupt that they are not expecting.  The failing case is
__send_IPI_shortcut, with a cfg of 0xc0c00.

