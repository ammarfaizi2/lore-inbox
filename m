Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267379AbSKPVtr>; Sat, 16 Nov 2002 16:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbSKPVtr>; Sat, 16 Nov 2002 16:49:47 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:64978 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S267379AbSKPVtX>; Sat, 16 Nov 2002 16:49:23 -0500
Date: Sat, 16 Nov 2002 16:55:31 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andi Kleen <ak@suse.de>
Subject: Re: [CFT][PATCH]  2.5.47 Athlon/Druon, much faster copy_user function
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andrew Morton <akpm@digeo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20021116193003.A11205@wotan.suse.de>
References: <20021116131403.9FB5.AT541@columbia.edu> <20021116193003.A11205@wotan.suse.de>
Message-Id: <20021116163707.1C5C.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop016.verizon.net from [138.89.33.207] at Sat, 16 Nov 2002 15:56:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002 19:30:03 +0100
Andi Kleen <ak@suse.de> mentioned:
> On Sat, Nov 16, 2002 at 01:22:51PM -0500, Akira Tsukamoto wrote:
> > This is the main question for me that I was wondering for all week. 
> > My first version was using fsave and frstore, so 
> > just changing three lines will accomplish this.
> > Is it all I need?  Any thing elase needed to consider using fpu register?
> 
> You are currently corrupting the user's FPU state.

fsave and frstor should solve this problem, doesn't it?

> The proper way to save it is to use kernel_fpu_begin()

I looked into it.  kernel_fpu_begin/end are basically doing:
  1)preempt enable/disable
  2)fsave and frstor
It does not look a lot of overhead.

So what is missing in my patch is:
 1)Surround with kernel_fpu_begin/end.
 2)Change the threshold of the size from 256 to somewhere around 512.
   I removed the fsave/frstor, which was in my first version, to lower the 
   threshold because they had some overhead and if the copying size
   was smaller than 512, the org_copy became faster.
   I just need to reverse it.

Please let me know if anything esle is missing.

> > > > Also I'm pretty sure that using movntq (= forcing destination out of 
> > > > cache) is not a good strategy for generic copy_from_user(). It may 
> > > > be a win for the copies in write ( user space -> page cache ),
> > > 
> > > Yes, that why I included postfetch in the code because movntq does not leave 
> > > them in the L2 cache.

> > That looks rather wasteful - first force it out and then trying to get it in 
> > again. I have my doubts on it being a good strategy for speed.
>
> It tried both, use just normal mov or movq <-> use movntq + postfetch, and the later 
> was much much faster, because postfetch needs to read only every 64 bytes.

This is bench for read with my patch on 2.5.47
 read: buf(0x804e000) copied 24.0 Mbytes in 0.040 seconds at 604.7 Mbytes/sec
 read: buf(0x804e001) copied 24.0 Mbytes in 0.047 seconds at 509.5 Mbytes/sec
 read: buf(0x804e002) copied 24.0 Mbytes in 0.046 seconds at 516.8 Mbytes/sec
 read: buf(0x804e003) copied 24.0 Mbytes in 0.046 seconds at 516.4 Mbytes/sec

This is stock 2.5.47
 read: buf(0x804e000) copied 24.0 Mbytes in 0.086 seconds at 279.8 Mbytes/sec
 read: buf(0x804e001) copied 24.0 Mbytes in 0.105 seconds at 229.2 Mbytes/sec
 read: buf(0x804e002) copied 24.0 Mbytes in 0.104 seconds at 230.8 Mbytes/sec
 read: buf(0x804e003) copied 24.0 Mbytes in 0.105 seconds at 229.2 Mbytes/sec

About 200% faster.

Akira


