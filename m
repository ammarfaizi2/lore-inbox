Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318962AbSICWsU>; Tue, 3 Sep 2002 18:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318972AbSICWsU>; Tue, 3 Sep 2002 18:48:20 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54216 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318962AbSICWsS>; Tue, 3 Sep 2002 18:48:18 -0400
Date: Tue, 3 Sep 2002 18:52:51 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020903185251.H12201@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <dledford@redhat.com> <200209032148.g83LmeP09177@localhost.localdomain> <20020903184216.F12201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020903184216.F12201@redhat.com>; from dledford@redhat.com on Tue, Sep 03, 2002 at 06:42:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 06:42:16PM -0400, Doug Ledford wrote:
> 
> Case 2: you want to do an abort, but you need to preserve ordering around 
> any possible REQ_BARRIERs on the bus.  This requires that we keep a 
> REQ_BARRIER count for the device, it is after all possible that we could 
> have multiple barriers active at once, so as each command is put on the 
> active_list, if it is a barrier, then we increment SDpnt->barrier_count 
> and as we complete commands (at the interrupt context completion, not the 
> final completion) if it is a barrier command we decrement the count.
> 
> 	[ oops we timed out ]
> 	while(SDpnt->barrier_count && cmd) {
> 		// when the aborted command is returned via the done()
> 		// it will remove it from the active_list, so don't remove
> 		// it here
> 		abort_cmd = list_get_tail(SDpnt->active_list);
> 		if(hostt->abort(abort_cmd) != SUCCESS) {
> 			[ oops, go on to more drastic action ]
> 		} else {
> 			if(abort_cmd->type == BARRIER)
> 				SDpnt->barrier_count--;

Oops, delete those last two lines....the done() function decrements the 
barrier_count for us.

> 			if(abort_cmd == cmd)
> 				cmd = NULL;
> 		}
> 	}
> 	if(cmd) {
> 		if(hostt->abort(cmd) != SUCCESS)
> 			[ oops, go on to more drastic action ]
> 	}

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
