Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310504AbSCSI7L>; Tue, 19 Mar 2002 03:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310508AbSCSI7B>; Tue, 19 Mar 2002 03:59:01 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:40711 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310504AbSCSI6u>;
	Tue, 19 Mar 2002 03:58:50 -0500
Date: Tue, 19 Mar 2002 05:58:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
In-Reply-To: <47390000.1016511942@flay>
Message-ID: <Pine.LNX.4.44L.0203190556110.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Martin J. Bligh wrote:

> OK, I finally got the -aa kernel series running in conjunction with the
> NUMA-Q discontigmem stuff. For some reason which I haven't debugged
> yet 2.4.19-pre3-aa2 won't boot on the NUMA-Q even without the discontigmem
> stuff in ... so I went back to 2.4.19-pre1-aa1, which I knew worked from
> last time around (thanks again for that patch).
>
> So just comparing aa+discontigmem to standard 2.4.18+discontigmem, I see
> kernel compile times are about 35s vs 26.5s ....

That's probably Andrea's pte-highmem code, which uses the
global kmap pool instead of doing cpu-local atomic kmaps.

He's been told about this becoming a scalability problem
but didn't believe it since I didn't have any numbers for
him.  Maybe he believes it now since you've measured it ;)


> standard:
>
>  23991 total                                      0.0257
>   7679 default_idle                             147.6731
>   3044 _text_lock_dcache                          8.7221
>   2340 _text_lock_swap                           43.3333
>   1160 do_anonymous_page                          3.4940
> ...
>    109 kmap_high                                  0.3028
>     46 _text_lock_highmem                  0.4071
>
> andrea:
>  38549 total                                      0.0405
>  13102 _text_lock_highmem                       108.2810
>   8627 default_idle                             165.9038
>   2578 kunmap_high                               14.3222
>   2556 kmap_high                                  6.0857
>   1242 do_anonymous_page                          3.2684
>   1052 _text_lock_swap                           22.8696

> Andrea - is this your new highmem pte stuff doing this?
> Or is that not even in your tree as yet? Would be a shame if that's
> the problem as I really want to get the highmem pte stuff - allows
> me to put processes pagetables on their own nodes ....

You really want the pte-highmem by Arjan and Ingo, which uses
kmap_atomic (which is CPU-local and doesn't suffer the same
scalability problem as the global kmap pool).

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

