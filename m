Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281541AbRKVTqK>; Thu, 22 Nov 2001 14:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281560AbRKVTqA>; Thu, 22 Nov 2001 14:46:00 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:6546 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S281541AbRKVTpx>; Thu, 22 Nov 2001 14:45:53 -0500
Date: Thu, 22 Nov 2001 19:51:26 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: =?iso-8859-1?Q?Lu=EDs?= Henriques 
	<lhenriques@criticalsoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy to suer space
Message-ID: <20011122195126.A4695@storm.local>
Mail-Followup-To: =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@criticalsoftware.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011120173309.0262fd10@pop.cus.cam.ac.uk> <200111201759.fAKHx9289954@criticalsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200111201759.fAKHx9289954@criticalsoftware.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 05:53:24PM +0000, Luís Henriques wrote:
> I don't understand... this means that the paging does not save the a code 
> segment in memory? (sorry, this question is being done by a newbie...) When a 
> page is back to memory, what happens? Is read again from the binary file 
> (executable)?

Code and data pages are mapped from the executable.  Code is read-only
and can therefore be discarded at any time, since it exists on disk (in
the executable file, no swap needed).  Data is mapped copy-on-write
(read-only pages until writes occur, then a writable copy is generated).

So only modified data pages and new mappings not backed by a disk file
need to be saved in swap space.

> Well... I don't think this will have much impact in my module because what it 
> does is:
> 
>  - change the code in a process
>  - return to the process
>  - next time the process is scheduled, the code will be stored again in the CS

I'm not sure why you would want to actually _change_ code.  You could
prepare a page in kernel with the busy loop and map that into user
space.

Then make the kernel return to your busy loop and let it call back to
the kernel again when finished, then remove the mapping to leave no
traces.  Maybe that could be done by redirecting a signal handler
pointer and raising that signal.

I don't know how difficult that is, it's just an idea.  But it sure
sounds easier than modifying a read-only page without side effects.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
