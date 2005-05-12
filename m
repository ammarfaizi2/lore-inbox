Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVELKX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVELKX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 06:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVELKX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 06:23:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:36244 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261396AbVELKXx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 06:23:53 -0400
Date: Thu, 12 May 2005 15:52:30 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Morton Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] kexec+kdump testing with 2.6.12-rc3-mm3
Message-ID: <20050512102230.GB3870@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1115769558.26913.1046.camel@dyn318077bld.beaverton.ibm.com> <20050511025325.GA3638@in.ibm.com> <1115824847.26913.1061.camel@dyn318077bld.beaverton.ibm.com> <20050512054424.GC3838@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512054424.GC3838@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 11:14:24AM +0530, Vivek Goyal wrote:
> On Wed, May 11, 2005 at 08:20:50AM -0700, Badari Pulavarty wrote:
> > On Tue, 2005-05-10 at 19:53, Vivek Goyal wrote:
> > > On Tue, May 10, 2005 at 04:59:18PM -0700, Badari Pulavarty wrote:
> > > > Hi,
> > > > 
> > > > I am using kexec+kdump on 2.6.12-rc3-mm3 and it seems to be working
> > > > fine on my 4-way P-III 8GB RAM machine. I did touch testing with
> > > > kexec+kdump and it worked fine. Then ran heavy IO load and forced
> > > > a panic and I was able to collect the dump. But I am not able to
> > > > analyze the dump to find out if I really got a valid dump or not :(
> > > > 
> > > 
> > > Copying to LKML.
> > > 
> > > Gdb can not open a file larger than 2GB. You have got 8GB RAM hence
> > > /proc/vmcore size must be similar. For testing purposes you can boot first
> > > kernel with mem=2G and then take dump and analyze with gdb.
> > 
> > Its better with mem=2G, but gdb is not really useful :(
> > I wanted to look at all the processes and their stacks..
> > It shows me only one stack (not quite right). So I can't
> > really use the dump for anything :(
> > 
> 
> 
> You can run "info thread" to see how many cpus are are there. Use "thread" to 
> switch to a different thread and then run "bt" to see the stack of that
> that thread. We have observed some issues with this. You will see proper
> stack only if other cpus were not running swapper thread (pid 0).  
> 
> For seeing the stack of all the processes, I guess macros need to be written
> which traverse the task list, retrieve stack pointer and then trace back. I
> have not tried it though. 


Following is a somewhat crude user defined command to dump stack for all the 
processes in the crashdump


(gdb) define ps
Type commands for definition of "ps".
End with a line saying just "end".
>set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
>set $init_t=&init_task
>set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
>while ($next_t != $init_t)
 >set $next_t=(struct task_struct *)$next_t
 >print $next_t.comm
 >print $next_t.pid
 >x/40x $next_t.thread.esp
 >set $next_t=(char *)($next_t->tasks.next) - $tasks_off
 >end
>end
(gdb) ps
$1 = "init\000er\000\000\000\000\000\000\000\000"
$2 = 1
0xeff9fe5c:     0xeff9fea8      0x00000086      0xeff9fe74      0x00000286
0xeff9fe6c:     0xc4608e00      0xeff9febc      0xeff9fe88      0xc0126f53
0xeff9fe7c:     0x00242e9d      0xc4608420      0x00000e39      0xfff54405
0xeff9fe8c:     0x0000026a      0xc0405c00      0xeffd1a30      0xeffd1b58
0xeff9fe9c:     0x00242e9d      0xeff9febc      0x0000000b      0xeff9fee4
0xeff9feac:     0xc03a1a70      0xefdd200c      0xefd95000      0xeff9fecc
0xeff9febc:     0xc4609780      0xc4609780      0x00242e9d      0x4b87ad6e
0xeff9fecc:     0xc0127ad0      0xeffd1a30      0xc4608e00      0xee45e3c0
0xeff9fedc:     0x00000000      0x00000000      0xeff9ff60      0xc01707e6
0xeff9feec:     0x00000000      0x00000000      0x00000400      0x00000000
$3 = "migration/0\000\000\000\000"
$4 = 2
0xeffa7f5c:     0xeffa7fa8      0x00000046      0xc4608420      0xc4608420
0xeffa7f6c:     0x00000082      0xeffa7f8c      0xe69fff54      0x00000000
0xeffa7f7c:     0xe7b77a70      0xc4608420      0x0000031e      0xb806bf4f
0xeffa7f8c:     0x00000161      0xe7b77a70      0xeffd7550      0xeffd7678
0xeffa7f9c:     0xc4608d6c      0xc4608420      0xeffa6000      0xeffa7fc0
0xeffa7fac:     0xc011a632      0x00000000      0xeffa6000      0xeff9ff44
0xeffa7fbc:     0x00000000      0xeffa7fe4      0xc0132c36      0xfffffffc
0xeffa7fcc:     0xc011a5b0      0xffffffff      0xffffffff      0xc0132ba0
0xeffa7fdc:     0x00000000      0x00000000      0x00000000      0xc0101145
0xeffa7fec:     0xeff9ff3c      0x00000000      0x00000000      0xb7fc938d


Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
