Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbREELVB>; Sat, 5 May 2001 07:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbREELUw>; Sat, 5 May 2001 07:20:52 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:23560 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131949AbREELUq>;
	Sat, 5 May 2001 07:20:46 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105051120.f45BKic207817@saturn.cs.uml.edu>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 5 May 2001 07:20:44 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105041418550.21896-100000@weyl.math.psu.edu> from "Alexander Viro" at May 04, 2001 02:29:26 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
>> On Fri, 4 May 2001, Alexander Viro wrote:

>>> Ehh... There _is_ a way to deal with that, but it's deeply Albertesque:
>                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ah, you learn from the master.

> ObProcfs: I don't think that walking the page tables is a good way to
> compute RSS, especially since VM maintains the thing. Mind if I rip

Handling of mapped device memory should not change. For example
there is the X server with mapped video memory. There is another
RSS value provided elsewhere in case one does not want to include
mapped device memory.

Currently top uses the statm file in the following manner:

  case P_SIZE:
    sprintf(tmp, "%5.5s ", scale_k((task->size << CL_pg_shift), 5, 1));
    break;
  case P_TRS:
    sprintf(tmp, "%4.4s ", scale_k((task->trs << CL_pg_shift), 4, 1));
    break;
  case P_SWAP:
    sprintf(tmp, "%4.4s ",
	scale_k(((task->size - task->resident) << CL_pg_shift), 4, 1));
    break;
  case P_SHARE:
    sprintf(tmp, "%5.5s ", scale_k((task->share << CL_pg_shift), 5, 1));	    break;
  case P_DT:
    sprintf(tmp, "%3.3s ", scale_k(task->dt, 3, 0));
    break;
  case P_RSS:	/* rss, not resident (which includes IO memory) */
    sprintf(tmp, "%4.4s ",
	scale_k((task->rss << CL_pg_shift), 4, 1));


> it out? In effect, implementation of /prc/<pid>/statm
> 	* produces extremely bogus values (VMA is from library if it goes
> 	  beyond 0x60000000? Might be even true 7 years ago...) and nobody
> 	  had cared about them for 6-7 years

One could count pages that are mapped executable and do not come
from the main executable... but this is pretty worthless and does
not consider non-executable library sections.

The latest "top" does not bother to display this value.

> 	* makes stuff like top(1) _walk_ _whole_ _page_ _tables_ _of_ _all_
> 	  _processes_ each 5 seconds. No wonder it's slow like hell and eats
> 	  tons of CPU time.

On my system, "statm" takes 50% longer than "stat" or "status".
Maybe there is a significant difference with Oracle on a 32 GB box?

I'd rather top didn't have to read the file at all.
