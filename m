Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261760AbTCGTnS>; Fri, 7 Mar 2003 14:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbTCGTnS>; Fri, 7 Mar 2003 14:43:18 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:2462 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S261756AbTCGTnI>;
	Fri, 7 Mar 2003 14:43:08 -0500
Date: Fri, 7 Mar 2003 11:41:59 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi_error fix
Message-ID: <20030307114159.A941@beaverton.ibm.com>
References: <UTC200303062337.h26Nbv714178.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200303062337.h26Nbv714178.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Mar 07, 2003 at 12:37:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:37:57AM +0100, Andries.Brouwer@cwi.nl wrote:

> scsi_error.c: apart from similar trivialities the only change:
> 
>     If a command fails (e.g. because it belongs to a newer
>     SCSI version than the device), it is fed to
>     scsi_decide_disposition(). That routine must return
>     SUCCESS, unless the error handler should be invoked.
> 
>     In the situation where host_byte is DID_OK, and message_byte
>     is COMMAND_COMPLETE, and status is CHECK_CONDITION, there is
>     no reason at all to invoke aborts and resets. The situation
>     is normal. I see here UNIT ATTENTION, Power on occurred
>     and ILLEGAL REQUEST, Invalid field in cdb.
> 
>     The 2.5.64 code does not return SUCCESS, but it returns the
>     return code of scsi_check_sense(), and that may be FAILED
>     in case we do not have valid sense.
> 
>     Further discussion is possible here, but I changed the return
>     into "return SUCCESS" and 2.5.64 boots fine.
> 
> Andries
> 
> [Further discussion and things I did not yet investigate:
> What was changed to make this fail first in 2.5.63?
> Experience shows that we get into a loop when something else
> than SUCCESS is returned here. Probably that is a bug elsewhere.
> Probably the commands that cause problems should never have been
> sent in the first place.]

The scsi error handler is also used to retrieve sense data for
adapters/drivers that do not auto retrieve it. In such cases, it should
not issue any aborts, resets etc.

Your change effectively disables that support - we never hit the code in
scsi_eh_get_sense() to request sense. It would be very nice if we could
fix (or audit) all the scsi drivers, apply your change and remove
scsi_eh_get_sense, but AFAIK that has not and is not happening.

I don't know if your adapter/driver has auto sense retrieval (imm.c?).

I would guess a change in scsi_error.c related to sense (scsi_eh_get_sense)
handling is causing problems, and if your driver has auto sense then
something is wrong with the scmd->sense_buffer.

It would still be useful to see the console log output with scsi_logging=1
for your failure case.

-- Patrick Mansfield
