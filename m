Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272636AbTHPIUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 04:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272639AbTHPIUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 04:20:08 -0400
Received: from [212.209.10.216] ([212.209.10.216]:4802 "EHLO krynn.se.axis.com")
	by vger.kernel.org with ESMTP id S272636AbTHPIUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 04:20:03 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20BB@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Timothy Miller'" <miller@techsource.com>
Cc: "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Sat, 16 Aug 2003 10:15:14 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Timothy Miller [mailto:miller@techsource.com] 
> Sent: Friday, August 15, 2003 19:52
> To: Peter Kjellerstedt
> Cc: 'Willy Tarreau'; linux-kernel mailing list
> Subject: Re: generic strncpy - off-by-one error
> 
> Peter Kjellerstedt wrote:
> > Timothy's       3.125003    6.128571    9.147905   33.325337  
> 
> Which of mine did you test?  The one with the single-byte 
> fill, or the one with the multiple fill loops that does 
> words for the bulk of the fills?

Stupid me. I only tested the single byte fill version.

> With some minor tweaks to eliminate compiler stupidity which compares 
> against -1, that might win on the fill phase.  No?

Here are the numbers for my for loop version and your multi
byte fill version for CRIS:

For loops       2.867568    5.620561    8.128734   28.286289  
Multi byte fill 2.868031    5.670782    6.312027   11.336015  

And here are the numbers for my P4:

For loops       3.060262    5.927378    8.796814   30.659818  
Multi byte fill 3.126607    5.898459    7.096685   13.135379  

So there is no doubt that the multi byte version is a clear
winner (which was expected, I suppose).

Here is the code that I used:

char *strncpy(char *dest, const char *src, size_t count)
{
	char *tmp = dest;

	while (count && *src) {
		*tmp++ = *src++;
		count--;
	}

	if (count) {
		size_t count2;

		while (count & (sizeof(long) - 1)) {
			*tmp++ = '\0';
			count--;
		}

		count2 = count / sizeof(long);
		while (count2) {
			*((long *)tmp)++ = '\0';
			count2--;
		}

		count &= (sizeof(long) - 1);
		while (count) {
			*tmp++ = '\0';
			count--;
		}
	}

	return dest;
}

//Peter
