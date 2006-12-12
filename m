Return-Path: <linux-kernel-owner+w=401wt.eu-S1751333AbWLLOAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWLLOAP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWLLOAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:00:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54462 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbWLLOAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:00:13 -0500
Message-ID: <457EB5E6.9060207@redhat.com>
Date: Tue, 12 Dec 2006 09:00:06 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: linuxer linuxer <tangzt@yahoo.com>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com
Subject: Re: hi, should these code is a problem in nfs system clnt.c?
References: <319714.29242.qm@web36002.mail.mud.yahoo.com>
In-Reply-To: <319714.29242.qm@web36002.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxer linuxer wrote:
> Hi, everyone: 
>     I am a newbie, if my question waste your time, I
> am sorry for that. 
>
>     In clnt.c file ,call_timeout function:    
>     I suggest the code that judge whether the network
> link status is down should be added, won't they? 
>     I tested it with one Ethernet netcard.
>
>   

This would not be a good idea.  What happens if the name of the
interface used on the system is not "eth0"?

Also, IP packets can be routed out of any available interface,
so just because one interface (eth0) is down, doesn't mean
that the entire system is networkless.

    Thanx...

       ps

> static void
> call_timeout(struct rpc_task *task)
> {
> 	struct rpc_clnt	*clnt = task->tk_client;
>
> +       struct netdev * dev;
> +       if ((dev = __dev_get_by_name("eth0")) == 
> +        NULL){
> +		rpc_exit(task, -ENOTCONN);
> +		return;
> +    	}
> +	else{
> +   		 if (!netif_carrier_ok(dev)){
> +  			rpc_exit(task, -ENOTCONN);
> +			return;
> +  		 }
> +     	}
>
> 	if (xprt_adjust_timeout(task->tk_rqstp) == 0) {
> 		dprintk("RPC: %4d call_timeout (minor)\n",
> task->tk_pid);
> 		goto retry;
> 	}
>
> 	dprintk("RPC: %4d call_timeout (major)\n",
> task->tk_pid);
> 	task->tk_timeouts++;
>
> 	if (RPC_IS_SOFT(task)) {
> 		printk(KERN_NOTICE "%s: server %s not responding,
> timed out\n",
> 				clnt->cl_protname, clnt->cl_server);
> 		rpc_exit(task, -EIO);
> 		return;
> 	}
>
> 	if (!(task->tk_flags & RPC_CALL_MAJORSEEN)) {
> 		task->tk_flags |= RPC_CALL_MAJORSEEN;
> 		printk(KERN_NOTICE "%s: server %s not responding,
> still trying\n",
> 			clnt->cl_protname, clnt->cl_server);
> 	}
> 	rpc_force_rebind(clnt);
>
> retry:
> 	clnt->cl_stats->rpcretrans++;
> 	task->tk_action = call_bind;
> 	task->tk_status = 0;
> }
>
>
>
>  
> ____________________________________________________________________________________
> Yahoo! Music Unlimited
> Access over 1 million songs.
> http://music.yahoo.com/unlimited
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   

