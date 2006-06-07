Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWFGPS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWFGPS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWFGPS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:18:58 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:9366 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932250AbWFGPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:18:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UN0kQAVytUoRc7lVq11EDWI2TkFT6isjLbn7KrqrxWKjRGQIYOURZJywbodr00Jq+isoqldQ+3x6z3hgvOTYEkD2Xb1FPGsqDvPFuZQxWSyFQEy6CmNEaVpnvFianHShae2FMO2xguH3NU8kmNxC+ky0J0ir4yuqywR1mZoQLo4=
Message-ID: <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com>
Date: Wed, 7 Jun 2006 15:18:57 +0000
From: "Brendan Trotter" <btrotter@gmail.com>
To: "Keith Owens" <kaos@sgi.com>
Subject: Re: NMI problems with Dell SMP Xeons
Cc: "Andi Kleen" <ak@suse.de>, "Ashok Raj" <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <8446.1149666227@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606070920.23436.ak@suse.de>
	 <8446.1149666227@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/7/06, Keith Owens <kaos@sgi.com> wrote:
> This problem is not KDB specific, although that is where it was first
> noticed.  Any code that sends a broadcast IPI 2 or an NMI IPI will
> crash these Dell boxes when there is a mismatch between the cpus known
> to the BIOS and the cpus known to the OS.

I missed this (broadcast IPI 2 causing problems)...

Before the OS starts all AP CPUs should be in a special halt state
(specifically "cli; hlt"), where the only interrupt sources that reach
the CPU are NMI, SMI and INIT. This is why broadcast NMI is unsafe for
a variety of reasons (not just on Dells).

If the Dell machines allow an IPI 2 to get through then unused CPUs
aren't in the "cli; hlt" state, and they would also respond to any
other broadcast IPIs. This would imply that any code that uses
send_IPI_allbutself(), send_IPI_all() or anything else that sends
broadcast IPIs would/could cause problems on these Dell machines.
Depending on whether Linux leaves the real mode IVT intact or not and
which interrupt vector/s are used, the result could be nothing at all,
erratic behaviour, triple faults/resets, or executing unintended BIOS
functions (which could also trash memory or in some cases cause device
failure).

The easiest solution here would be for Dell to release an updated BIOS
that fixes this bug (i.e. puts the AP CPUs into a "cli; hlt" state, as
per Intel's notes in section 7.5.4.2 "Typical AP Initialization
Sequence" of the system programming guide). This still won't/shouldn't
fix the "broadcast NMI" problem though.

> I will try forcing send_IPI_allbutself() to use the mask version rather
> than the broadcast shortcut.  Later tonight ...

I've been looking into this a little - it appears that Linux tries to
use one bit per CPU in the local APIC's "logical destination register"
and that in all cases at least one bit is set for each valid CPU. As
far as I can tell sending an NMI (or any other broadcast IPI) in
logical mode with no shorthand and "destination = 0xFF" should work
fine for both "cluster mode" and "flat mode". In this case I'd also
suggest that "clear_local_APIC()" clear the destination format
register (DFR) and the logical destination register (LDR) so that it
doesn't receive broadcast NMIs if the CPU is taken offline.

The "send_IPI_mask_sequence()" function also seems like a perfectly
valid option (except for the comments, which are easy enough to
change). IMHO it's just not as pretty, especially if it's to be used
for all broadcast IPIs (rather than just for broadcast NMIs) - I'd be
tempted to do an "#ifdef BORKED_DELL" around it in that case. :-)


Cheers,

Brendan
