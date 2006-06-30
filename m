Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWF3SzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWF3SzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWF3SzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:55:12 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:38846 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932389AbWF3SzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:55:11 -0400
Date: Fri, 30 Jun 2006 14:48:59 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel module debugging question
To: Arjan van de Ven <arjan@infradead.org>
Cc: "s.a." <sancelot@free.fr>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606301451_MC3-1-C3E0-AB89@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1151661642.11434.23.camel@laptopd505.fenrus.org>

On Fri, 30 Jun 2006 12:00:42 +0200, Arjan van de Ven wrote:

> On Fri, 2006-06-30 at 12:28 +0000, s.a. wrote:
> > Hi,
> > I have got the following fault , can you provide me with more details
> > about the problem ?
> > Best Regards
> 
> you disabled CONFIG_KALLSYMS in your kernel configuration, which means
> the backtrace isn't really useful for anyone to look at

The only thing on the stack is the regs, thus no backtrace.

Someone modified entry.S and added code just before the sysexit.  There is
no 'sysenter_exit' in stock 2.6.16 for one, and there's new code before
the sysexit:

   3:   e8 81 ca 03 00            call   3ca89 <_EIP+0x3ca89> <== new
   8:   fb                        sti                       <== new
   9:   8b 4d 08                  mov    0x8(%ebp),%ecx
   c:   66 f7 c1 ff fe            test   $0xfeff,%cx
  11:   0f 85 4e 01 00 00         jne    165 <_EIP+0x165>
  17:   e8 ed ea 00 00            call   eb09 <_EIP+0xeb09> <== new
  1c:   8b 44 24 18               mov    0x18(%esp),%eax <== new
  20:   8b 54 24 28               mov    0x28(%esp),%edx
  24:   8b 4c 24 34               mov    0x34(%esp),%ecx
  28:   31 ed                     xor    %ebp,%ebp
  2a:   fb                        sti
   0:   0f 35                     sysexit    <===== oops

But that doesn't explain the oops.  Maybe the SYSENTER MSR got screwed up?

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
