Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285269AbRLXTtc>; Mon, 24 Dec 2001 14:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285279AbRLXTtW>; Mon, 24 Dec 2001 14:49:22 -0500
Received: from grootstal.nijmegen.internl.net ([217.149.192.7]:42380 "EHLO
	grootstal.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id <S285277AbRLXTtL>; Mon, 24 Dec 2001 14:49:11 -0500
Date: Mon, 24 Dec 2001 20:48:36 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: <=2.4.17 deadlock (RedHat 7.2, SMP, ext3 related?) (2)
Message-ID: <20011224204836.A9927@iapetus.localdomain>
In-Reply-To: <20011223235315.A9071@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223235315.A9071@iapetus.localdomain>; from F.vanMaarseveen@inter.NL.net on Sun, Dec 23, 2001 at 11:53:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below a second case, again it occured right at the moment a PPP
connection was terminated. For some unknown reason it seems to occur
frequently enough now for doing some experimenting. Tell me if more info
is needed. This is the same kernel as before. When the problem first
emerged some weeks ago after installing RedHat 7.2 I switched to kgcc
(gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) instead
of gcc 2.96 but it didn't make a difference.

Following two alt-sysrq-p have been decoded from a JPEG image I took from
the screen. Even alt-sysrq-l leaves most processes intact according to
alt-sysrq-t so to me it looks like a genuine deadlock:

Pid: 4465, comm:	hotplug
EIP: 0010:[<c03fe0ba>] CPU: 0 EFLAGS 00000286	not tainted
Call Trace: c0140134 c013eba2 c013eab2 c013ee23 c01076cb

Pid: 2930, comm:	pppd
EIP: 0010:[<c0403068>] CPU: 1 EFLAGS 00000286	not tainted
Call Trace: c016d320 c028ee04 c0159e01 c0156e68 c013f063 c0150bc6 c028eac8 c01076cb

Now ksymoops at work:
ksymoops 2.4.1 on i686 2.4.17-b65.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-b65/ (default)
     -m /boot/System.map-2.4.17-b65 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
EIP: 0010:[<c03fe0ba>] CPU: 0 EFLAGS 00000286   not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: c0140134 c013eba2 c013eab2 c013ee23 c01076cb
EIP: 0010:[<c0403068>] CPU: 1 EFLAGS 00000286   not tainted
Call Trace: c016d320 c028ee04 c0159e01 c0156e68 c013f063 c0150bc6 c028eac8 c01076cb
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c03fe0ba <stext_lock+1c82/e9ac>   <=====
Trace; c0140134 <chrdev_open+28/124>
Trace; c013eba2 <dentry_open+e6/194>
Trace; c013eab2 <filp_open+52/5c>
Trace; c013ee23 <sys_open+4b/140>
Trace; c01076cb <system_call+33/38>
>>EIP; c0403068 <stext_lock+6c30/e9ac>   <=====
Trace; c016d320 <ext3_delete_inode+0/270>
Trace; c028ee04 <ppp_ioctl+33c/d84>
Trace; c0159e01 <iput+2c5/2f0>
Trace; c0156e68 <d_delete+dc/20c>
Trace; c013f063 <filp_close+133/140>
Trace; c0150bc6 <sys_ioctl+24a/2e4>
Trace; c028eac8 <ppp_ioctl+0/d84>
Trace; c01076cb <system_call+33/38>


3 warnings issued.  Results may not be reliable.

-- 
Frank
