Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTE0EMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTE0EMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:12:18 -0400
Received: from adsl-67-122-203-155.dsl.snfc21.pacbell.net ([67.122.203.155]:64426
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S263273AbTE0EMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:12:13 -0400
Message-ID: <3ED2E8A2.7020609@storadinc.com>
Date: Mon, 26 May 2003 21:25:06 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>
>On Mon, 26 May 2003, manish wrote:
>
>>Hello !
>>
>>I am running the 2.4.20 kernel on a system with 3.5 GB RAM and dual CPU.
>>I am running bonnie accross four drives in parallel:
>>
>>bonnie -s 1000 -d /<dir-name>
>>
>>bdflush settings on this system:
>>
>>[root@dyn-10-123-130-235 vm]# cat bdflush
>>2       50      32      100     50      300     1       0       0
>>
>>All the bonnie process and any other process (like df, ps -ef etc.) are
>>hung in __lock_page. Breaking into kdb, I observe the following for one
>>such bonnie process:
>>
>>schedule(..)
>>__lock_page(..)
>>lock_page(..)
>>do_generic_file_read(..)
>>generic_file_read(..)
>>
>>After this, the processes never exit the hang. At times, a couple of
>>bonnie processes complete but the hang still occurs with the remaining
>>processes and with the other processes.
>>
>>I tried out the 2.5.33 kernel (one of the 2.5 series) and observed that
>>the hang does not occur. If I run, two bonnie processes, they never get
>>stuck. Actually, if I run 4 parallel mke2fs, they too get stuck.
>>
>>Any clues where this could be happening?
>>
>
>Hi,
>
>Are you sure there is no disk activity ?
>
>Run vmstat and check that, please.
>
Hello !

Thanks for the response.

 The light on the controller does not blink at all. Intitially, it does 
blink. However, after this hang, it does not at all.

vmstat after the hang

1  1  0    780 2056892   5784 1415324   0   0     0     4  102     7  
49   1  50
 1  1  0    780 2056892   5784 1415324   0   0     0     4  102     9  
49   1  50
 1  1  0    780 2056892   5784 1415324   0   0     0     5  104    10  
29  21  50
 0  1  0    780 2056708   5784 1415324   0   0     0     1  104    12   
0  13  86
 1  1  0    780 2222904   5784 1249396   0   0     0   172  126    25   
0   4  96
 0  1  0    780 3081052   5784 391324   0   0     0   403  161    43   
0  12  88
   procs                      memory    swap          io     
system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  
sy  id
 0  1  0    780 3080952   5788 391408   0   0    29     9  120    72   
0   0 100
 0  1  0    780 3080952   5788 391408   0   0     0     0  111    19   
0   0 100
 0  1  0    780 3080952   5788 391408   0   0     0     1  103     9   
0   0 100
 0  1  0    780 3080952   5788 391408   0   0     0     0  101     9   
0   0 100
 0  1  0    780 3080952   5788 391408   0   0     0     0  101     7   
0   0 100
 0  1  0    780 3080952   5788 391408   0   0     0     0  101     9   
0   0 100
 0  1  0    780 3080952   5788 391408   0   0     0     0  102     9   
0   0 100
 0  1  0    780 3080952   5788 391408   0   0     0     1  101     8   
0   0 100
 0  1  0    780 3081308   5788 391420   0   0     0   231  150    92   
3   0  97
 0  1  0    780 3081308   5788 391420   0   0     0     0  102     7   
0   0 100
 0  1  0    780 3081308   5788 391420   0   0     0     0  102     7   
0   0 100
 0  1  0    780 3081304   5788 391420   0   0     0     0  101     9   
0   0 100
 0  1  0    780 3081304   5788 391420   0   0     0     0  102     8   
0   0 100
 0  1  0    780 3081300   5788 391420   0   0     0     0  101     8   
0   0 100
 0  1  0    780 3081300   5788 391420   0   0     0     0  101     9   
0   0 100
 0  1  0    780 3081296   5788 391420   0   0     0     0  101     7   
0   0 100
 0  1  0    780 3081296   5788 391420   0   0     0     0  101     9   
0   0 100

 0  1  0    780 3081292   5788 391420   0   0     0     0  102     9   
0   0 100
 0  1  0    780 3081292   5788 391420   0   0     0     0  101     8   
0   0 100
 0  1  0    780 3081288   5788 391420   0   0     0     0  102     9   
0   0 100
 0  1  0    780 3081288   5788 391420   0   0     0     0  102     7   
0   0 100
 0  1  0    780 3081284   5788 391420   0   0     0     0  102     9   
0   0 100
 0  1  0    780 3081284   5788 391420   0   0     0     0  102     8   
0   0 100
 0  1  0    780 3081280   5788 391420   0   0     0     0  101     8   
0   0 100

 0  1  0    780 3081276   5788 391420   0   0     0     0  102     9   
0   0 100

0  1  0    780 3081260   5788 391420   0   0     0     0  235    30   
0   0 100
 0  1  0    780 3081260   5788 391420   0   0     0     0  101     9   
0   0 100
 0  1  0    780 3081256   5788 391420   0   0     0     0  101     7   
0   0 100
 0  1  0    780 3081248   5788 391424   0   0     0   169  137    54   
3   1  97
 0  1  0    780 3081248   5788 391424   0   0     0     0  101     9   
0   0 100
 0  1  0    780 3081248   5788 391424   0   0     0     0  101     8   
0   0 100
 0  1  0    780 3081248   5788 391424   0   0     0     0  101     9   
0   0 100

One bonnie process is hung.







