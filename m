Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263649AbREYIb7>; Fri, 25 May 2001 04:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263650AbREYIbj>; Fri, 25 May 2001 04:31:39 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:57604 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263649AbREYIbe>;
	Fri, 25 May 2001 04:31:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: Your message of "Fri, 25 May 2001 10:20:15 +0200."
             <20010525102015.C26038@gruyere.muc.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 18:31:20 +1000
Message-ID: <26599.990779480@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 10:20:15 +0200, 
Andi Kleen <ak@suse.de> wrote:
>On Fri, May 25, 2001 at 04:53:47PM +1000, Keith Owens wrote:
>> The only way to avoid those problems is to move struct task out of the
>> kernel stack pages and to use a task gate for the stack fault and
>> double fault handlers, instead of a trap gate (all ix86 specific).
>> Those methods are expensive, at a minimum they require an extra page
>> for every process plus an extra stack per cpu.  I have not even
>> considered the extra cost of using task gates for the interrupts nor
>> how this method would complicate methods for getting the current struct
>> task pointer.  It is not worth the bother, we write better kernel code
>> than that.
>
>When you don't try to handle recursive stack/double faults it only requires
>a single static stack per CPU. With some tricks and minor races it is also
>possible to handle multiple ones.

That is exactly what I said above, a separate fault task with its own
stack for every cpu.  But there is no point in doing this to detect a
hardware stack overflow when the overflow has already corrupted the
struct task which is at the bottom of the stack segment.

To get any benefit from hardware detection of kernel stack overflow you
must also dedicate the stack segment to hold only stack data.  That
means moving struct task to yet another page, adding an extra page per
task.  It is just too expensive, we write better code than that.

