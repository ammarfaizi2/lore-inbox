Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUH2SQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUH2SQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUH2SQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:16:42 -0400
Received: from holomorphy.com ([207.189.100.168]:13231 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268250AbUH2SQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 14:16:34 -0400
Date: Sun, 29 Aug 2004 11:16:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829181627.GR5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829175245.GA32117@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 10:20:22 -0700, William Lee Irwin III wrote:
>> get_tgid_list() is a sad story I don't have time to go into in depth.
>> The short version is that larger systems are extremely sensitive to
>> hold time for writes on the tasklist_lock, and this being on scales
>> not needing SGI participation to tell us (though scales beyond personal
>> financial resources still).

On Sun, Aug 29, 2004 at 07:52:45PM +0200, Roger Luethi wrote:
> I am confident that this problem (as far as process monitoring is
> concerned) could be addressed with differential notification.

I'm a bit squeamish about that given that mmlist_lock and tasklist_lock
are both problematic and yet another global structure to fiddle with in
the process creation and destruction path threatens similar trouble.

Also, what guarantee is there that the notification events come
sufficiently slowly for a single task to process, particularly when that
task may not have a whole cpu's resources to marshal to the task?
Queueing them sounds less than ideal due to resource consumption, and
if notifications are dropped most of the efficiency gains are lost. So
I question that a bit.

I have a vague notion that userspace should intelligently schedule
inquiries so requests are made at a rate the app can process and so
that the app doesn't consume excessive amounts of cpu. In such an
arrangement screen refresh events don't trigger a full scan of the
tasklist, but rather only an incremental partial rescan of it, whose
work is limited for the above cpu bandwidth concerns.


On Sun, 29 Aug 2004 10:20:22 -0700, William Lee Irwin III wrote:
>> scanf() is still very pronounced here; I wonder how well-optimized
>> glibc's implementation is, or if otherwise it may be useful to
>> circumvent it with a more specialized parser if its generality
>> requirements preclude faster execution.

On Sun, Aug 29, 2004 at 07:52:45PM +0200, Roger Luethi wrote:
> I'd much rather remove unnecessary overhead than optimize code for
> overhead processing. Note that number() takes out 7% and that's the
> _kernel_ printing numbers for user space to parse back. And __d_lookup
> is another /proc souvenir you get to keep as long as you use /proc.

I'm expecting very very long lifetimes for legacy kernel versions and
userspace predating the merge of nproc, so it's not entirely irrelevant,
though backports aren't exactly something I relish.


On Sun, 29 Aug 2004 10:20:22 -0700, William Lee Irwin III wrote:
>> It looks like I'm going after the right culprit(s) for the lower-level
>> algorithms from this.

On Sun, Aug 29, 2004 at 07:52:45PM +0200, Roger Luethi wrote:
> Well __task_mem is promiment here because I don't call other computation
> functions. vmstat ain't cheap, and wchan is horribly expensive if the
> kernel does the ksym translation. Etc. pp.

task_mem() is generally prominent when the processes have large numbers
of vmas, and also due to acquisition of ->mmap_sem.


-- wli
