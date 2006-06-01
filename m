Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965272AbWFAAPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbWFAAPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 20:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbWFAAPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 20:15:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:23737 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965272AbWFAAPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 20:15:51 -0400
From: Neil Brown <neilb@suse.de>
To: Martin Hierling <martin.hierling@fh-luh.de>
Date: Thu, 1 Jun 2006 10:15:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Message-ID: <17534.12716.972995.289153@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.16.18 with general protection fault, perhaps nfsd
In-Reply-To: message from Martin Hierling on Wednesday May 31
References: <20060531164707.GA19547@cc.fh-luh.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 31, martin.hierling@fh-luh.de wrote:
> Hi List, 
> 
> this is my first report, so don,AE$,1 s(Bt be to picky. thanks.

Thank you for taking the trouble to make the report.

I think your problem is bad memory.
The code where the problem happens is:
> Code: 83 fa ff 0f 84 2b 01 00 00 b8 00 e0 ff ff 21 e0 8b 00 89 90 74 01
> 00 00 8b 57 04 83 fa ff 0f 84 40 01 00 00 b8 00 e0 ff ff 21 c0 <8b> 00
> 89 90 84 01 00 00 8b 57 08 b8 f4 ff ff ff 85 d2 74 29 89

The relevant part disassembles as:

Code;  fffffff9
  24:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  fffffffe
  29:   21 c0                     and    %eax,%eax
Code;  00000000
  2b:   8b 00                     mov    (%eax),%eax

Which fairly clearly looks wrong. The 
   and %eax,%eax
if pointless, and the result of the whole is to look at address
   0xffffe000
which is what causes the GPF.

This code should look like:

0x00007766 <nfsd_setuser+234>:  mov    $0xffffe000,%eax
0x0000776b <nfsd_setuser+239>:  and    %esp,%eax
0x0000776d <nfsd_setuser+241>:  mov    (%eax),%eax

(based on what I see when I disassemble that code, allowing for the
fact that I'm using a different version of gcc).  This makes a lot
more sense - %esp (the stack pointer) when anded with 0xffffe000 gives
the 'current' task struct.

The difference is one bit.
  'and %eax %eax'  is 0x21 0xc0
  'and %esp %eax'  is 0x21 0xe0

I recommend running memtest86 and replacing the bad memory.

NeilBrown
