Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSIYAMa>; Tue, 24 Sep 2002 20:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSIYAMa>; Tue, 24 Sep 2002 20:12:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2498 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261829AbSIYAM2>;
	Tue, 24 Sep 2002 20:12:28 -0400
Message-ID: <3D910033.1E1A1641@us.ibm.com>
Date: Tue, 24 Sep 2002 17:15:47 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [evlog-dev] Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com> <3D90C670.90508@pobox.com> <3D90CACE.595EA229@us.ibm.com> <3D90CC8F.4080706@pobox.com> <3D90D503.8F4CDEB6@us.ibm.com> <3D90D889.2040608@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I've already seen the event logging userspace API, thanks.
> 

You're welcome.

> Are you saying that netlink is not useful for event delivery inside the
> kernel?  It seems useful to me.  Are you saying that netlink is
> incompatible with the POSIX event logging interface?  My initial
> thinking is that it seems compatible, just the syscalls[interface] is a
> bit different.

Yes, the evlogd daemon could use netlink to capture in-kernel events,
as you are suggesting, but we chose a more general approach where
events written with native evlog functions (like problem() ;-) as well
as "forwarded printks" (which was not included in yesterday's patches
for sake of brevity ;-) are queued in an in-kernel event buffer.
Don't worry, except for an added function call, printk is otherwise
unchanged when CONFIG_EVLOG is defined.

The evlogd daemon then calls do_syslog() to read events from the 
in-kernel buffer, write them into an event log, generates event
notification, etc.  So unlike netlink, setting up event notification
is stictly done in userspace.  Also, the notification mechanism
works for userspace events as well as kernel events.  

Now, at the risk of diverting attention away from the problem()
macros proposal, we've also been prototyping an enhancement to 
the "printk forwarding", which is nearly identical to what you've 
proposed...
the format string (verbatim), and 0 or more argument values,
along with the return address of the calling fucnction, is captured
in the event record (instead of just storing the pre-formatted printk
in the event record, like we do now).  Re-combining fragmented printks (since multiple printks are non-atomic) is done by the evlogd. 

By keeping the format strings verbatim in the event records, you
could do translations in user-space, and possibly even fabricate
argument tags after-the-fact.  Some prototyping to munge the
printk event records in userspace is being worked, but its
technical feasibility still remains to be proven.

> Now, turning to a tangent topic that relates to either scheme...

> With either your proposal or mine, event logging is far more useful if 
> similar drivers spit out similar diagnostics.  i.e. it's less useful if 
> 8139too net driver spits out 'status16' in one interrupt event, and 
> 8139cp net driver spits out 'status32' in another.  Though they are 
> different hardware and the values mean different things, my point is the 
> concepts are similar, and thus better diagnostics are achieved with 
> subsystem diagnostic standards.

> Such standards are in actuality independent of event logging per se, but 
> if IBM wants to push this thing, I would like to see some proposals as 
> to what IBM actually wants drivers to log.  I have not seen that at all, 
> and think that such proposals should be an integral part of an event 
> logging system.  Otherwise the diagnostics are less useful, and IBM 
> would have failed to demonstrate an adequate grasp of the problem domain 
> [which then leads to other, typical software engineering problems...]

> "What do you want to log?" is as important to me as "how do you want to 
> log it?"  And the answers to the two questions are very much intertwined.

Yes, agreed.  But, once we've all agreed on WHAT to log
(and achieved world peace), we're still left with the question of "what
is/are the best logging interface(s) to use ?"  As long as we've 
acknowledged the need to do better logging, why not re-engineer the
logging interface before developers start re-instrumenting their device
drivers ? 

The verdict is still out, but with some more tweaking and
tuning I think that "problem()" has advantages over printk, perhaps
not so much for developers, but for anyone who has to interpret and
act upon information being logged in the kernel.  I won't elaborate on
the disadvantages...you've already done a throrugh job of that :-),
just as Rusty has done a good job elaborating on the advantages.
 
 




...
