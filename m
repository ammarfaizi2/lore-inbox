Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbSI0Js1>; Fri, 27 Sep 2002 05:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbSI0Js1>; Fri, 27 Sep 2002 05:48:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38870 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261680AbSI0Js0>;
	Fri, 27 Sep 2002 05:48:26 -0400
Date: Fri, 27 Sep 2002 15:28:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020927152833.D25021@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020926124244.GO3530@holomorphy.com> <Pine.LNX.4.44.0209260926480.1819-100000@montezuma.mastecende.com> <20020926133919.GQ3530@holomorphy.com> <20020927135743.B25021@in.ibm.com> <20020927092020.GS3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020927092020.GS3530@holomorphy.com>; from wli@holomorphy.com on Fri, Sep 27, 2002 at 02:20:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 02:20:20AM -0700, William Lee Irwin III wrote:
> On Fri, Sep 27, 2002 at 01:57:43PM +0530, Dipankar Sarma wrote:
> > What application were you all running ?
> > Thanks
> 
> Basically, the workload on my "desktop" system consists of numerous ssh
> sessions in and out of the machine, half a dozen IRC clients, xmms,
> Mozilla, and X overhead.

Ok, from a relatively idle system (4CPU) running SMP kernel -

    18 fget                                       0.2250
0           0.00        c013d460:       push   %ebx
0           0.00        c013d461:       mov    $0xffffe000,%edx
0           0.00        c013d466:       mov    %eax,%ecx
0           0.00        c013d468:       and    %esp,%edx
0           0.00        c013d46a:       mov    (%edx),%eax
1           5.56        c013d46c:       mov    0x674(%eax),%ebx
1           5.56        c013d472:       lea    0x4(%ebx),%eax
0           0.00        c013d475:       lock subl $0x1,(%eax)
3          16.67        c013d479:       js     c013d61b <.text.lock.file_table+0x30>
0           0.00        c013d47f:       mov    (%edx),%eax
1           5.56        c013d481:       mov    0x674(%eax),%edx
0           0.00        c013d487:       xor    %eax,%eax
0           0.00        c013d489:       cmp    0x8(%edx),%ecx
0           0.00        c013d48c:       jae    c013d494 <fget+0x34>
0           0.00        c013d48e:       mov    0x14(%edx),%eax
0           0.00        c013d491:       mov    (%eax,%ecx,4),%eax
0           0.00        c013d494:       test   %eax,%eax
0           0.00        c013d496:       je     c013d49c <fget+0x3c>
0           0.00        c013d498:       lock incl 0x14(%eax)
0           0.00        c013d49c:       lock incl 0x4(%ebx)
5          27.78        c013d4a0:       pop    %ebx
0           0.00        c013d4a1:       ret
7          38.89        c013d4a2:       lea    0x0(%esi,1),%esi

I tried an SMP kernel on 1 CPU -

    15 fget                                       0.1875
0           0.00        c013d460:       push   %ebx
2          13.33        c013d461:       mov    $0xffffe000,%edx
0           0.00        c013d466:       mov    %eax,%ecx
0           0.00        c013d468:       and    %esp,%edx
0           0.00        c013d46a:       mov    (%edx),%eax
0           0.00        c013d46c:       mov    0x674(%eax),%ebx
0           0.00        c013d472:       lea    0x4(%ebx),%eax
0           0.00        c013d475:       lock subl $0x1,(%eax)
3          20.00        c013d479:       js     c013d61b <.text.lock.file_table+0x30>
0           0.00        c013d47f:       mov    (%edx),%eax
0           0.00        c013d481:       mov    0x674(%eax),%edx
0           0.00        c013d487:       xor    %eax,%eax
0           0.00        c013d489:       cmp    0x8(%edx),%ecx
0           0.00        c013d48c:       jae    c013d494 <fget+0x34>
0           0.00        c013d48e:       mov    0x14(%edx),%eax
0           0.00        c013d491:       mov    (%eax,%ecx,4),%eax
0           0.00        c013d494:       test   %eax,%eax
0           0.00        c013d496:       je     c013d49c <fget+0x3c>
0           0.00        c013d498:       lock incl 0x14(%eax)
0           0.00        c013d49c:       lock incl 0x4(%ebx)
4          26.67        c013d4a0:       pop    %ebx
0           0.00        c013d4a1:       ret    
6          40.00        c013d4a2:       lea    0x0(%esi,1),%esi

The counts are off by one.

With a UP kernel, I see that fget() cost is negligible.
So it is most likely the atomic operations for rwlock acquisition/release
in fget() that is adding to its cost. Unless of course my sampling
is too less.

Please try running the files_struct_rcu patch where fget() is lockfree
and let me know what you see.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
