Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTCEH3Q>; Wed, 5 Mar 2003 02:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTCEH3Q>; Wed, 5 Mar 2003 02:29:16 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:16859 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S264919AbTCEH3J>;
	Wed, 5 Mar 2003 02:29:09 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303050739.h257dae32460@csl.stanford.edu>
Subject: [CHECKER] more potential deadlocks
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Mar 2003 23:39:36 -0800 (PST)
Cc: mc@cs.stanford.edu
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

here are some more potential deadlocks.  These results are just for:
 	drivers/pci* 
	drivers/usb* 
	drivers/ide* 
	drivers/scsi* 
	net/*ipv[46]*/netfilter* 
	ipc/* 
	mm/* 
	kernel/* 
	net/*ipv4_* 

if there are any other directories that people are likely to inspect
bugs from, let me know and I'll add them.

These deadlocks often involve locks accessed through pointers.
Unfortunately, if the pointers can never point to the same object the
error is a false positive.

BTW, is there a locking ettiquette w.r.t. cli()?  E.g., are you not
supposed to acquire a spinlock if you have interrupts disabled (or
vice versa)?

Dawson


--------------------------------------------------
BUG [almost certainly]: interesting case: they acquire cpp->mutex then
    ccp->readmutex but then release cpp->mutex and reaquire it (deadlocks
    if someone else has grabbed cpp->mutex)

        if (down_interruptible (&ccp->mutex))
                return -ERESTARTSYS;

	...

        /* only one reader per device allowed */
        if (down_interruptible (&ccp->readmutex)) {

	...

        if (down_interruptible (&ccp->mutex)) {


ERROR: 1 thread deadlock.
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)> occurred 1 times
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)> occurred 1 times
  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0) =
    depth = 1:
	/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1620
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1711

  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0) =
    depth = 1:
	/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1610
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1620

--------------------------------------------------
BUG: seems like it though open and disconnect may be mutually exclusive
     for other reasons (likely...).

 ERROR: 1 thread deadlock.
   <&dev_table_mutex>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)> occurred 1 times
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)>-><&dev_table_mutex> occurred 1 times
  &dev_table_mutex->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0) =
    depth = 1:
	/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_open:1404
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_open:1412


        /* usb device available? */
        if (down_interruptible (&dev_table_mutex)) {
                return -ERESTARTSYS;
        }
        cp = dev_table[dtindex];
        if (cp == NULL) {
                up (&dev_table_mutex);
                return -ENODEV;
        }
        if (down_interruptible (&cp->mutex)) {

        up (&dev_table_mutex);

  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)->&dev_table_mutex =
    depth = 1:
	/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerswald_disconnect:2091
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerswald_disconnect:2096


        down (&cp->mutex);
        info ("device /dev/usb/%s now disconnecting", cp->name);

        /* remove from device table */
        /* Nobody can open() this device any more */
        down (&dev_table_mutex);
        dev_table[cp->dtindex] = NULL;
        up (&dev_table_mutex);


--------------------------------------------------
BUG?  but might be that the two different head pointers cannot point to
      the same object.  not clear alias analysis will actually help here
      since things are so hairy.

ERROR: 1 thread deadlock.
   <&tw_death_lock>-><struct tcp_bind_hashbucket.lock (<local>:0)> occurred 1 times
   <struct tcp_bind_hashbucket.lock (<local>:0)>-><&tw_death_lock> occurred 1 times
  &tw_death_lock->struct tcp_bind_hashbucket.lock (<local>:0) =
    depth = 3:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_twcal_tick__thr:592

        spin_lock(&tw_death_lock);

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_twcal_tick__thr:592
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_twcal_tick__thr:607
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_timewait_kill:65
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_timewait_kill:74
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_timewait_kill:78
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_timewait_kill:78

        spin_lock(&bhead->lock);


  struct tcp_bind_hashbucket.lock (<local>:0)->&tw_death_lock =
    depth = 3:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:tcp_v4_hash_connect:683

      head = &tcp_bhash[tcp_bhashfn(rover)];
      spin_lock(&head->lock);

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:tcp_v4_hash_connect:683
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:tcp_v4_hash_connect:694
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:__tcp_v4_check_established:561
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:__tcp_v4_check_established:622
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:__tcp_v4_check_established:629
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_tw_deschedule:481
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_tw_deschedule:481


/* This is for handling early-kills of TIME_WAIT sockets. */
void tcp_tw_deschedule(struct tcp_tw_bucket *tw)
{
        spin_lock(&tw_death_lock);
        if (tw->pprev_death) {
                if(tw->next_death)


--------------------------------------------------
BUG? seems like it, if the objects can point to the same thing.
ERROR: 1 thread deadlock.
   <struct uhci_hcd.complete_list_lock (<local>:0)>-><struct urb.lock (<local>:0)> occurred 2 times
   <struct urb.lock (<local>:0)>-><struct uhci_hcd.complete_list_lock (<local>:0)> occurred 1 times
  struct uhci_hcd.complete_list_lock (<local>:0)->struct urb.lock (<local>:0) =
    depth = 2:
	/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-debug.c:uhci_show_lists:395

        spin_lock_irqsave(&uhci->complete_list_lock, flags);


	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-debug.c:uhci_show_lists:395
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-debug.c:uhci_show_lists:411
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-debug.c:uhci_show_lists:407
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-debug.c:uhci_show_urbp:328
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-debug.c:uhci_show_urbp:328


        spin_lock(&urbp->urb->lock);
        count = 0;

  struct urb.lock (<local>:0)->struct uhci_hcd.complete_list_lock (<local>:0) =
    depth = 2:
	/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-hcd.c:uhci_transfer_result:1507


        spin_lock_irqsave(&urb->lock, flags);

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-hcd.c:uhci_transfer_result:1507
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-hcd.c:uhci_transfer_result:1568
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-hcd.c:uhci_add_complete:138
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/host/uhci-hcd.c:uhci_add_complete:138


        spin_lock_irqsave(&uhci->complete_list_lock, flags);


--------------------------------------------------
BUG: seems like it, if they can point to the same thing.  ERROR: 1 thread deadlock.
   <struct in_device.lock (<local>:0)>-><struct ip_mc_list.lock (<local>:0)> occurred 5 times
   <struct ip_mc_list.lock (<local>:0)>-><struct in_device.lock (<local>:0)> occurred 5 times
  struct in_device.lock (<local>:0)->struct ip_mc_list.lock (<local>:0) =
    depth = 2:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:338

        read_lock(&in_dev->lock);
        for (im=in_dev->mc_list; im!=

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:338
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:346
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:344
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_mod_timer:165

static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
{
        spin_lock_bh(&im->lock);
        im->unsolicit_count = 0;


	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_mod_timer:165
    depth = 2:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:302
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:302
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:309
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:305
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_stop_timer:144
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_stop_timer:144

  struct ip_mc_list.lock (<local>:0)->struct in_device.lock (<local>:0) =
    depth = 6:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_timer_expire:268
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_timer_expire:268

        spin_lock(&im->lock);

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_timer_expire:274
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_send_report:214
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/route.c:ip_route_output_key:2149
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/route.c:__ip_route_output_key:2142
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/route.c:ip_route_output_slow:2022
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:ip_check_mc:772
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:ip_check_mc:772

                
int ip_check_mc(struct in_device *in_dev, u32 mc_addr)
{                       
        struct ip_mc_list *im;

        read_lock(&in_dev->lock);


--------------------------------------------------
BUG? very hard to follow, but interesting if a real bug.  unfortunately,
could also be a false positive because of 
	1. infeasible callchain path or 

	2. the various in_dev and im pointers never actually point to
	   the same object.

requires three threads: 
	thread 1: acquires im->lock then tries to get inetdev_lock
	thread 2: acquires inetdev_lock and tries to get in_dev->lock.
	thread 3: acquires in_dev->lock and tries to get im->lock.

ERROR: 2 thread deadlock.
   <struct ip_mc_list.lock (<local>:0)>-><&inetdev_lock> occurred 5 times
   <&inetdev_lock>-><struct ip_mc_list.lock (<local>:0)> occurred 4 times
  struct ip_mc_list.lock (<local>:0)->&inetdev_lock =
    depth = 7:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_timer_expire:268


        spin_lock(&im->lock);
        im->tm_running=0;

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_timer_expire:268
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_timer_expire:274
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_send_report:214
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/route.c:ip_route_output_key:2149
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/route.c:__ip_route_output_key:2142
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/route.c:ip_route_output_slow:1988
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_semantics.c:__fib_res_prefsrc:638
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/devinet.c:inet_select_addr:759
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/devinet.c:inet_select_addr:759

        read_lock(&inetdev_lock);

  &inetdev_lock->struct ip_mc_list.lock (<local>:0) =
   thread 1: <&inetdev_lock,struct in_device.lock>
    depth = 1:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/devinet.c:inet_select_addr:759

        read_lock(&inetdev_lock);

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/devinet.c:inet_select_addr:764

        read_lock(&in_dev->lock);


   thread 2: <struct in_device.lock,struct ip_mc_list.lock>
    depth = 2:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:338
        read_lock(&in_dev->lock);

	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:338
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:346
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_query:344
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_mod_timer:165
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_mod_timer:165

        spin_lock_bh(&im->lock);


    depth = 2:
	/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:302
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:302
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:309
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_heard_report:305
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_stop_timer:144
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:igmp_stop_timer:144
