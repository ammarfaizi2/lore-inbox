Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWAKPVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWAKPVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWAKPVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:21:07 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:53265 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751350AbWAKPVF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:21:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1136988316.6517.8.camel@localhost.localdomain>
X-OriginalArrivalTime: 11 Jan 2006 15:20:58.0574 (UTC) FILETIME=[9FB7FEE0:01C616C2]
Content-class: urn:content-classes:message
Subject: Re: OT: fork(): parent or child should run first?
Date: Wed, 11 Jan 2006 10:19:53 -0500
Message-ID: <Pine.LNX.4.61.0601111005340.27240@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: OT: fork(): parent or child should run first?
Thread-Index: AcYWwp/BH9bYJbknSji602sWjYyFHQ==
References: <20060111123745.GB30219@lgb.hu> <1136983910.2929.39.camel@laptopd505.fenrus.org> <20060111130255.GC30219@lgb.hu>  <1136985918.6547.115.camel@tara.firmix.at> <1136987361.6517.1.camel@localhost.localdomain> <1136987743.6547.122.camel@tara.firmix.at> <1136988316.6517.8.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ian Campbell" <ijc@hellion.org.uk>
Cc: "Bernd Petrovitsch" <bernd@firmix.at>, <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>, <lgb@lgb.hu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2006, Ian Campbell wrote:

> On Wed, 2006-01-11 at 14:55 +0100, Bernd Petrovitsch wrote:
>> On Wed, 2006-01-11 at 13:49 +0000, Ian Campbell wrote:
>>> On Wed, 2006-01-11 at 14:25 +0100, Bernd Petrovitsch wrote:
>>>> Then this leaves the race if an old pid is reused in a newly created
>>>> process before the last instances of that pid is cleaned up.
>>>
>>> The PID won't be available to be re-used until the signal handler has
>>> called waitpid() on it?
>>
>> Yes.
>> But ATM the signal handler calls waitpid() and stores the pid in a
>> to-be-cleaned-pids array (at time X).
>> The main loop at some time in the future (say at time X+N) walks through
>> the to-be-cleaned-pids array and cleans them from the active-childs
>> array.
>
> yuk... I'd say the application is a bit dumb for calling waitpid before
> it is actually prepared for the pid to be reclaimed.
>

The application has no clue (and must not know) the internal workings
of the kernel. In the following code, both forks must work, the case
in which the child executed immediately, and the case in which the
child did some work or slept before it exited.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
     pid_t pid;
     int status;

     switch((pid = fork()))
     {
     case 0:    // child
         exit(EXIT_SUCCESS);
     case -1:	// Error
         perror("fork");
         exit(EXIT_FAILURE);
     default:	// Parent
         waitpid(pid, &status, 0);
         break;
     }
     switch((pid = fork()))
     {
     case 0:    // child
         sleep(10);
         exit(EXIT_SUCCESS);
     case -1:	// Error
         perror("fork");
         exit(EXIT_FAILURE);
     default:	// Parent
         waitpid(pid, &status, 0);
         break;
     }
     return 0;
}

The code has no clue whether or not the child started before
waitpid was called. It knows it has a valid pid, which is only a
promise that such a child will start execution sometime or
that it once existed and has already expired. That pid must
remain valid until somebody reaps the status of the expired
child.

> A possible solution would be to also defer the waitpid until the main
> loop cleanup function, perhaps flagging the entry in the child array as
> not-active between the signal and that time or moving the pid from the
> active to an inactive array in the signal handler.
>

The pid will (must) always be valid until after the status is reaped.
There should not be any flags used to synchronize anything here. That
pid just cannot be reused until the child is out of the Z state and
its status has been obtained. Then the pid can be reused. It's the
Z state that has historically provided the needed synchronization.

> Ian.
> --
> Ian Campbell
> Current Noise: Sloth - Into The Sun
>
> To err is human,
> To purr feline.
> 		-- Robert Byrne
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.71 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
