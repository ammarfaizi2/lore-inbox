Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132910AbRDJDi3>; Mon, 9 Apr 2001 23:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132911AbRDJDiU>; Mon, 9 Apr 2001 23:38:20 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:5601 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132910AbRDJDiP>; Mon, 9 Apr 2001 23:38:15 -0400
Message-ID: <3AD27FE6.4987E792@mvista.com>
Date: Mon, 09 Apr 2001 20:37:10 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: SodaPop <soda@xirr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] 2.4.x nice level
In-Reply-To: <Pine.LNX.4.30.0104041104510.9687-100000@xirr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SodaPop wrote:
> 
> I too have noticed that nicing processes does not work nearly as
> effectively as I'd like it to.  I run on an underpowered machine,
> and have had to stop running things such as seti because it steals too
> much cpu time, even when maximally niced.
> 
> As an example, I can run mpg123 and a kernel build concurrently without
> trouble; but if I add a single maximally niced seti process, mpg123 runs
> out of gas and will start to skip while decoding.
> 
> Is there any way we can make nice levels stronger than they currently are
> in 2.4?  Or is this perhaps a timeslice problem, where once seti gets cpu
> time it runs longer than it should since it makes relatively few system
> calls?
> 
In kernel/sched.c for HZ < 200 an adjustment of nice to tick is set up
to be nice>>2 (i.e. nice /4).  This gives the ratio of nice to time
slice.  Adjustments are made to make the MOST nice yield 1 jiffy, so
using this scale and remembering nice ranges from -19 to 20 the least
nice is 40/4 or 10 ticks.  This implies that if only two tasks are
running and they are most and least niced then one will get 1/11 of the
processor, the other 10/11 (about 10% and 90%).  If one is niced and the
other is not you get 1 and 5 for the time slices or 1/6 and 5/6 (17% and
83%).  

In 2.2.x systems the full range of nice was used one to one to give 1
and 39 or 40 or 2.5% and 97.5% for max nice to min.  For most nice to
normal you would get 1 and 20 or 4.7% and 95.3%.

The comments say the objective is to come up with a time slice of 50ms,
presumably for the normal nice value of zero.  After translating the
range this would be a value of 20 and, yep 20/4 give 5 jiffies or 50
ms.  Sure puts a crimp in the min to max range, however.

George
