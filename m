Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUIAQmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUIAQmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUIAQlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:41:01 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:21751 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267335AbUIAQhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:37:10 -0400
From: zanussi@us.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16693.64124.459938.186682@tut.ibm.com>
Date: Wed, 1 Sep 2004 11:36:12 -0500
To: Roger Luethi <rl@hellgate.ch>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       richardj_moore@uk.ibm.com, bob@watson.ibm.com,
       michel.dagenais@polymtl.ca
Subject: Re: LTT user input
In-Reply-To: <20040723220631.GD8495@k3.hellgate.ch>
References: <16640.10183.983546.626298@tut.ibm.com>
	<20040723100101.GA22440@k3.hellgate.ch>
	<16641.19483.708016.320557@tut.ibm.com>
	<20040723191900.GA2817@k3.hellgate.ch>
	<16641.30883.655066.942277@tut.ibm.com>
	<20040723220631.GD8495@k3.hellgate.ch>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:
 > 
 > Heh, that's your job :-). Given that a Java/FORTH/whatever interpreter
 > is unlikely to be merged into mainline anytime soon, what excitement
 > can we still offer with the complex stuff living in user space?
 > 
 > Even if your goal is to beat DTrace eventually, you need to sell patches
 > on their own merits, not based on what we could do in some unlikely or
 > distant future. DTrace is a red herring, more interesting is what we
 > can do with, say, basic LTT infrastructure, or dprobes, etc.
 > 
 > Roger


I agree, and to that end have taken the existing trace infrastructure
(LTT and kprobes), bolted a Perl interpreter onto the user side to
make it capable of continuously monitoring the trace stream with
arbitrary logic, and come up with a few example scripts which I hope
might interest a wider audience and demonstrate the utility of this
approach, which is really pretty simple at its core: static and
dynamic instrumentation as provided by LTT and kprobes respectively do
little more in the kernel than efficiently get the relevant data to
user space, where user-defined scripts can make use of the full power
of standard languages like Perl to do whatever they like.

I've posted the code to the ltt-dev mailing list - obviously I won't
repost it here; if you're interested you can grab it from the archive:

http://www.listserv.shafik.org/pipermail/ltt-dev/2004-August/000649.html

I am though including the text of that posting below, as it goes into
more detail than the little I've described above, and contains some
concrete examples.


Tom


- copy of posting to ltt mailing list -

Hi,

The attached patch adds a new continuous trace monitoring capability
to the LTT trace daemon, allowing user-defined Perl scripts to analyze
and look for patterns in the LTT trace event data as it becomes
available to the daemon.  The same scripts can be used off-line if the
tracevisualizer is pointed at an existing trace file.  Note that this
is purely a user tools modification - no kernel files were harmed in
the making of this feature ;-)

Also attached are a couple of example kprobes modules which
demonstrate a way to insert dynamic tracepoints into the kernel in
order to gather data not included by the LTT static tracepoints.  The
gathered data is then passed along to LTT via custom events.

What this capability attempts to do is give regular sysadmins or
technically inclined users a quick and easy way to not only gather
system-wided statistics or detect patterns in system event data in an
ad-hoc manner, but to also answer questions like those that tools like
syscalltrack for example answers e.g. which process is modifying my
config file behind my back, who's deleting an important file once in
awhile, who's killing a particular process, etc.  (See examples below)

Basically the way it works is that when the trace daemon receives a
buffer of trace events from the kernel, it iterates over each event in
the buffer and invokes a callback handler in a user-defined Perl
script for that event (if there's a handler defined for the event
type).  This gives the script a chance to do whatever Perlish thing it
feels is appropriate for that event e.g. update counts, calculate time
differences, page someone, etc.  Since the embedded Perl interpreter
is persistent for the lifetime of the trace, global data structures
persist across handlers and are available to all.  Typically what
handlers do is update global counters or hashes or flags and let the
script-end handler output the results.  But of course since this is
Perl, anything goes and the only limit is your imagination (and what
you can reasonably do in a handler).  A word on performance - I was at
first sceptical that any scripting language interpreter could handle
the volume of events that LTT can throw at it, but in practice I
haven't seen any evidence of the trace scripts being unable to keep up
with the event stream, even during relatively heavy activity
e.g. kernel compile.  If it does become a problem, you can always do a
normal trace to disk and post-process the file using the same script
with the tracevisualizer.

The complete list of callback handlers is listed in the allcounts.pl
script, which can be found in the tracewatch-scripts directory.
Running this script causes all trace events to be counted and the
results displayed when the trace ends (You can stop a trace by using
Ctrl-C or by killing the tracedaemon (but don't kill -9) or via the
normal tracedaemon timeout (-ts option)):

# tracedaemon -o trace.out -z allcounts.pl

callback invocation counts:
   TraceWatch::network_packet_in: 808
   TraceWatch::irq_exit: 17508
   TraceWatch::memory_page_alloc: 21
   TraceWatch::softirq_soft_irq: 17500
   TraceWatch::irq_entry: 17508
   TraceWatch::schedchange: 44
   TraceWatch::fs_select: 76
   TraceWatch::fs_ioctl: 12
   TraceWatch::timer_expired: 9
   TraceWatch::fs_iowait_start: 2
   TraceWatch::trap_exit: 132
   TraceWatch::fs_read: 4
   TraceWatch::process_wakeup: 26
   TraceWatch::syscall_entry: 60
   TraceWatch::softirq_tasklet_action: 1
   TraceWatch::syscall_exit: 60
   TraceWatch::trap_entry: 132
   TraceWatch::network_packet_out: 14
   TraceWatch::kernel_timer: 16687
   TraceWatch::socket_send: 1
   TraceWatch::fs_write: 10


Here's the ouptut of a short script (tracewatch-scripts/syscall.pl)
that simply counts system-wide syscalls:

# tracedaemon -o trace.out -z syscall.pl

Total # of syscalls: 517

Counts by syscall number:

   sigreturn: 2
   stat64: 6
   time: 6
   ioctl: 92
   fstat64: 3
   poll: 2
   rt_sigaction: 1
   rt_sigprocmask: 4
   read: 36
   alarm: 1
   writev: 1
   fcntl64: 262
   write: 40
   select: 61

And here's the script, showing that a syscall_entry() handler is
defined to catch syscall events, which updates a global variable
containing the total syscall count and updates a per-syscall count by
updating a global hash keyed on the $syscall_name parameter of the
syscall_entry() handler.  The end_watch() handler is called when
tracing stops and allows the script to output its results, which in
this case entails just iterating over the hash and printing the
key/value pairs:

# Track the total number of syscalls by syscall name
#
# Usage: tracedaemon trace.out -o -z syscall.pl

package TraceWatch;

sub end_watch {
     print "\nTotal # of syscalls: $syscall_count\n";
     print "\nCounts by syscall number:\n\n";
     while (($key, $value) = each %syscall_counts) {
	print "  $key: $value\n";
     }
     print "\n";
}

sub syscall_entry {
     my ($tv_sec, $tv_usec, $syscall_name, $address) = @_;

     $syscall_count++;
     $syscall_counts{$syscall_name}++;
}


The tracewatch-scripts/syscalls-by-pid.pl script breaks down the
syscall totals to individual syscall totals for each pid.  Here's the
output:

# tracedaemon -o trace.out -z syscalls-by-pid.pl

Total # of syscalls: 998

Syscall counts by pid:

PID: 1327 [nmbd]
   close: 1
   socketcall: 4
   time: 9
   rt_sigprocmask: 10
   ioctl: 7
   fcntl64: 262
   select: 5
PID: 1 [init]
   stat64: 6
   time: 3
   select: 3
   fstat64: 3
PID: 1806 [wterm]
   read: 162
   ioctl: 225
   writev: 2
   select: 164
   write: 112
PID: 2199 [tracedaemon]
   poll: 1
   ioctl: 4
   write: 1
PID: 1359 [cron]
   stat64: 3
   rt_sigaction: 1
   rt_sigprocmask: 2
   time: 2
   nanosleep: 1
PID: 1270 [atalkd]
   sigreturn: 2
   select: 2


Here's the script, which is a little more involved but demonstrates a
few important things.  First, the start_watch() handler is called
before tracing starts to let the script set things up beforehand.  In
this case, start_watch() calls a helper function, get_process_names()
(from read-proc.pl) which reads /proc and returns a pid/procname hash.
The process_fork() and fs_exec() callbacks are used here only to keep
this hash up-to-date (this combination is common enough that it should
be put in a separate module, which would also make the actually
important of script look as simple as it really is).  We also see here
another bookkeeping handler, schedchange, which allows us to keep
track of the current pid.  The real meat of this script is in the
syscall_entry() handler, which basically keeps track of things using
nested hashes.  Isn't that wonderful?

# Tracks the total number of individual syscall invocations for each pid.
#
# Usage: tracedaemon trace.out -o -z syscalls-by-pid.pl

package TraceWatch;
require "read-proc.pl";

my $current_pid = -1;
my $last_entry;
my $last_fork_pid = -1;

# At start of tracing, get all the current pids from /proc
sub start_watch {
     get_process_names();
}

# At end of tracing, dump our nested hash
sub end_watch {
     print "\nTotal # of syscalls: $syscall_count\n";
     print "\nSyscall counts by pid:\n\n";
     while (($pid, $syscall_name_hash) = each %pids) {
	print "PID: $pid [$process_names{$pid}]\n";
	while (($syscall_name, $count) = each %$syscall_name_hash) {
	    print "  $syscall_name: $count\n";
	}
     }
     print "\n";
}

# For each syscall entry, add count to nested pid/syscall hash
sub syscall_entry {
     my ($tv_sec, $tv_usec, $syscall_name, $address) = @_;
     $syscall_count++;
     if ($current_pid != -1) { # ignore until we have a current pid
	$pids{$current_pid}{$syscall_name}++;
     }
}

# We need to track the current pid as one of our hash keys
sub schedchange {
     my ($tv_sec, $tv_usec, $in_pid, $out_pid, $out_pid_state) = @_;
     $current_pid = $in_pid;
}

# We need to track exec so we can keep our pid/name table up-to-date.
# The process_fork() callback has saved the pid we make the association 
with.
sub fs_exec {
     my ($tv_sec, $tv_usec, $filename) = @_;

     if ($last_fork_pid != -1) {
	$process_names{$last_fork_pid} = $filename; # process_fork saved the pid
     }
}

# We need to track forks so we can keep our pid/name table up-to-date.
sub process_fork {
     my ($tv_sec, $tv_usec, $pid) = @_;

     $last_fork_pid = $pid;
}


If we wanted to get further details about a particular pid, such as
how much time was spent in each syscall for that pid, we could run
tracewatch-scripts/syscalls-by-pid.pl:

# tracedaemon -o trace.out -z syscall-times-for-pid.pl

Total times per syscall type for pid 1327:

time: 2 usecs for 2 calls
rt_sigprocmask: 7 usecs for 4 calls
fcntl64: 326 usecs for 262 calls
select: 628866 usecs for 2 calls

See the script for an example of manipulating timestamps.


Up until now, the examples have focused mainly on gathering and
summarizing data.  The following examples use the data in the trace
stream to detect possibly sporadic conditions that the user would like
to be notified of when they happen.  For instance, if you have an
important file that keeps getting modified by some unknown assailant,
the tracewatch-scripts/who-modified.pl script helps you track it down.
It provides handlers for the fs_open(), fs_write() and fs_close()
callbacks, which allow it to detect that a file has been modified.  It
also demonstrates the use of the ltt::stop_trace() call, which you can
use from inside your Perl script to automatically stop the trace.  In
this case, when the script detects that the file has been modified, it
prints out that fact and who the culprit was, and then stops the
trace.  There's also a tracewatch-scripts/who-modified-with-tk.pl
script that does the same thing except that when it detects the
modification, it pops up a Tk window, which means you don't have to
constantly be checking the output of the script.  Or use Net::Pager
and have it page you at the beach ;-)

# tracedaemon -o trace.out -z who-modified.pl

The file you were watching (passwd), has been modified!  The culprit is 
pid 2213 [emacs21-x]


The final two examples demonstrate the same idea, but in both cases,
the LTT trace stream doesn't provide enough information to allow
detection of the problem.  The general solution to this is to use
kprobes to insert dynamic tracepoints, which do nothing more than log
the data necessary for our script to detect the situation (kprobes has
been included in the -mm kernel tree and will likely be included in
mainline. )  In the first example, we want to be notified when some
particular file disappears behind our backs and who the culprit is.
Here are the steps you need to carry out to test this:

# tracedaemon -o trace.out -z unlink.pl
# insmod trace-unlink-params.ko
# touch rabbit
# rm rabbit

The file you were watching (rabbit), has disappeared!  The culprit is 
pid 2631 [rm]

In the first step, we start the tracedaemn with the
tracewatch-scripts/unlink.pl script.  We then insmod the test kprobes
module, trace-unlink-params.ko, which instruments the sys_unlink()
system call to send an LTT event when any file is unlinked.  Here's
the relevant code in the kprobes handler in
syscall-kprobes/trace-unlink-params.c.  It simply copies the string
from userspace and logs it to ltt via ltt_log_raw_event().  getname()
can sleep, so it shouldn't really be called from here, but we're just
playing around for now...

	char *tmp = getname(pathname);
	
	if(!IS_ERR(tmp))
		ltt_log_raw_event(scpt.trace_id, strlen(tmp)+1, tmp);

The data we just logged in our kprobe will end up in our Perl
interpreter via the custom_event() handler.  All we need to do there
is use Perl's unpack() routine to get the data back out.  In this
case, we know that what we've logged is a character string, so we go
ahead and unpack one of those, compare it with the file name we're
tracking, and if we get a match, we've detected the file deletion and
can let the user know who the culprit was.

# If the given file disappeared, print the alert message and stop tracing
sub custom_event {
     my ($tv_sec, $tv_usec, $event_id, $data_size, $data) = @_;

     ($filename) = unpack("A*", $data);
     if ($filename =~ /^($alert_if_disappears)$/) {
	print "The file you were watching ($alert_if_disappears), has 
disappeared!  The culprit is pid $current_pid 
[$process_names{$current_pid}]\n";
	ltt::stop_trace();
       }
}


The final example is tracewatch-scripts/kill.pl.  This is similar to
the previous example, except that here, we're trying to figure out
who's killing a particular process.  Here, I started vi, got its pid
from ps and killed it.

# tracedaemon -o trace.out -z kill.p
# insmod trace-kill-params.ko
# kill 2832

The pid you were watching (2832), was killed!  The culprit is pid 2836 
[bash]


We start the tracedaemn with the tracewatch-scripts/kill.pl script.
Again, we then insmod the test kprobes module, trace-kill-params.ko,
which instruments the kill_something_info() kernel function to send an
LTT event when any process is killed.  Here's the relevant code in the
kprobes handler in syscall-kprobes/trace-kill-params.c.  It fills a
simple struct with the relevant values and logs it to ltt via
ltt_log_raw_event().

	event_data.sig = sig;
	event_data.pid = pid;
	event_data.sender_pid = info->si_pid;
	
	ltt_log_raw_event(scpt.trace_id, sizeof(event_data), &event_data);


And here's the corresponding custom_event() Perl handler.  Again, we
use unpack() to unpack 3 ints from the data, compare it with the
process we're interested in, and if we get a match, we know the
process has been killed, and who the culprit is.

# If the given process was killed, print the alert message and stop tracing
sub custom_event {
     my ($tv_sec, $tv_usec, $event_id, $data_size, $data) = @_;

     ($sig, $pid, $sender_pid) = unpack("iii", $data);
     if ($pid == $alert_if_killed) {
	print "The pid you were watching ($alert_if_killed), was killed!  The 
culprit is pid $current_pid [$process_names{$current_pid}]\n";
	ltt::stop_trace(); # Calls into the trace daemon or visualizer
     }
}


Well, that's it as far as examples and documention go - it should be
pretty straightforward if you know a little bit of Perl to just follow
and expand on the current examples.  If you come up with a useful Perl
script, please post it or send it to me and I'll try to include it in
the next version, if there is one.  Oh, and it should be obvious I'm
not an expert Perl programmer, so any cleanup of current scripts would
be welcome too.

I consider the current code to be somewhere between a prototype and
alpha feature at this point - the actual Perl interface and scripting
engine seems pretty solid at this point, and there are callbacks for
all current LTT events, so in that sense things are complete, but
there are some gaping holes that I'll fix if there's sufficient
interest:

- currently things break badly if you trace more than 1 cpu

- currently you need to trace everything in order to get anything.
   The reason for this is that data isn't ready for userspace until a
   sub-buffer is complete (since it uses relayfs bulk mode).  It also
   means there can be a considerable lag between the time an event
   happens and it's seen by the script.  relayfs also supports a packet
   mode, which can be read(2) from when a single event is available.
   This would give you pretty much immediate response time, at the cost
   of lower throughput.  Some thought needs to be given to tuning this
   tradeoff.
- tracevisualizer (i.e. reading from trace file) does the wrong thing
   with the pid/name hash, which it reads from the current system, but
   should be reading the proc.out file actually associated with the trace.
- TSC timestamping doesn't work - you need to use the -o tracedaemon
   option for gettimeofday timestamping
- command-line needs cleaning up

Just FYI, for the time being the only command-lines that's guaranteed
to probably not cause you any problems are the following:

# tracedaemon trace.out -o -z scriptfile

where trace.out is just a placeholder and currenty results in a
0-length file.

# tracevisualizer trace.out -z scriptfile

where trace.out is a real tracefile produced normally by the
tracedaemon.


Unfortunately, getting everything properly patched isn't much fun at 
this point.  This patch is against the 0.9.6-pre3 user tools.  You apply 
the LTT user tools patch (tracewatch.tar.bz2) after you've applied the 
following usertools patch:

http://www.listserv.shafik.org/pipermail/ltt-dev/2004-April/000611.html

which itself is applied to the user tools:

http://www.opersys.com/ftp/pub/LTT/ltt-0.9.6-pre3.tar.bz2

For the kernel side, I used the most recent relayfs and LTT patches 
recently posted to ltt-dev by Mathieu Desnoyers, and the kprobes patches 
   recently posted to the lkml by Prasanna Panchamukhi.  You might want 
to try applying the relayfs and LTT to the latest -mm kernel, which 
already includes kprobes.

relayfs:

http://www.listserv.shafik.org/pipermail/ltt-dev/2004-August/000637.html

LTT:

http://www.listserv.shafik.org/pipermail/ltt-dev/2004-August/000638.html

kprobes:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109231438003930&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109231406530886&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109231366419453&w=2

Regards,

Tom


-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

