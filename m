Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263397AbUJ2PiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbUJ2PiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbUJ2PgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:36:24 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57096 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263415AbUJ2PKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:10:38 -0400
Date: Fri, 29 Oct 2004 16:10:31 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Len Brown <len.brown@intel.com>
Cc: Kahro Raie <kahroo@hot.ee>, linux-kernel@vger.kernel.org
Subject: Re: ERROR: Disabling IRQ #11
In-Reply-To: <1099033246.5403.246.camel@d845pe>
Message-ID: <Pine.LNX.4.58L.0410291550090.2581@blysk.ds.pg.gda.pl>
References: <20041029062746.B69E312CE@portal.hot.ee> <1099033246.5403.246.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Len Brown wrote:

> APIC error on CPU0: 00(01)
> 
> Hmmm, how did we take this interrupt with no bits set?
> why do we have bit 0 (send checksum error) set after
> we try to clear "errors"?

 Please have a look at the relevant local APIC specification.  For the
P6-class local APIC a write of zero (or likely any value -- I don't
remember) to the ESR makes the internal error status be copied to the
externally visible ESR.  A read of the ESR returns its contents and clears
it.  Thus the report is perfectly valid -- it means no uncleared error was
left over before.

 For the record: for the P5-class local APIC the ESR is the only error
status and it is also cleared on a read.  Thus for that implementation the
error codes reported would be reversed.  Writes to the ESR have no effect
by definition.  Unfortunately, a range of chips have suffered from an
erratum which makes data on writes to the ESR being actually recorded in
the register.  As a result, we cannot just do a sequence consisting of a
write and a read -- we need to do that leading read to handle buggy chips
correctly.  And we do need to write zero specifically as otherwise a bogus
error would be reported for them.

 I don't remember what the specification for the P4-class local APIC is in
this area, or what other vendors' implementations do.  The i82489DX APIC
does not implement error reporting.

 Frankly, I think this P5-to-P6 APIC specification change is an
unnecessary annoyance for an OS developer.  And there are more caveats
like this across local APIC implementations, this perhaps being the least
harmful one.

  Maciej
