Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWGDQhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWGDQhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWGDQhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:37:40 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:28368 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932275AbWGDQhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:37:39 -0400
Date: Tue, 04 Jul 2006 12:37:37 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
In-reply-to: <44AA86BF.3090600@watson.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: hadi@cyberus.ca, Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, csturtiv@sgi.com, balbir@in.ibm.com,
       jlan@engr.sgi.com, Valdis.Kletnieks@vt.edu, pj@sgi.com
Message-id: <44AA9951.1060804@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com> <449CD4B3.8020300@watson.ibm.com>
 <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org>
 <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org>
 <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org>
 <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org>
 <44A2FC72.9090407@engr.sgi.com> <20060629014050.d3bf0be4.pj@sgi.com>
 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
 <20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org>
 <44A57310.3010208@watson.ibm.com> <44A5770F.3080206@watson.ibm.com>
 <20060630155030.5ea1faba.akpm@osdl.org> <44A5DBE7.2020704@watson.ibm.com>
 <44A5EDE6.3010605@watson.ibm.com> <20060630205148.4f66b125.akpm@osdl.org>
 <44A9881F.7030103@watson.ibm.com> <44A9BC4D.7030803@watson.ibm.com>
 <20060703180151.56f61b31.akpm@osdl.org> <1152018353.5214.14.camel@jzny2>
 <44AA86BF.3090600@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> jamal wrote:
> 
>> On Mon, 2006-03-07 at 18:01 -0700, Andrew Morton wrote:
>>
>>> On Mon, 03 Jul 2006 20:54:37 -0400
>>> Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>>
>>>
>>>>> What happens when a listener exits without doing deregistration
>>>>> (or if the listener attempts to register another cpumask while a 
>>>>> current
>>>>> registration is still active).
>>>>>
>>>>
>>>> ( Jamal, your thoughts on this problem would be appreciated)
>>>>
>>>> Problem is that we have a listener task which has "registered" with 
>>>> taskstats and caused
>>>> its pid to be stored in various per-cpu lists of listeners. Later, 
>>>> when some other task exits on a given cpu, its exit data is sent 
>>>> using genlmsg_unicast on each pid present on that cpu's list.
>>>>
>>>> If the listener exits without doing a "deregister", its pid 
>>>> continues to be kept around, obviously not a good thing. So we need 
>>>> some way of detecting the situation (task is no longer listening on
>>>> these cpus events) that is efficient.
>>>
>>>
>>> Also need to address the case where the listener has closed off his file
>>> descriptor but continues to run.
>>>
>>> So hooking into listener's exit() isn't appropriate - the teardown is
>>> associated with the lifetime of the fd, not of the process.  If we do 
>>> that,
>>> exit() gets handled for free.  
>>
>>
>>
>> If you are always going to send unicast messages, then  -ECONNREFUSED
>> will tell you the listener has closed their fd - this doesnt meant it
>> has exited. 
> 
> 
> Thats good. So we have atleast one way of detecting the "closed fd without
> deregistering" within taskstats itself.
> 
>> Besides that one process could open several sockets. I know
>> that would not be the app you would write - but it doesnt stop other
>> people from doing it.
> 
> 
> As far as API is concerned, even a taskstats listener is not being
> prevented from opening multiple sockets. As Andrew also pointed out,
> everything needs to be done per-socket.
> 
>> I think i may not follow what you are doing - for some reason i thought
>> you may have many listeners in user space and these messages get
>> multicast to them?
> 
> 
> That was the design earlier. In the past week, the design has changed to
> one where there are still many listeners in user space but messages
> get unicast to each of them. Earlier listeners would get messages generated
> on task exit from every cpu, now they get it only from cpus for which
> they have explicitly registered interest (via a cpumask passed in through
> another genetlink command).
> 
>> Does the user space program somehow communicate its pid to the kernel?
> 
> 
> Yes. When the listener registers interest in a set of cpus, as described
> above, its (genl_info->pid) is being stored in the per-cpu list of
> listeners for those cpus. When a task exits on one of those cpus, the
> exit data is only sent via genetlink_unicast to those pids
> (really, nl_pids) who are on that cpu's listener list.
> 
> 
> Now that I think more about it, netlink is really maintaining a pidhash
> of nl_pids, not process pids, right ? So if one userapp were to open
> multiple sockets using NETLINK_GENERIC protocol (regardless of how many
> of those are for the taskstats), each of them would have to use a
> different nl_pid. Hence, it would be valid for the taskstats layer to 
> use netlink_lookup() at any time to see if the corresponding socket were
> closed ?
> 

Here's a strawman for the problem we're trying to solve: get
notification of the close of a NETLINK_GENERIC socket that had
been used to register interest for some cpus within taskstats.

 From looking at the netlink code, the way to go seems to be

- it maintains a pidhash of nl_pids that are currently
registered to listen to atleast one cpu. It also stores the
cpumask used.
- taskstats registers a notifier block within netlink_chain
and receives a callback on the NETLINK_URELEASE event, similar
to drivers/scsci/scsi_transport_iscsi.c: iscsi_rcv_nl_event()

- the callback checks to see that the protocol is NETLINK_GENERIC
and that the nl_pid for the socket is in taskstat's pidhash. If so, it
does a cleanup using the stored cpumask and releases the nl_pid
from the pidhash.

We can even do away with the deregister command altogether and
simply rely on this autocleanup.

--Shailabh
