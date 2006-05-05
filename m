Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWEEIle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWEEIle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 04:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWEEIle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 04:41:34 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:32184 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750978AbWEEIld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 04:41:33 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Ingo Molnar <mingo@elte.hu>
Subject: as bug (was: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU)
Date: Fri, 5 May 2006 11:40:21 +0300
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Gerd Hoffmann <kraxel@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>, binutils@sources.redhat.com
References: <20060419094630.GA14800@elte.hu> <20060420152609.GA21993@elte.hu> <20060421074858.GA28858@elte.hu>
In-Reply-To: <20060421074858.GA28858@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605051140.22005.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[binutils list CC'ed]

On Friday 21 April 2006 10:48, Ingo Molnar wrote:
> you can also try the mutex.bad.s file i attached:
> 
>  $ as mutex.s.bad
>  mutex.s.bad: Assembler messages:
>  mutex.s.bad:267: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:355: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:412: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:574: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:627: Warning: .space or .fill with negative value, ignored

Reduced testcase, which still exhibits the bug.

# as mutex.bad_minimal.s
mutex.bad_minimal.s: Assembler messages:
mutex.bad_minimal.s:21: Warning: .space or .fill with negative value, ignored
# as --version | head -1
GNU assembler 2.15.91.0.1 20040527
# cat mutex.bad_minimal.s

661:
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .byte 0x68
  .byte 662b-661b
.section .smp_altinstr_replacement,"awx"
        .fill 662b-661b,1,0x42
        .section        .sched.text,"ax",@progbits
        call    _spin_unlock    #
661:
2:      jle 2b  #
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .byte 0x68
  .byte 662b-661b
.section .smp_altinstr_replacement,"awx"
        .fill 662b-661b,1,0x42

--
vda
