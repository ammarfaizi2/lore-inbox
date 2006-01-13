Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161521AbWAMJ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161521AbWAMJ7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161522AbWAMJ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:59:04 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:14036 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1161521AbWAMJ7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:59:01 -0500
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
	<1137013330.6673.80.camel@stark> <yq0k6d53hb1.fsf@jaguar.mkp.net>
	<1137106871.6673.238.camel@stark>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 13 Jan 2006 04:59:00 -0500
In-Reply-To: <1137106871.6673.238.camel@stark>
Message-ID: <yq07j9430uz.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matt" == Matt Helsley <matthltc@us.ibm.com> writes:

Matt> On Thu, 2006-01-12 at 04:51 -0500, Jes Sorensen wrote:
>> Using the notifier block's address won't work, they are often
>> dynamically allocated so a client searching for it will rarely know
>> the address.

Matt> 	If the task_notify user is responsible for allocating the
Matt> notifier block then it could easily keep a copy of the pointer
Matt> handy for the corresponding deregistration.

And when they are dynamically allocated on a per-object level? Then
you'd have to keep linked lists around to keep track of them. Sorry,
doesn't work.

>> The alternative is to search for a function pointer of one of the
>> call out functions, howevere it requires all users all provide a
>> specific function pointer or we need to add some flags for the
>> search function (eg. one of the TN_ ones could be passed in), but
>> this would complicate the search function and make it slower. This
>> is the approach Jack took in his original approach, however Jack's
>> patch had just a single notifier function and it was the user's
>> respoinsibility to write the code for the demultiplexing of the
>> callouts. I do not like this approach as it will be a lot more
>> error prone with everyone doing their own version.

Matt> 	I don't see how it will be error prone. Jack's interface was
Matt> simple.  And if we're really worred about users messing it up we
Matt> could generate a set of macros that users must use to
Matt> demultiplex the call.

Because experience shows that the more some people copy the same code
someone will get it wrong.

Matt> 	One function pointer per event does bloat the notifier block
Matt> structure.  Given that this notifier block may need to be
Matt> replicated per-task this is a significant amount of
Matt> space. Jack's demultiplexing approach requires that the space be
Matt> proportional to the number of event functions instead of
Matt> proportional to the number of notifier blocks.

Matt> 	Furthermore, if new task events are added this structure would
Matt> need to be expanded. In contrast, Jack's approach only required
Matt> the addition of a new event value.

Matt> 	For these reasons I think using a single function pointer will
Matt> be much more effective.

So you add a few pointers per task compared to the code that does the
demultiplexing. We're talkin 3-4 extra pointers in comparison to the
demultiplexing code *and* the extra function call.

My approach is consitent with the rest of the kernel does for most
structures, struct file operations etc.

But if thats what makes the difference as to whether we go for this
type of API, then lets change it back. I am not married to the API,
but rather the functionality.

Matt> No problem. Here it is:
Matt> http://marc.theaimsgroup.com/?l=linux-kernel&m=113407207418475&w=2

Matt> I think it would be ideal if task_notify could simply be a
Matt> notifier chain for notifying users of task events/changes.

Thats really what it was intended for, but of course only in the
task's own context.

>>  That could be the approach to take to get around it, but I must
>> admit I don't know the schedule enough to say whether we will be
>> able to assign all tasks to one single CPU at any given time and
>> then there's the issue of locking when they migrate. But again, the
>> latter may already be handled by the scheduler?

Matt> 	"all-task" means the notification block calls its function
Matt> when any task triggers a traversal of the notification
Matt> lists. This does not imply that registration/call/deregister of
Matt> an all-task notification must traverse all tasks.

Well then the name is somewhat misleading ;-) Sounds almost like
something that could fit into Erik's Job stuff, but I guess it's a
question of what criteria those tasks are put onto that list with.

Being a little short on the history, are there any pointers to
examples or descriptions of what this would be used for? Curious to
understand the usage pattern.

Matt> I'd like to see the all-task notification I mentioned above.
Matt> Notifications where uid/gids change could be useful for auditing
Matt> and process events connector.
>>  If anybody is willing to step up and propose a patch for this I'd
>> be interested in taking a look. I don't off hand see a simple
>> solution for it.

Matt> 	Keith posted an interesting patch for notification chains that
Matt> I believe could address your concerns -- though from what I've
Matt> read it needs to disable preemption. As far as adding
Matt> notifications for uid/gid change, that's relatively trivial. You
Matt> might look at some revisions of task_notify that Chandra
Matt> Seetharaman and I have posted.

I did go through the archives a while back and I did notice that both
Jack and Erik pointed out a number of issues with those approaches. If
we are going to do the task-group-notify thing, then going to Keith's
approach is probably the best.

Cheers,
Jes
