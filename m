Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVC3BGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVC3BGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVC3BGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:06:16 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:60651 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261689AbVC3BF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:05:28 -0500
Date: Tue, 29 Mar 2005 17:05:00 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: guillaume.thouvenin@bull.net, johnpol@2ka.mipt.ru, akpm@osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329170500.66d047b9.pj@engr.sgi.com>
In-Reply-To: <4249A206.4010506@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112079856.5243.24.camel@uganda>
	<20050329004915.27cd0edf.pj@engr.sgi.com>
	<1112087822.8426.46.camel@frecb000711.frec.bull.fr>
	<20050329072335.52b06462.pj@engr.sgi.com>
	<4249A206.4010506@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Hmmm .. the following pertains more to accounting than to fork_connector,
  as have my other remarks earlier today.  I notice just now I am on a thread
  whose Subject is "fork_connector".   Oh well.  Sorry.          - pj ]

Jay wrote:
> You probably can look at it this way: the accounting data being
> written out by BSD are per process data and the fork connector
> provides information needed to group processes into process
> aggregates.

I guess so.  Though that doesn't provide any explicit guidance as to
what the necessary dataflow must be -- who (which essential piece(s) of
software) needs the data when, to accomplish what purposes that some
Linux users will desire.

Well, maybe to someone expert in Process Aggregates, it provides
such guidance, implicitly.  That's definitely not I.

  Let me step back a minute here.

  What's needed to is work from the actual user requirements down
  to what technical pieces are needed.  There's an old saying
  that if you want something done bad enough, do it yourself.

  Or, on usenet and now on mailing lists, this has become:
  if you want something done, post a sufficiently botched
  example yourself, and someone who actually knows will become
  sufficiently annoyed to post a useful answer.

  So here goes my botched effort to work from user requirements
  down to actual technical pieces needed.  I look forward to
  being shot down in flames.

My current understanding of the 'system accounting' requirement
is that users of large shared resource servers want to determine,
after the fact, what was the usage by or for various
tasks/jobs/users/groups/time-periods of various compute
resources, in order to perform such tasks as billing and sizing
of future equipment needs, and to identify patterns of over or
under utilized system resources that might present other
opportunities for useful action, or causes for remedial action.

I am working under the assumption that there is some accounting
(of computer users and resources, not of money ;) software
(runnacct, CSA, and ELSA, for example) that runs, after the fact
in some post-processing mode, that reads records of actual usage
details from disk files and does useful stuff (like generate
reports useful to the above requirements) with what it can glean
from those records and from other configuration information
it can find about the current system (by reading other disk
files, typically).  This processing can be and often is done
in batch mode, and is often scheduled out of a cron job for some
time when the system is normally under relatively lighter load,
such as late at night.

I assume that the information needed by this accounting software
includes both the classic BSD accounting records and the
<parent_pid, child_pid> information at fork.

I am not aware of any other uses of the <parent_pid, child_pid>
information from fork, though it would not surprise me to learn
that there other such uses - you're welcome to educate me on
this matter.

I suspect that there is other information, or will be, in
addition to the specific details collected by the classic bsd
accounting kernel hooks, and in addition to the <parent_pid,
child_pid> information at fork, which will also be needed by CSA
and/or ELSA, and which also needs to be written to disk files
as the data is collected, for subsequent processing by such
accounting software as CSA and ELSA, or the classic runacct(1M)
daily accounting software and variants.

If the above is all true, then the basic problem to solve
regarding the <parent_pid, child_pid> information collected at
fork is how to get it into a disk file, with close to minimum
impact on the system.

Since the data is not needed in anything like realtime (or
if it is, I don't realize that yet) therefore there is an
opportunity to combine the data records into buffers of data,
so as to amortize some of the costs of writing the data to
disk over several records.  The classic bsd accounting hooks
do this merging aggressively, in the context of the process
doing the exit.

The classic accounting hooks may have a problem that they are not
NUMA friendly - having all the nodes in a big system trying to
simultaneously add small (64 bytes, typically) snippets to the
same shared file buffers at the same time might not scale well.
These hooks were designed over 25 years ago, when multiprocessing
was in its infancy, and may need overhaul.

The fork_connector mechanism is being proposed to get the
particular bit of information <parent_pid, child_pid> from
fork moved to what I presume is a data collector daemon user
process, which will I presume then write merged records of
this data to disk.  This may have the problem that it moves
the individual records between various contexts on the system,
more than is necessary, before it can be merged into buffers
and written.  While such data motion does not happen inline
to the fork itself, it still has to occur in near realtime
(minutes) of the fork event, so still impacts system performance
(both CPU cycles and memory footprint) during peak usage hours.
Performance impact numbers have been presented to show that
this impact is minimal, but my direct question as to whether
these numbers include the load of the data collector and writer
daemon has gone unanswered, so far as I know.

So this is what I understand the problems and the requirements
to be.

Most likely I misunderstand important parts of this - I invite
corrections.  I don't actually have a horse in this race; I'm just
doing the color commentary.  So if someone wants to rip this apart,
then go for it.  I will enjoy the show along with everyone else.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
