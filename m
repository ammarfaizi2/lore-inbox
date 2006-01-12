Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161432AbWALXHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWALXHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161429AbWALXHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:07:07 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:28833 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161414AbWALXHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:07:04 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit
	Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
In-Reply-To: <yq0k6d53hb1.fsf@jaguar.mkp.net>
References: <43BB05D8.6070101@watson.ibm.com>
	 <43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
	 <1136414431.22868.115.camel@stark> <20060104151730.77df5bf6.akpm@osdl.org>
	 <1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>
	 <20060105151016.732612fd.akpm@osdl.org> <1136505973.22868.192.camel@stark>
	 <yq08xttybrx.fsf@jaguar.mkp.net> <43BE9E91.9060302@watson.ibm.com>
	 <yq0wth72gr6.fsf@jaguar.mkp.net> <1137013330.6673.80.camel@stark>
	 <yq0k6d53hb1.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 15:01:10 -0800
Message-Id: <1137106871.6673.238.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 04:51 -0500, Jes Sorensen wrote:
> >>>>> "Matt" == Matt Helsley <matthltc@us.ibm.com> writes:
> 
> Matt> On Wed, 2006-01-11 at 05:36 -0500, Jes Sorensen wrote:
> 
> Matt> 	I can already tell you I don't like the "magic" mechanism to
> Matt> identify notifier blocks. The problem is that it's yet another
> Matt> space of id numbers that we have to manage -- either manually,
> Matt> by having a person hand the numbers out to developers, or
> Matt> automatically using the idr code.  You could use the notifier
> Matt> block's address and avoid an additional id space.
> 
> Hi Matt,
> 
> I did debate with myself whether or not to take the 'magic' approach.
> I don't think the allocation is a big issue, it's all compile time
> determined and as long as people stick it in task_notifier.h it
> doesn't matter if their magic number is changed when it goes into the
> official tree.
> 
> Using the notifier block's address won't work, they are often
> dynamically allocated so a client searching for it will rarely know
> the address.

	If the task_notify user is responsible for allocating the notifier
block then it could easily keep a copy of the pointer handy for the
corresponding deregistration.

> The alternative is to search for a function pointer of one of the call
> out functions, howevere it requires all users all provide a specific
> function pointer or we need to add some flags for the search function
> (eg. one of the TN_ ones could be passed in), but this would
> complicate the search function and make it slower. This is the
> approach Jack took in his original approach, however Jack's patch had
> just a single notifier function and it was the user's respoinsibility
> to write the code for the demultiplexing of the callouts. I do not
> like this approach as it will be a lot more error prone with everyone
> doing their own version.

	I don't see how it will be error prone. Jack's interface was simple.
And if we're really worred about users messing it up we could generate a
set of macros that users must use to demultiplex the call.

	One function pointer per event does bloat the notifier block structure.
Given that this notifier block may need to be replicated per-task this
is a significant amount of space. Jack's demultiplexing approach
requires that the space be proportional to the number of event functions
instead of proportional to the number of notifier blocks.

	Furthermore, if new task events are added this structure would need to
be expanded. In contrast, Jack's approach only required the addition of
a new event value.

	For these reasons I think using a single function pointer will be much
more effective.

> Matt> 	Also, even if this mechanism goes into task_notify it needs a
> Matt> better name than "magic".
> 
> Magic is fairly standard for this kind of feature in the kernel,
> grep MAGIC include/linux/*.h ;-)

Using ids and pointers in the kernel are pretty standard to. I invite
you to grep for those and count them too ;)

Seriously, it's a nit but I think the name could better reflect the
purpose of the field.

> >> I think task_notify it should be usable for statistics gathering as
> >> well, the only issue is how to attach it to the processes we wish
> >> to gather accounting for. Personally I am not a big fan of the
> >> current concept where statistics are gathered for all tasks at all
> >> time but just not exported until accounting is enabled.
> 
> Matt> 	Have you looked at Alan Stern's notifier chain fix patch?
> Matt> Could that be used in task_notify?
> 
> No sorry, do you have a pointer?

No problem. Here it is:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113407207418475&w=2

I think it would be ideal if task_notify could simply be a notifier
chain for notifying users of task events/changes.

> Matt> 	If not, perhaps the patch use the standard kernel list idioms.
> Matt> 	Another potential user for the task_notify functionality is
> Matt> the process events connector. The problem is it requires the
> Matt> ability to receive notifications about all processes. Also,
> Matt> there's a chance that future CKRM code could use all-task and
> Matt> per-task notification. Combined with John Hesterberg's feedback
> Matt> I think there is strong justification for an all-tasks
> Matt> notification interface.
> 
> I am wary of this. I don't see how we effectively will be able to do
> an all task notification without having to traverse the full task list
> and take a ton of global locks. If anybody have any idea to get around
> this problem I'd be very interested in hearing their suggestions.

	Why would we have to traverse the full task list?! Just add one
notifier block to a single, global list of notifiers. Keith's patch
demonstrates one potential method of avoiding a lock in the common path:
traversing the notification chain and making the calls.

> Matt> 	If there was some way to quickly check for registration on an
> Matt> all-tasks list you could do both all-task and per-task
> Matt> notification in the same code. I took a shot at this a while
> Matt> back but the locking was incomplete.  Perhaps a per-cpu all-task
> Matt> notification list would satisfy your performance-impact
> Matt> concerns.
> 
> That could be the approach to take to get around it, but I must admit
> I don't know the schedule enough to say whether we will be able to
> assign all tasks to one single CPU at any given time and then there's
> the issue of locking when they migrate. But again, the latter may
> already be handled by the scheduler?

	"all-task" means the notification block calls its function when any
task triggers a traversal of the notification lists. This does not imply
that registration/call/deregister of an all-task notification must
traverse all tasks.

> >> The API for the task_notify code is not set in stone and we can add
> >> more notifier hooks where needed. If someone has strong reasoning
> >> for making changes to the API, then I'll be very open to that.
> 
> Matt> 	I'd like to see the all-task notification I mentioned above.
> Matt> Notifications where uid/gids change could be useful for auditing
> Matt> and process events connector.
> 
> If anybody is willing to step up and propose a patch for this I'd be
> interested in taking a look. I don't off hand see a simple solution
> for it.

	Keith posted an interesting patch for notification chains that I
believe could address your concerns -- though from what I've read it
needs to disable preemption. As far as adding notifications for uid/gid
change, that's relatively trivial. You might look at some revisions of
task_notify that Chandra Seetharaman and I have posted.

Cheers,
	-Matt

