Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLGUMD>; Thu, 7 Dec 2000 15:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLGULx>; Thu, 7 Dec 2000 15:11:53 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:23526 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129423AbQLGULi>; Thu, 7 Dec 2000 15:11:38 -0500
Date: Thu, 7 Dec 2000 20:38:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "Richard B. Johnson" <root@chaos.analogic.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <F02E6C85A2D@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1001207202311.8897A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Petr Vandrovec wrote:

> It is architectural problem. Each CPU must have its own IDT or GDT table.
> If (for real example) you'll use task gate for NMI, both NMIs are currently
> (AFAIK) delivered to both CPUs at same time. Both CPUs find in IDT that
> they should switch to task 0x1230. So one of them finds TSS 0x1230 (in GDT
> entry 0x1230 / 8) as not busy (busy is field in TSS GDT descriptor), marks 
> it busy and starts executing in new context. But other one finds 0x1230 as 
> busy. And fault during doublefault is triplefault. Which is hardwired to 
> reset and we are where we were before...

 This is not a problem itself -- each CPU may have a separate GDT and/or
IDT.  We should not use task gates for NMIs but this still applies for
double faults. 

> Well, Intel recommends 'Invalid TSS' exception to be handled through TSS
> too, for obvious reason that CPU state may be half-old and half-new...

 We could set up a handler similar to the one for the double fault.

> But I'm not sure that all vendors handle TSS fault during doublefault
> correctly and I do not want to rely on that. 

 That would probably lead to a triple fault, but is it a real problem for
us?  It is possible to set up a reliable double fault handler so the
'Invalid TSS' handler would likely get never ever invoked. 

> So either each CPU must have its own IDT, pointing to different slots
> in GDT, or each CPU must have its own GDT... I preffer IDT, as having
> per-CPU GDT could create some really nasty problems (f.e. synchronizing
> LDT entries between CPUs) (*) (**).

 Just as I wrote earlier...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
