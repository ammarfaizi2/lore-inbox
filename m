Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUIHTmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUIHTmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269315AbUIHTkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:40:53 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11753 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269328AbUIHTa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:30:59 -0400
Message-ID: <413F5EE7.6050705@sgi.com>
Date: Wed, 08 Sep 2004 14:35:03 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet>
In-Reply-To: <20040908165412.GB4284@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

> 
> 
> Huh, that changes the meaning of the dirty limits. Dont think its suitable
> for mainline.
> 
> 

The change is, in fact, not much different from what is already actually 
there.  The code in get_dirty_limits() adjusts the value of the user supplied 
parameters in /proc/sys/vm depending on how much mapped memory there is.  If 
you undo the convoluted arithmetic that is in there, one finds that if you are 
using the default dirty_ratio of 40%, then if the unmapped_ratio is between 
80% and 10%, then

    dirty_ratio = unmapped_ratio / 2;

and, a little bit of algebra later:

    dirty = (total_pages - wbs->nr_mapped)/2

and

    background = dirty_background_ratio/vm_background_ratio * (total_pages
	- wbs->nr_mapped)

That is, for a wide range of memory usage, you are really running with an
dirty ratio of 50% stated in terms of the number of unmapped pages, and there 
is no direct way to override this.

Of course, at the edges, the code changes these calculations.  It just seems 
to me that rather than continue the convoluted calculation that is in
get_dirty_limits(), we just make the outcome more explicit and tell the user
what is really going on.

We'd still have to figure out how to encourage a minimum page cache size of
some kind, which is what I understand the 5% min value for dirty_ratio is in 
there for.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------


