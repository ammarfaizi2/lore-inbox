Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUIAA21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUIAA21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269059AbUHaTmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:42:24 -0400
Received: from holomorphy.com ([207.189.100.168]:13503 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269035AbUHaTiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:38:55 -0400
Date: Tue, 31 Aug 2004 12:38:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: Look Ma, No get_tgid_list!
Message-ID: <20040831193842.GO5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040831153431.GA6010@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831153431.GA6010@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 05:34:32PM +0200, Roger Luethi wrote:
> This posting demonstrates a new method of monitoring all processes in
> a large system.
> You may remember what a /proc based tool does when monitoring some
> 10^5 processes -- it spends its time in the kernel hanging on to a
> read task_list_lock:
> ==> 10000 processes: top -d 0 -b > /dev/null <==
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        image name               symbol name
> 35855    36.0707  vmlinux                  get_tgid_list
> 9366      9.4223  vmlinux                  pid_alive
> 7077      7.1196  libc-2.3.3.so            _IO_vfscanf_internal
> 5386      5.4184  vmlinux                  number
> 3664      3.6860  vmlinux                  proc_pid_stat
[...]

The most crucial issue for larger systems is removing the rather easily
triggerable rwlock starvation. Perhaps dipankar's /proc/ -only tasklist
RCU patch can resolve that.


On Tue, Aug 31, 2004 at 05:34:32PM +0200, Roger Luethi wrote:
> Here's a profile for an nproc based tool monitoring the same set
> of processes:
> ==> 10000 processes: nprocbench <==
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        app name                 symbol name
> 8641     24.8626  vmlinux                  __task_mem
> 2778      7.9931  vmlinux                  find_pid
> 2536      7.2968  vmlinux                  finish_task_switch
> 1872      5.3863  vmlinux                  netlink_recvmsg
> 1637      4.7101  vmlinux                  nproc_pid_fields
[...]
> Resource usage is now dominated by field computation, rather than by
> delivery overhead. By now it should be clear that nproc is not only a
> cleaner interface with lower overhead for tools, it also scales a lot
> better than /proc.

With this in hand we can probably ignore the /proc/ -related efficiency
issues in favor of any method preventing the rwlock starvation, e.g.
dipankar's /proc/ -only tasklist RCU patch.


-- wli
