Return-Path: <linux-kernel-owner+w=401wt.eu-S933021AbWL1Seb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021AbWL1Seb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933025AbWL1Seb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:34:31 -0500
Received: from mta7.adelphia.net ([68.168.78.193]:50250 "EHLO
	mta7.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933021AbWL1Sea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:34:30 -0500
Message-ID: <45940A85.3020707@acm.org>
Date: Thu, 28 Dec 2006 12:18:45 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Carol Hebert <cah@us.ibm.com>
Subject: Re: [Patch 2/12] IPMI: remove interface number limits
References: <20061202042422.GB30214@localdomain> <20061222010238.GC4451@linux.vnet.ibm.com>
In-Reply-To: <20061222010238.GC4451@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Fri, Dec 01, 2006 at 10:24:22PM -0600, Corey Minyard wrote:
>   
>> This patch removes the arbitrary limit of number of IPMI interfaces.
>> This has been tested with 8 interfaces.
>>     
>
> I got a bit lost in this patch, so applied it to 2.6.19-rc6 and looked
> over the resulting file.  Some of the issues predate this patch, which
> I guess goes to show that I have not been paying enough attention.
> I do not claim to be an IPMI expert, so may well be missing something.
>
> In general, though, good application of RCU -- SMIs and locks don't
> get along so well.  ;-)
>
> All that said, here are my thoughts.  The first two issues (marked with
> "!")  seem to need the most urgent attention.
>
> 						Thanx, Paul
>
> drivers/char/ipmi/ipmi_msghandler.c:
>
> !	clean_up_interface_data(), line 394: What prevents an RCU reader
> 	from finding the raw list_head "list" and interpreting stack
> 	garbage as a semi-valid ipmi_smi_t?  (The list_add_rcu() adds
> 	an unadorned struct list_head to the list.)
>
> 	Unless the RCU readers do something clever to reject this
> 	entry, should instead link an ipmi_smi_t into the list to
> 	avoid confusing the readers.  See below, at least some
> 	RCU readers are not being clever.
>
> !	clean_up_interface_data(), line 395: If RCU readers expect to
> 	terminate their list traversal by finding the header, they
> 	could well be severely disappointed when the list_del_rcu()
> 	removes it...  The header being removed is the cmd_rcvrs
> 	field of the ipmi_smi_t.
>
> 	o	ipmi_destroy_user() line 880 does such a scan, but
> 		under the cmd_rcvrs_mutex, so OK.  Doesn't really
> 		need the _rcu suffix here, but doesn't hurt to have it.
>
> 	o	find_cmd_rcvr() line 992 does such a scan.  It is
> 		invoked as follows:
>
> 		o	Under cmd_rcvrs_mutex near line 1064 in
> 			ipmi_unregister_for_cmd().
>
> 		!	Under rcu_read_lock() near line 2686 in
> 			handle_ipmb_get_msg_cmd(), called from
> 			handle_new_recv_msg(), in turn called from:
> 			
> 			o	ipmi_smi_msg_received() line 3287.
> 				This may be called externally, so
> 				cannot hold the cmd_rcvrs_mutex.
> 			
> 			o	ipmi_timeout_handler() line 3428,
> 				called from ipmi_timeout() near line
> 				3493.  This is called from the
> 				timeout system (setup_timer() and
> 				mod_timer()), so cannot hold the
> 				lock.
>
> 			This loop also references a number of fields
> 			outside of the list_head, so is a problem
> 			for the addition of the raw struct list_head.
>
> 	o	is_cmd_rcvr_exclusive() at line 1007.  This is called
> 		from ipmi_register_for_cmd(), but under cmd_rcvrs_mutex,
> 		so OK as is.
>
> 	o	ipmi_register_smi() line 2494 initializes a newly
> 		allocated structure, so not yet accessible to readers.
>
> 	One way to fix this would be to leave the next pointer referencing
> 	the old list header, so that readers would find their way home.
> 	This would require waiting for a grace period after making this
> 	change, for example (untested, probably broken, but hopefully gets
> 	the idea across):
>
> 		if (list_empty(&intf->cmd_rcvrs))
> 			INIT_LIST_HEAD(&list);
> 		else {
> 			list->next = intf->cmd_rcvrs->next;
> 			list->prev = intf->cmd_rcvrs->prev;
> 			intf->cmd_rcvrs->next = &intf->cmd_rcvrs;
> 			intf->cmd_rcvrs->prev = &intf->cmd_rcvrs;
>
> 			/* List body still points to intf->cmd_rcvrs. */
>
> 			synchronize_rcu();
>
> 			/* All readers have exited list body. */
>
> 			list->next->prev = &list;
> 			list->prev->next = &list;
> 		}
>
> 		/*
> 		 * Note that we -don't- need the synchronize_rcu()
> 		 * currently following the mutex_unlock().
> 		 */
>
> 	If this sort of thing happens often, we should make a
> 	list_privatize_rcu(global_list, local_receiving_list) or some such.
>   
Oops, yes, this is a big problem.  I didn't want to delete the items one 
at a time and wait for each because that could take a long time.  But I 
missed the end of list thing.
> !	ipmi_register_smi() near line 2504: how does "i" get assigned
> 	to intf->intf_num before the struct is visible to RCU
> 	readers?  Or why doesn't it have to be?  It is initialized
> 	to -1, so maybe that helps...
>
> 	OK, I see the assignment at line 2561 near the end of
> 	ipmi_register_smi() -- it "turns on" the new ipmi_smi_t structure.
> 	But what keeps the memory ordering straight???	I believe you
> 	need an smp_wmb() before the "intf->intf_num = i;" assignment.
>
> 	Memory barriers will also be needed in the scan loops, most
> 	likely.
>
> 	But why not simply fully initialize -before- making this globally
> 	visible to RCU readers???  You do have a bunch of intervening
> 	setup, but does the entry -really- need to be linked "invisibly"
> 	into the list for this setup to work?  The /proc stuff seems
> 	harmless enough.  Besides, ipmi_unregister_smi() removes the
> 	entry from the list before undoing the /proc stuff.
>
> 	Or does the BMC registry somehow require this?	(Can't see
> 	why, as the "-1" ID won't be found by the search, right?) If
> 	so, can you instead have a global pointer that references
> 	the to-be-inserted item?  You would then assign to the global
> 	pointer using rcu_assign_pointer() -- then wait a grace period
> 	after adding to the real list before NULLing the global pointer.
>   
This is subtle, but the entry must be in the interfaces list for the 
timer operations to occur on it (and thus for operations to time out if 
they fail).  Before you make the entry available, you have to talk to 
the IPMI controller to get configuration information.  However, you 
don't want it to appear as a normal entry yet.  This is not really 
clean, I agree, but it does work with the added memory barriers.

I believe a read barrier is needed in one place in ipmi_create_user(), 
but that's all I found that looked like it was needed.
> ?	ipmi_smi_watcher_register(), line 432: list_for_each_entry_rcu()
> 	protected by lock.  OK, but _rcu suffix unnecessary.
>   
Ok.
> ?	ipmi_destroy_user() line 880 uses list_for_each_entry_rcu()
> 	under ->cmd_rcvrs_mutex, not clear why.  (Scanning the
> 	cmd_rcvrs field of an ipmi_smi_t.)
>   
Well, it's either that or list_for_entry_safe(), because entries are 
being deleted.  I can change it to safe if you think that is more clear.

Thanks for all your help.  I have a patch ready to go, expect that in a 
few minutes.

-Corey

