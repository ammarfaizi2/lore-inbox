Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUH2RVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUH2RVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUH2RVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:21:16 -0400
Received: from holomorphy.com ([207.189.100.168]:46766 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268213AbUH2RUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:20:34 -0400
Date: Sun, 29 Aug 2004 10:20:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829172022.GL5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829170247.GA9841@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 09:05:42 -0700, William Lee Irwin III wrote:
>> Okay, these explain some of the difference. I usually see issues with
>> around 10000 processes with fully populated virtual address spaces and
>> several hundred vmas each, varying between 200 to 1000, mostly
>> concentrated at somewhere just above 300.

On Sun, Aug 29, 2004 at 07:02:48PM +0200, Roger Luethi wrote:
> I agree, that should make quite a difference. As you said, we are
> working on orthogonal areas: My current focus is on data delivery (sane
> semantics and minimal overhead), while you seem to be more interested
> in better data gathering.

Yes, there doesn't seem to be any conflict between the code we're
working on. These benchmark results are very useful for quantifying the
relative importance of the overheads under more typical conditions.


On Sun, Aug 29, 2004 at 07:02:48PM +0200, Roger Luethi wrote:
> I profiled "top -d 0 -b > /dev/null" for about 100 and 10^5 processes.
> When monitoring 100 (real-world) processes, /proc specific overhead
> (_IO_vfscanf_internal, number, __d_lookup, vsnprintf, etc.) amounts to
> about one third of total resource usage.
> ==> 100 processes: top -d 0 -b > /dev/null <==
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        image name               symbol name
> 20439    12.2035  libc-2.3.3.so            _IO_vfscanf_internal
> 15852     9.4647  vmlinux                  number
> 11635     6.9469  vmlinux                  task_statm
> 9286      5.5444  libc-2.3.3.so            _IO_vfprintf_internal
> 9128      5.4500  vmlinux                  proc_pid_stat

Lexical analysis is cpu-intensive, probably due to the cache misses
taken while traversing the strings. This is likely inherent in string
processing interfaces.


On Sun, Aug 29, 2004 at 07:02:48PM +0200, Roger Luethi wrote:
> With 10^5 additional dummy processes, resource usage is dominated by
> attempts to get a current list of pids. My own benchmark walked a list
> of known pids, so that was not an issue. I bet though that nproc can
> provide more efficient means to get such a list than getdents (we could
> even allow a user to ask for a message on process creation/kill).
> So basically that's just another place where nproc-based tools would
> trounce /proc-based ones (that piece is vaporware today, though).
> ==> 10000 processes: top -d 0 -b > /dev/null <==
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        image name               symbol name
> 35855    36.0707  vmlinux                  get_tgid_list
> 9366      9.4223  vmlinux                  pid_alive
> 7077      7.1196  libc-2.3.3.so            _IO_vfscanf_internal
> 5386      5.4184  vmlinux                  number
> 3664      3.6860  vmlinux                  proc_pid_stat

get_tgid_list() is a sad story I don't have time to go into in depth.
The short version is that larger systems are extremely sensitive to
hold time for writes on the tasklist_lock, and this being on scales
not needing SGI participation to tell us (though scales beyond personal
financial resources still).


On Sun, Aug 29, 2004 at 07:02:48PM +0200, Roger Luethi wrote:
> The remaining profiles are for two benchmarks from my previous message.
> Field computation is more prominent than with top because the benchmark
> uses a known list of pids and parsing is kept at a trivial level.
> ==> /prod/pid/statm (2x) for 10000 processes <==
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        image name               symbol name
> 7430      9.9485  libc-2.3.3.so            _IO_vfscanf_internal
> 6195      8.2948  vmlinux                  __d_lookup
> 5477      7.3335  vmlinux                  task_statm
> 5082      6.8046  vmlinux                  number
> 3227      4.3208  vmlinux                  link_path_walk

scanf() is still very pronounced here; I wonder how well-optimized
glibc's implementation is, or if otherwise it may be useful to
circumvent it with a more specialized parser if its generality
requirements preclude faster execution.


On Sun, Aug 29, 2004 at 07:02:48PM +0200, Roger Luethi wrote:
> nproc removes most of the delivery overhead so field computation is
> now dominant. Strictly speaking, it should be even higher because the
> benchmarks requests the same fields three times, but they only get
> computed once in such a case.
> ==> 27 nproc fields for 10000 processes, one process per request <==
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        image name               symbol name
> 7647     25.0894  vmlinux                  __task_mem
> 2125      6.9720  vmlinux                  find_pid
> 1884      6.1813  vmlinux                  nproc_pid_fields
> 1488      4.8820  vmlinux                  __task_mem_cheap
> 1161      3.8092  vmlinux                  mmgrab

It looks like I'm going after the right culprit(s) for the lower-level
algorithms from this.


-- wli
