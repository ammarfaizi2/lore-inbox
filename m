Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWDMVIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWDMVIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWDMVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:08:17 -0400
Received: from spirit.analogic.com ([204.178.40.4]:36879 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964968AbWDMVIP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:08:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com>
x-originalarrivaltime: 13 Apr 2006 21:08:14.0250 (UTC) FILETIME=[60C0D8A0:01C65F3E]
Content-class: urn:content-classes:message
Subject: Re: select takes too much time
Date: Thu, 13 Apr 2006 17:08:13 -0400
Message-ID: <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: select takes too much time
Thread-Index: AcZfPmDIpqkN/iUQSPysWl15jTLXMw==
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com> <443E9A17.4070805@stud.feec.vutbr.cz> <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ram Gupta" <ram.gupta5@gmail.com>
Cc: "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "linux mailing-list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Apr 2006, Ram Gupta wrote:

> On 4/13/06, Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>> Ram Gupta wrote:
>>> I am using 2.5.45 kernel but I believe the same would  be the true
>>> for the latest kernel too.
>>
>> Are you just assuming this, or did you actually try a recent kernel?
>>
>> Michal
>>
>
> I didn't get a chance to try it on a recent kernel yet but I believe
> it to be so though I may be  wrong
>
> Ram
> -

Simple program here shows that you may be right! In principle,
I should be able to multiply the loop-count by 10 and divide
the sleep time by 10, still resulting in 1-second total time
through the loop. Not so! Changing the value, marked "Change this" to
a smaller value doesn't affect the time very much. It is as though
the sleep time is always at least 1000 microseconds. If this is
correct, then there should be some kind of warning that the time
can't be less than the HZ value, or whatever is limiting it.


#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/select.h>

#define USEC 1e6

int main()
{
     struct timeval tv,tod;
     size_t i;
     double start_time, end_time, total_time;
     for(;;) {
         gettimeofday(&tod, NULL);		// Start time in useconds
         start_time = ((double)tod.tv_sec * USEC) + (double)tod.tv_usec;
         for(i=0; i< 1000; i++) {
             tv.tv_sec = 0;
             tv.tv_usec = 1000;		// <--- change this
             select(0, NULL, NULL, NULL, &tv);
         }
         gettimeofday(&tod, NULL);		// End time in useconds
         end_time = ((double)tod.tv_sec * USEC) + (double)tod.tv_usec;
         total_time = (end_time - start_time) / USEC;
         printf("Total time = %f seconds\n", total_time);
     }
     return 0;
}



Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
