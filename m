Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVAYMwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVAYMwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVAYMwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:52:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3591
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261922AbVAYMvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:51:42 -0500
Date: Tue, 25 Jan 2005 13:51:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Jones <davej@redhat.com>, Andrew Tridgell <tridge@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: memory leak in 2.6.11-rc2
Message-ID: <20050125125135.GO7587@dualathlon.random>
References: <20050120020124.110155000@suse.de> <16884.8352.76012.779869@samba.org> <200501232358.09926.agruen@suse.de> <200501240032.17236.agruen@suse.de> <16884.56071.773949.280386@samba.org> <16885.47804.68041.144011@samba.org> <20050125034546.GF13394@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125034546.GF13394@redhat.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:45:47PM -0500, Dave Jones wrote:
> On Tue, Jan 25, 2005 at 02:19:24PM +1100, Andrew Tridgell wrote:
>  > The problem I've hit now is a severe memory leak. I have applied the
>  > patch from Linus for the leak in free_pipe_info(), and still I'm
>  > leaking memory at the rate of about 100Mbyte/minute.
>  > I've tested with both 2.6.11-rc2 and with 2.6.11-rc1-mm2, both with
>  > the pipe leak fix. The setup is:
> 
> That's a little more extreme than what I'm seeing, so it may be
> something else, but my firewall box needs rebooting every
> few days. It leaks around 50MB a day for some reason.
> Given it's not got a lot of ram, after 4-5 days or so, it's
> completely exhausted its swap too.
> 
> It's currently on a 2.6.10-ac kernel, so it's entirely possible that
> we're not looking at the same issue, though it could be something
> thats been there for a while if your workload makes it appear
> quicker than a firewall/ipsec gateway would.
> Do you see the same leaks with an earlier kernel ?
> 
> post OOM (when there was about 2K free after named got oom-killed)
> this is what slabinfo looked like..
> 
> dentry_cache        1502   3775    160   25    1 : tunables  120   60    0 : slabdata    151    151      0
> vm_area_struct      1599   2021     84   47    1 : tunables  120   60    0 : slabdata     43     43      0
> size-128            3431   6262    128   31    1 : tunables  120   60    0 : slabdata    202    202      0
> size-64             4352   4575     64   61    1 : tunables  120   60    0 : slabdata     75     75      0
> avtab_node          7073   7140     32  119    1 : tunables  120   60    0 : slabdata     60     60      0
> size-32             7256   7616     32  119    1 : tunables  120   60    0 : slabdata     64     64      0

What is avtab_node? there's no such thing in my kernel. But the above
can be ok. Can you show meminfo too after oom kill?

Just another datapoint my firewall runs a kernel based on 2.6.11-rc1-bk8 with
all the needed oom fixes and I've no problems on it yet. I run it oom
and this is what I get after the oom:

athlon:/home/andrea # free
             total       used       free     shared    buffers     cached
Mem:        511136      50852     460284          0        572      15764
-/+ buffers/cache:      34516     476620
Swap:      1052248          0    1052248
athlon:/home/andrea # 

The above is sane, 34M is very reasonable for what's loaded there
(there's the X server running, named too, and various other non standard
daemons, one even has a virtual size of >100m so it's not a tiny thing),
so I'm quite sure I'm not hitting a memleak, at least not on the
firewal. No ipsec on it btw, and it's a pure IDE without anything
special, just quite a few nics and USB usermode running all the time.

athlon:/home/andrea # uptime
  1:34pm  up 2 days 12:08,  1 user,  load average: 0.98, 1.13, 0.54
athlon:/home/andrea # iptables -L -v |grep -A2 FORWARD
Chain FORWARD (policy ACCEPT 65 packets, 9264 bytes)
 pkts bytes target     prot opt in     out     source               destination         
3690K 2321M block      all  --  any    any     anywhere             anywhere            
athlon:/home/andrea # 

So if there's a memleak in rc1-bk8, it's probably not in the core of the
kernel, but in some driver or things like ipsec. Either that or it broke
after 2.6.11-rc1-bk8. The kernel I'm running is quite heavily patched
too, but I'm not aware of any memleak fix in the additional patches.

Anyway I'll try again in a few days to verify it goes back down again to
exactly 34M of anonymous/random and 15M of cache.

No apparent problem on my desktop system either, it's running the same
kernel with different config.

If somebody could fix the kernel CVS I could have a look at the
interesting changesets between 2.6.11-rc1-bk8 and 2.6.11-rc2.
