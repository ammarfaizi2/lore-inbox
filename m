Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUERX6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUERX6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 19:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUERX6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 19:58:40 -0400
Received: from fmr04.intel.com ([143.183.121.6]:56467 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261711AbUERX6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 19:58:37 -0400
Date: Tue, 18 May 2004 16:58:04 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ia64 cpu hotplug patch
Message-ID: <20040518165803.A32483@unix-os.sc.intel.com>
References: <1084923956.23158.11.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1084923956.23158.11.camel@bach>; from rusty@rustcorp.com.au on Tue, May 18, 2004 at 04:45:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 04:45:56PM -0700, Rusty Russell wrote:
> 
>    On Wed, 2004-05-19 at 04:12, Anton Blanchard wrote:
>    >  > Gack, Rusty, I wish you had less SMTP latency.  I'm not sure what
>    >  >  this is about.  If it pertains to some patch which I'm carrying,
>    someone
>    > > tell me what one ;)
>    >
>    >  One  of the ia64 hotplug patches that got merged. It seems they got
>    itchy
>    > fingers and changed a few more things than they should have.
> 
>    Precisely.  This applies against Linus' kernel:
> 
>    Name: Fix overzealous use of online cpu iterators
>    Status: Trivial
> 
>    The  IA64  hotplug CPU merge seems to have included some core changes:
>    in
>    particular the recalc_bh_state() needs to sum for all (including
>    offline) cpus, since we don't empty the counters on CPU down.  I don't
>    know  that anyone cares about the accuracy of the /proc/stat when CPUs
>    go
>    down, but certainly the totals printed (the first loop) should include
>    offline cpus.

Sorry... my mistake!

proc_misc.c was changed, since top() uses this to read and
display stats. With cpuhotplug cpu_possible() represents
the entire set of NR_CPUS, all these stats with 0 values and
top gets all dorky about it.

Maybe the right thing would be to fix the utility instead ?

Other issue i noticied was that when we have a 4 cpu system, and you 
remove an intermediate cpu say cpu2, top utility is dorky again. And prints
"invalid data" in the middle of the output.

Without the fix to proc_misc, if NR_CPUS is set to 128, top lists all
128 cpu stats even if only 4 are present and online, since 
for_each_cpu reprensents all of it....

> 
>    --- b/fs/proc/proc_misc.c       Fri May 14 23:11:58 2004
>    +++ a/fs/proc/proc_misc.c       Tue Mar 23 02:05:27 2004
>    @@ -368,7 +368,7 @@
>            if (wall_to_monotonic.tv_nsec)
>                    --jif;
> 
>    -       for_each_online_cpu(i) {
>    +       for_each_cpu(i) {
>                    int j;
> 
>                    user += kstat_cpu(i).cpustat.user;
>    @@ -390,7 +390,7 @@
>                    (unsigned long long)jiffies_64_to_clock_t(iowait),
>                    (unsigned long long)jiffies_64_to_clock_t(irq),
>                    (unsigned long long)jiffies_64_to_clock_t(softirq));
>    -       for_each_online_cpu(i) {
>    +       for_each_cpu(i) {
> 
>                      /*  Copy  values  here  to  work  around gcc-2.95.3,
>    gcc-2.96 */
>                    user = kstat_cpu(i).cpustat.user;
> 
>    --
>    Anyone who quotes me in their signature is an idiot -- Rusty Russell
> 
>    -
>    To   unsubscribe   from   this   list:   send  the  line  "unsubscribe
>    linux-kernel" in
>    the body of a message to majordomo@vger.kernel.org
>    More majordomo info at  [1]http://vger.kernel.org/majordomo-info.html
>    Please read the FAQ at  [2]http://www.tux.org/lkml/
> 
> References
> 
>    1. http://vger.kernel.org/majordomo-info.html
>    2. http://www.tux.org/lkml/
