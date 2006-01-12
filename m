Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWALJvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWALJvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWALJvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:51:32 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:42936 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1030281AbWALJvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:51:31 -0500
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
References: <43BB05D8.6070101@watson.ibm.com>
	<43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
	<1136414431.22868.115.camel@stark>
	<20060104151730.77df5bf6.akpm@osdl.org>
	<1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>
	<20060105151016.732612fd.akpm@osdl.org>
	<1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
	<43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
	<1137013330.6673.80.camel@stark>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 12 Jan 2006 04:51:30 -0500
In-Reply-To: <1137013330.6673.80.camel@stark>
Message-ID: <yq0k6d53hb1.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matt" == Matt Helsley <matthltc@us.ibm.com> writes:

Matt> On Wed, 2006-01-11 at 05:36 -0500, Jes Sorensen wrote:

Matt> 	I can already tell you I don't like the "magic" mechanism to
Matt> identify notifier blocks. The problem is that it's yet another
Matt> space of id numbers that we have to manage -- either manually,
Matt> by having a person hand the numbers out to developers, or
Matt> automatically using the idr code.  You could use the notifier
Matt> block's address and avoid an additional id space.

Hi Matt,

I did debate with myself whether or not to take the 'magic' approach.
I don't think the allocation is a big issue, it's all compile time
determined and as long as people stick it in task_notifier.h it
doesn't matter if their magic number is changed when it goes into the
official tree.

Using the notifier block's address won't work, they are often
dynamically allocated so a client searching for it will rarely know
the address.

The alternative is to search for a function pointer of one of the call
out functions, howevere it requires all users all provide a specific
function pointer or we need to add some flags for the search function
(eg. one of the TN_ ones could be passed in), but this would
complicate the search function and make it slower. This is the
approach Jack took in his original approach, however Jack's patch had
just a single notifier function and it was the user's respoinsibility
to write the code for the demultiplexing of the callouts. I do not
like this approach as it will be a lot more error prone with everyone
doing their own version.

Matt> 	Also, even if this mechanism goes into task_notify it needs a
Matt> better name than "magic".

Magic is fairly standard for this kind of feature in the kernel,
grep MAGIC include/linux/*.h ;-)

>> I think task_notify it should be usable for statistics gathering as
>> well, the only issue is how to attach it to the processes we wish
>> to gather accounting for. Personally I am not a big fan of the
>> current concept where statistics are gathered for all tasks at all
>> time but just not exported until accounting is enabled.

Matt> 	Have you looked at Alan Stern's notifier chain fix patch?
Matt> Could that be used in task_notify?

No sorry, do you have a pointer?

Matt> 	If not, perhaps the patch use the standard kernel list idioms.

Matt> 	Another potential user for the task_notify functionality is
Matt> the process events connector. The problem is it requires the
Matt> ability to receive notifications about all processes. Also,
Matt> there's a chance that future CKRM code could use all-task and
Matt> per-task notification. Combined with John Hesterberg's feedback
Matt> I think there is strong justification for an all-tasks
Matt> notification interface.

I am wary of this. I don't see how we effectively will be able to do
an all task notification without having to traverse the full task list
and take a ton of global locks. If anybody have any idea to get around
this problem I'd be very interested in hearing their suggestions.

Matt> 	If there was some way to quickly check for registration on an
Matt> all-tasks list you could do both all-task and per-task
Matt> notification in the same code. I took a shot at this a while
Matt> back but the locking was incomplete.  Perhaps a per-cpu all-task
Matt> notification list would satisfy your performance-impact
Matt> concerns.

That could be the approach to take to get around it, but I must admit
I don't know the schedule enough to say whether we will be able to
assign all tasks to one single CPU at any given time and then there's
the issue of locking when they migrate. But again, the latter may
already be handled by the scheduler?

>> The API for the task_notify code is not set in stone and we can add
>> more notifier hooks where needed. If someone has strong reasoning
>> for making changes to the API, then I'll be very open to that.

Matt> 	I'd like to see the all-task notification I mentioned above.
Matt> Notifications where uid/gids change could be useful for auditing
Matt> and process events connector.

If anybody is willing to step up and propose a patch for this I'd be
interested in taking a look. I don't off hand see a simple solution
for it.

Regards,
Jes
