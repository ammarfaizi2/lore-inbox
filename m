Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbSKPW0H>; Sat, 16 Nov 2002 17:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbSKPW0G>; Sat, 16 Nov 2002 17:26:06 -0500
Received: from sv1.valinux.co.jp ([202.221.173.100]:46597 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S267386AbSKPW0F>;
	Sat, 16 Nov 2002 17:26:05 -0500
Date: Sun, 17 Nov 2002 07:23:37 +0900 (JST)
Message-Id: <20021117.072337.59652582.taka@valinux.co.jp>
To: at541@columbia.edu
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@digeo.com,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: [CFT][PATCH] 2.5.47 Athlon/Druon, much faster copy_user
 function
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20021116133839.9FC4.AT541@columbia.edu>
References: <20021116131403.9FB5.AT541@columbia.edu>
	<20021116193003.A11205@wotan.suse.de>
	<20021116133839.9FC4.AT541@columbia.edu>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > The proper way to save it is to use kernel_fpu_begin()
> 
> Thanks! I will look into it. This is what I was looking for.
> 
> I been running this kernel with my copy for three days, and never had
> oops, but I was really worried.

kernel_fpu_begin() is not enough for this purpose as user_*_copy may
cause pagefault and sleep in it. You should know lazy FPU swtich mechanism.
The mechanism will be confued by your your copy routine and may save
broken FPU context or another process may use broken FPU registers.

You should also care about do_page_fault like this:

do_page_fault()
{
     if (fault happens in user_*_copy) {
	   save FPU context on stack;
	   recover FPU context to the previous state;
     }
	   .........
	   .........
	   .........
     if (fault happens in user_*_copy) {
	   recover FPU context from stack;
     }
}

> > > > Also I'm pretty sure that using movntq (= forcing destination out of 
> > > > cache) is not a good strategy for generic copy_from_user(). It may 
> > > > be a win for the copies in write ( user space -> page cache ),
> > > 
> > > Yes, that why I included postfetch in the code because movntq does not leave 
> > > them in the L2 cache.
> > 
> > That looks rather wasteful - first force it out and then trying to get it in 
> > again. I have my doubts on it being a good strategy for speed.
> 
> It tried both, use just normal mov or movq <-> use movntq + postfetch, and the later 
> was much much faster, because postfetch needs to read only every 64 bytes.
> 
> I will ckeck kernel_fpu_begin() fisrt and if using fpu register is too much
> overhead than I will remove them.

I guess kernel_fpu_begin() might not be heavy as many processes don't use
fpu registers so much.


Thank you,
Hirokazu Takahashi.


