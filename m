Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVEKFqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVEKFqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 01:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVEKFqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 01:46:48 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:21371 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261897AbVEKFqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 01:46:35 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Date: Wed, 11 May 2005 00:46:27 -0500
User-Agent: KMail/1.8
Cc: dmitry.torokhov@gmail.com, netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru> <d120d500050510105012d4ba8b@mail.gmail.com> <20050510222424.5b411c89@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050510222424.5b411c89@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505110046.28797.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 May 2005 13:24, Evgeniy Polyakov wrote:
> On Tue, 10 May 2005 12:50:55 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On 5/10/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > On Tue, 10 May 2005 09:56:45 -0500
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > 
> > > > On 5/10/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > > On Tue, 10 May 2005 01:18:46 -0500
> > > > > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > >
> > > > > > - drop cn_dev - there is only one connector;
> > > > >
> > > > > There may be several connectors with different socket types.
> > > > > I use it in my environment for tests.
> > > > >
> > > >
> > > > Why do you need that? u32 ID space is not enough?
> > > 
> > > They use different netlink sockets.
> > > One of them can fail during initialisation, for example...
> > 
> > Are you saying that there more chances successfully allocating 2
> > netlink sockets than one?
> 
> Of course - one may be in use by ipt_ULOG for example.

And what does it have to do with multiple connectors and different sockets?
You just need to find one free socket, once you found it you have only one
instance of connector running.

> Although probably it could be better to get new unit from David Miller.
> I want to create some kind of unused-in-kernel socket number - 
> each netlink user outside kernel might use it without kernel users
> bothering.

Right.

> > > 
> > > > > > - simplify cn_notify_request to carry only one range - it simplifies code
> > > > > >   quite a bit - nothing stops clientd from sending several notification
> > > > > >   requests;
> > > > >
> > > > > ? Nothing stops clients from sending several notification requests now.
> > > > > I do not see how it simplifies the things?
> > > > > Feel free to set idx_num and val_num to 1 and you will have the same.
> > > >
> > > > Compare the implementaion - without variable-length notification
> > > > requests the code is much simplier and flexible.
> > > 
> > > Hmm, old request had a length, new one - does not.
> > > But instead of atomically addition of the whole set, one need to send
> > > couple of events.
> > > I do not see any profit here.
> > 
> > Smaller kernel code, simpler notification structure, ability to stop
> > listenig to a certain events without re-registering the rest of the
> > block.
> 
> As I said - set idx and val numbers to one and you will have the same 
> behaviour.
> Code is neither smaller [ok, you removed a loop] nor simplier 
>  - it is functionality decreasing.

Actually, I would do yet another step and just put something like

int cn_request_notify(u32 group, u32 idx, u32 idx_range, u32 val, u32 val_range)
int cn_cancel_notify(u32 group, u32 idx, u32 idx_range, u32 val, u32 val_range)

into connector core. Then drivers could do something like this:

static int cn_test_want_notify(void)
{
        int error;

	error = cn_request_notify(1, cn_test_id.idx, 10, cn_test_id.val, 10);
        if (error)
		return error;

	error = cn_request_notify(1, cn_test_id.idx, 10, cn_test_id.val + 20, 10);
	if (error) {
		/* unregister */
		cn_cancel_notify(1, cn_test_id.idx, 10, cn_test_id.val, 10);
		return error;
	}

        return 0;
}

No messing up with memory allocations and complex message structures.

> > > > > Connector with your changes just does not work.
> > > >
> > > > As in "I tried to run it and adjusted the application for the new
> > > > cn_notify_req size and it does not work" or "I am saying it does not
> > > > work"?
> > > 
> > > Second, i.e. "I am saing it does not work".
> > > With your changes userspace just does not see any message being sent by kernelspace.
> > 
> > Would you care to elaborate on this please. As far as I know
> > kernel->userspace path was not changed at all.
> 
> I inserted your module and test module, which sends a message using cn_netlink_send()
> one time per second.
> Usersace application bound to -1 group does not receive that messages.

Works for me:

root@core cntest]# ./a.out
recvfrom successful
counter = 0
recvfrom successful
counter = 1
recvfrom successful
counter = 2
recvfrom successful
counter = 3
recvfrom successful
counter = 4
recvfrom successful
counter = 5
recvfrom successful
counter = 6
recvfrom successful
counter = 7
recvfrom successful
counter = 8

(I won't ever show anyone that gutted piece of ulogd that produced these
messages :) )
 
Try recompiling your userspace application, messages were changed a bit.

> > > > > Dmitry, I do not understand why do you change things in so radical manner,
> > > > > especially when there are no 1. new interesting features, 2. no performance
> > > > > improvements, 3. no right design changes.
> > > >
> > > > There is a right design change - it keeps the code simple. It peels
> > > > all the layers you invented for something that does not really need
> > > > layers - connector is just a simple wrapper over raw netlink.
> > > 
> > > That is your opinion.
> > > 
> > > Code is already as simple as possible, since it is layered and each
> > > piece of code is separated from different logical entities.
> > > 
> > > > When I look at the code I see the mess of unneeded refcounting, wrong
> > > > kinds of locking, over-engineering. Of course I want to change it.
> > > 
> > > There are no unneded reference counting now.
> > > Locking was not wrong - you only placed semaphore instead of notify BH lock
> > > just to have ability to sleep under the lock and send callback addition/removing
> > > notification with GFP_KERNEL mask,
> > > and it is probably right change from the first view, as I said,
> > > but it can be implemented in a different way.
> > 
> > That's what I was referring to as "wring locking". Notifications do
> > not need to stop bottom handlers, a spinlock or semaphore willl work
> > just fine. SInce I wanted to allocate memory only after I determined
> > that it is a new  notify request a semaphore was a better choise.
> 
> I will think of it, but in long-time I do not like such approach - 
> it is some kind of deadlock - we have no memory, so we sleep in allocation,
> so we can not remove callback since it will sleep in allocation...

There is no deadlock. We are not waiting for memory to be freed, we are
waiting for paging.

> > > > Keep it simple. Except for your testing environment why do you need to
> > > > have separate netlink sockets? You have an ample ID space. Why do you
> > > > need separate cn_dev and cn_queue_dev (and in the end have them at
> > > > all)? Why do you need "input" handler, do you expect to use different
> > > > handlers? If so which? And why? Do you expect to use other transports?
> > > > If so which? And why? You need to have justifiction for every
> > > > additional layer you putting on.
> > > 
> > > Sigh.
> > > It was already answered so many times, as far as I remember...
> > > Ok, let's do it again.
> > > 
> > > Several netlink sockets - if you can see, connector uses NETLINK_ULOG
> > > for it's notification, you can not use the same socket twice, so you
> > > may have new device with new socket, or several of them, and system
> > > may work if one initialisation failed.
> > 
> > Or it may not. Why do you think that having several sockets is safer
> > than using one? After all, it is just a matter of setting it up and
> > finally allocating a separate socket number for connector.
> 
> Yes, there can be such a way.
> But when connector was not in mainline it used TUN/TAP netlink sockets
> and tried to get one by one, until successfully allocated.
> Using dmesg userspace could find needed socket number for itself.
>

And in the end you have one connector bound to some socket. There is no
multiple connectors - the goal (as far as I see it) was to have single
transport web of messages and callbacks for entire kernel. It does not make
sense to divide it.
  
> > > cn_dev is connector device structure, cn_queue_dev - it's queueing part.
> > > input handler is needed for ability to receive messages.
> > 
> > You chose not to understand my question. Why do you need to have is as
> > a pointer? Do you expect to have different input handler?
> 
> In runtime - no.
> cn_dev is a main transport structure, while cn_queue_dev is for
> callback queue handling.
> 
> > > Couple of next questions can be answered in one reply:
> > > original connector's idea was to implement notification based
> > > not on top of netlink protocol, but using ioctls of char device,
> > > so there could be different connector device, input method,
> > > transport and so on. Probably I will not implement it thought.
> > 
> > IOW this all is remnants of an older design. You have no plans to
> > utilize the framework and therefore it is not needed anymore and can
> > be dropped.
> 
> Different connector devices still there.
> They use different sockets.
> Concider netlink2 [with guaranteed delivering - I have some ideas about it] - 
> one just needs to add a new connector device, no new braindumping and
> recalling how it was cool before.
> It will require some changes to the connector structure, but it will not 
> be complete rewrite because some time ago someone decided we do not
> need it and completely removed anything that lives outside simple
> netlink wrapper.

Think about implications some more - userspace needs to be aware and chose
what socket to bind to, applications will change... Messages will change.
In-kernel users will also have to select kind of transport they want to use
(guaranteed delivery or not) - it looks like you'll be better off having
these connectors completely separated.

-- 
Dmitry
