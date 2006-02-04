Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946003AbWBDANs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946003AbWBDANs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945969AbWBDANs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:13:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946124AbWBDANr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:13:47 -0500
To: Benjamin Chu <benchu@tamu.edu>
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: Measure the Accept Queueing Time
References: <43E28A07.1040604@tamu.edu>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 03 Feb 2006 19:13:39 -0500
In-Reply-To: <43E28A07.1040604@tamu.edu>
Message-ID: <y0mek2kdlqk.fsf@toenail.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Chu <benchu@tamu.edu> writes:

> [...]  All I want is to measure the amount of time when a open
> request is in the accept queue. [...]
> p.s. My Linux Kernel Version is 2.4.25

Dude, you made me spend several hours playing with systemtap to solve
this simple-sounding problem.  :-) 

At the end, I have a script (attached below) that works on one
particular kernel build (a beta RHEL4 kernel, which has the systemtap
prerequisite kprobes, but uses the same networking structure).
Unfortunately, it also demonstrated some of the work we have to do in
systemtap land to make it work better.

The good news: here is the output of the script running on a vmware
instance that has only single socket listener program, being briefly
tickled by hand, then hammered by "nc" connections in a loop.  The
lines came out every ten seconds (as requested by the script, see
below), and report on the number of successful accept()s, plus the
number of microseconds that each open_request* was in the
accept_queue.

% socket -l -s NNNN &
[1] 25384
% stap -g acceptdelay.stp
[1139011591] socket(25384) count=1 avg=1487us
[1139011601] socket(25384) count=9 avg=560us
[1139011611] socket(25384) count=6 avg=915us
[1139011621] socket(25384) count=747 avg=604us
[1139011631] socket(25384) count=1280 avg=558us
[1139011641] socket(25384) count=1147 avg=547us
[1139011645] socket(25384) count=25 avg=471us

Is that the sort of data you were hoping to see?

The systemtap translator unfortunately has problems identifying the
most ideal probe insertion points, based on source code coordinates or
function names.  The interception of inline functions is weak.  At the
present, we also don't have/use the benefit of hooks inserted into the
kernel just for us, which would make probes simple and precise.  But
all these problems are being worked on.

So, as a stop-gap for this warts-and-all demonstration, the script
just uses hard-coded PC addresses.  Please look beyond that and use
your imagination!

- FChE


#! stap -g

# This embedded-C function is needed to extract a tcp_opt field
# from a pointer cast to generic struct sock*.  Later, systemtap
# will offer first class syntax and protected operation for this.
%{
#include <net/tcp.h>
%}
function tcp_aq_head:long (sock:long) 
%{
  struct tcp_opt *tp = tcp_sk ((struct sock*) (uintptr_t) THIS->sock);
  THIS->__retvalue = (int64_t) (uintptr_t) tp->accept_queue;
%}


global open_request_arrivals # indexed by open_request pointer
global open_request_delays # stats, indexed by pid and execname

probe # a spot in the open_request creation path
# XXX: the following commented-out probe points should also work
# kernel.inline("tcp_acceptq_queue")
# kernel.function("tcp_v4_conn_request")
# kernel.inline("tcp_openreq_init")
  kernel.statement("*@net/ipv4/tcp_ipv4.c:1472") # after tcp_openreq_init()
{
  open_request_arrivals[$req] = gettimeofday_us()
}


# One could also probe at entry of tcp_accept itself, to track
# whether an accept() syscall was blocked by absence of pending
# open_requests.


probe # a spot in tcp_accept, after pending open_request found
# kernel.statement("*@net/ipv4/tcp_ipv4.c:1922")
  kernel.statement (0xc029eec8) # near req = tp->accept_queue
{
  req = tcp_aq_head ($sk) # tcp_sk(sk)->accept_queue; $req should work too
  then = open_request_arrivals[req]
  if (then) { 
    delete open_request_arrivals[req] # save memory
    now = gettimeofday_us()
    open_request_delays[pid(),execname()] <<< now-then 
  }
}


probe timer.ms(10000), end # periodically and at session shutdown
{
  now=gettimeofday_s()
  foreach ([pid+,execname] in open_request_delays) # sort by pid
    printf("[%d] %s(%d) count=%d avg=%dus\n", now, execname, pid,
           @count(open_request_delays[pid,execname]),
           @avg(open_request_delays[pid,execname]))
  delete open_request_delays
}


# Some preprocessor magic to prevent someone from running this
# demonstration script (with its hard-coded probe addresses)
# on another kernel build
%( kernel_vr == "2.6.9-30.ELsmp" %? %( arch == "i686" %? /* OK */
                                                      %: BADARCH %)
                                 %: BADVERSION %)
