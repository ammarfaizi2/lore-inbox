Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTEPQPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTEPQPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:15:33 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:129 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264482AbTEPQPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:15:32 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Fri, 16 May 2003 18:28:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH][2.5] VMWare doesn't like sysenter
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1AF6C870AF5@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 03 at 11:15, Zwane Mwaikambo wrote:
> On Thu, 15 May 2003, Randy.Dunlap wrote:
> 
> > On Thu, 15 May 2003 04:02:31 -0400 (EDT) Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> > 
> > | I get a monitor error in VMWare4 with a sysenter syscall enabled kernel, 
> > | this patch simply disables sysenter based syscalls but doesn't clear the 
> > | SEP bit in the capabilities.
> > 
> > | +static int __init do_nosysenter(char *s)
> > | +{
> > | +   nosysenter = 1;
> > | +   return 1;
> > | +}
> > | +__setup("nosysenter", do_nosysenter);
> > 
> > Needs entry in Documentation/kernel-parameters.txt also
> > if/when accepted.
> 
> Thanks for the heads up.
> 
> Index: linux-2.5.69-mm5/Documentation/kernel-parameters.txt
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.69/Documentation/kernel-parameters.txt,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 kernel-parameters.txt
> --- linux-2.5.69-mm5/Documentation/kernel-parameters.txt    6 May 2003 12:21:18 -0000   1.1.1.1
> +++ linux-2.5.69-mm5/Documentation/kernel-parameters.txt    15 May 2003 15:14:23 -0000
> @@ -1063,6 +1063,10 @@ running once the system is up.
>  
>     sym53c8xx=  [HW,SCSI]
>             See Documentation/scsi/ncr53c8xx.txt.
> +   
> +   nosysenter  [IA-32]
> +           Disable SYSENTER for syscalls, does not clear the SEP
> +           capabilities bit.

RedHat's 9 backport of vsyscalls uses 'nosysinfo' name for 
option which does simillar task (it just stops kernel from reporting
relevant AT_SYSINFO completely).

BTW, what's reason for this backport? They just always put int 0x80
into this page, so even on real CPU kernel booted with nosysinfo
is faster than one which uses this vsyscall entry point.

VMware's panic should be fixed in next update, but I'm afraid that
penalty from exectuing code in upper couple of MBs of address space 
will not disappear. Moving SYSINFO page from FFFFE000 to FF7FF000
(PKMAP_BASE - PAGE_SIZE == VMALLOC_END + PAGE_SIZE) would fix both
problems.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

