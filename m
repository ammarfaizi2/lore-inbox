Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313578AbSDXBNi>; Tue, 23 Apr 2002 21:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313613AbSDXBNh>; Tue, 23 Apr 2002 21:13:37 -0400
Received: from zok.SGI.COM ([204.94.215.101]:42686 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S313578AbSDXBNh>;
	Tue, 23 Apr 2002 21:13:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module() 
In-Reply-To: Your message of "Tue, 23 Apr 2002 14:09:21 -0400."
             <Pine.GSO.4.21.0204231407280.8087-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Apr 2002 08:56:01 +1000
Message-ID: <16795.1019602561@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002 14:09:21 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>
>
>On Tue, 23 Apr 2002, Keith Owens wrote:
>
>>   open /dev/foo
>>     request_module(foo)
>>       load foo, mark !MOD_USED_ONCE.
>
>Another process:
>	open /dev/foo
>		MOD_INC_USE_COUNT
>		mark MOD_USED_ONCE
>	close /dev/foo
>		MOD_DEC_USE_COUNT
>rmmod -a
>	kills module
>
>>     continue with open, MOD_INC_USE_COUNT(foo), mark MOD_USED_ONCE.
>			  module not loaded

You need two rmmod -a sweeps with no intervening activity on the module
before the module will be autocleaned.  See MOD_VISITED.  Unless the
first process hangs in the kernel for minutes, it will find the module
still present, use the module and cancel the rmmod -a status.

BTW, I do not disagree that module unloading in general is racy,
especially for ancillary data such as exception tables, unwind data,
timers, kernel threads etc.  Which is why Rusty and I plan to rewrite
module loading and unloading in 2.5.  I just do not see a race in the
area you are looking at.

