Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280556AbRKBESU>; Thu, 1 Nov 2001 23:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280557AbRKBESK>; Thu, 1 Nov 2001 23:18:10 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:38404 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S280556AbRKBESE>; Thu, 1 Nov 2001 23:18:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>, Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: graphical swap comparison of aa and rik vm
Date: Thu, 1 Nov 2001 23:18:02 -0500
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0111011009090.2963-100000@imladris.surriel.com> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102041808Z280556-17408+9240@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the answer of why AA's kernel beat rik's has nothing to do with how 
much swap rik is using or how much swap is being swapped back in.  It has to 
do with how rik decides what to swap.  Apparently the algorithm used by rik 
to play with memory is taking seriously too much cpu and it leaves little for 
the actual process to work.  Thus AA's less cpu intensive code allows the 
program to actually run and despite making errors in what to swap-out, the 
process finishes well before Rik's more intelligent code.  

Unfortunately, the trailing columns in my aa vmstat somehow got lost during 
the paste from terminal buffer to file.  This means i'm going to have to redo 
it all in order to get an accurate measurement to compare system cpu time to 
the rik vm.  But for now i think the rik vm system graph is sufficient.  And 
there are some numbers from the AA vmstat and those alone show a much lower 
cpu usage than in rik's. MUCH.

I made an overlay of Rik's system ( kernel ) cpu usage on top of the so and 
si graphs to illustrate this.  Bottom being 0% top being 100% usage. 

http://safemode.homeip.net/sys_so.png 
Here we see that after every major write out, there is major kernel cpu 
usage.  This is serious usage, and this is the reason why rik's VM loses the 
race even though it swapped out and in the right things the first try more 
often than AA's.  

http://safemode.homeip.net/sys_si.png 
Of course after each major write out in Rik's vm there is a minor read in.   
These happen to be directly under the cpu spikes so this could be the cause 
of the cpu usage, perhaps determining where the page is?  I dont know enough 
about what's going on in the code to figure out if the VM does something 
after writing out that could be using all that cpu or if whenever it needs to 
read in.  Although now that i look at it i'm tending to lean towards some bad 
code dealing with swap -> ram. 

This is truly where the simple vm design conquers the complex. Less cpu being 
used by the kernel means more by the program, and sometimes the time gained 
by not using a lot of cpu greatly outweighs the time lost by having to 
correct mistakes with deciding what gets swapped in and out. 

Maybe i'm wrong as to the cause of the kernel cpu usage, but from the numbers 
i do have from AA's vmstat, they are much higher in Rik's vm than in 
Andrea's.  That and the fact that Rik's vm seems to be doing the right thing 
whereas Andrea's is having to fix mistakes yet Rik's loses seems to tell you 
that i'm not wrong in thinking that it's the vm's cpu usage that is the 
culprit.  
