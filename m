Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUH2RyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUH2RyB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268243AbUH2RyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:54:01 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:40361 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S268239AbUH2Rxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:53:46 -0400
Date: Sun, 29 Aug 2004 19:52:45 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829175245.GA32117@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829172022.GL5492@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 10:20:22 -0700, William Lee Irwin III wrote:
> > ==> 10000 processes: top -d 0 -b > /dev/null <==
> > CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> > Profiling through timer interrupt
> > samples  %        image name               symbol name
> > 35855    36.0707  vmlinux                  get_tgid_list
> > 9366      9.4223  vmlinux                  pid_alive
> > 7077      7.1196  libc-2.3.3.so            _IO_vfscanf_internal
> > 5386      5.4184  vmlinux                  number
> > 3664      3.6860  vmlinux                  proc_pid_stat
> 
> get_tgid_list() is a sad story I don't have time to go into in depth.
> The short version is that larger systems are extremely sensitive to
> hold time for writes on the tasklist_lock, and this being on scales
> not needing SGI participation to tell us (though scales beyond personal
> financial resources still).

I am confident that this problem (as far as process monitoring is
concerned) could be addressed with differential notification.

> > ==> /prod/pid/statm (2x) for 10000 processes <==
> > CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> > Profiling through timer interrupt
> > samples  %        image name               symbol name
> > 7430      9.9485  libc-2.3.3.so            _IO_vfscanf_internal
> > 6195      8.2948  vmlinux                  __d_lookup
> > 5477      7.3335  vmlinux                  task_statm
> > 5082      6.8046  vmlinux                  number
> > 3227      4.3208  vmlinux                  link_path_walk
> 
> scanf() is still very pronounced here; I wonder how well-optimized
> glibc's implementation is, or if otherwise it may be useful to
> circumvent it with a more specialized parser if its generality
> requirements preclude faster execution.

I'd much rather remove unnecessary overhead than optimize code for
overhead processing. Note that number() takes out 7% and that's the
_kernel_ printing numbers for user space to parse back. And __d_lookup
is another /proc souvenir you get to keep as long as you use /proc.

> > ==> 27 nproc fields for 10000 processes, one process per request <==
> > CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> > Profiling through timer interrupt
> > samples  %        image name               symbol name
> > 7647     25.0894  vmlinux                  __task_mem
> > 2125      6.9720  vmlinux                  find_pid
> > 1884      6.1813  vmlinux                  nproc_pid_fields
> > 1488      4.8820  vmlinux                  __task_mem_cheap
> > 1161      3.8092  vmlinux                  mmgrab
> 
> It looks like I'm going after the right culprit(s) for the lower-level
> algorithms from this.

Well __task_mem is promiment here because I don't call other computation
functions. vmstat ain't cheap, and wchan is horribly expensive if the
kernel does the ksym translation. Etc. pp.

Roger
