Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbTCREhQ>; Mon, 17 Mar 2003 23:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262161AbTCREhQ>; Mon, 17 Mar 2003 23:37:16 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:28172 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262159AbTCREhO>;
	Mon, 17 Mar 2003 23:37:14 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-reply-to: Your message of "Mon, 17 Mar 2003 17:43:21 EDT."
             <200303172143.h2HLhLql010853@pincoya.inf.utfsm.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Mar 2003 14:28:04 +1100
Message-ID: <1306.1047958084@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 17:43:21 -0400, 
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:
>> How come? If I started to decode at EIP-n and got a sequence of
>> instructions at EIP-n, EIP-n+k1, EIP-n+k2, EIP-n+k3..., EIP,
>> instructions prior to EIP can be wrong. Instruction at EIP
>> and all subsequent ones ought to be right.
>
>Iff you exactly hit EIP that way (sure, should check). But wrong previous
>instructions _will_ confuse people or start them on all kind of wild goose
>chases. Too much work for a dubious gain.

At the risk of stating the obvious: the only program that cares about
the 'Code:' line is ksymoops.  It already handles code around the EIP
by looking for a byte enclosed in <> and assuming that byte is at EIP.
ksymoops can happily decode around the failing instruction and does so
for most architectures with fixed length instructions.

I can change ksymoops to add a special case for architectures with
variable length instructions - i386, s390 and their 64 bit equivalents,
are there any others?  For variable length instructions, ksymoops will
extract the bytes up to but not including eip, decode and print them
with a warning

  This architecture has variable length instructions, decoding before eip is
  unreliable, take these instructions with a pinch of salt.

Then the code from eip onwards will be decoded as normal, with the
heading 'This code should be reliable'.  If a kernel with variable
length instructions prints 'Code:' with a byte enclosed in <> then you
get two decodes with suitable warning messages.  No <> in the code line
means no change from current decode state, everybody is happy.

