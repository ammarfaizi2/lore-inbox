Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUGXEmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUGXEmz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 00:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUGXEmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 00:42:55 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:23494 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S268278AbUGXEmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 00:42:53 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Robert Love <rml@ximian.com>
Cc: Dan Aloni <da-x@gmx.net>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer 
In-reply-to: Your message of "Fri, 23 Jul 2004 22:47:06 -0400."
             <1090637226.1830.8.camel@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 24 Jul 2004 14:42:41 +1000
Message-ID: <4956.1090644161@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 22:47:06 -0400, 
Robert Love <rml@ximian.com> wrote:
>On Sat, 2004-07-24 at 00:32 +0300, Dan Aloni wrote:
>
>> IMHO you either should not assume anything about the length of the object 
>> string, _or_ do the complete safe string assembly e.g:
>> 
>>         len += snprintf(buffer, PAGE_SIZE, "From: %s\nSignal: %s\n", 
>>                         object, signal);
>> 
>
>Fair enough.  I guess what we want, exactly, is:
>
> len = snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
> len += snprintf(&buffer[len], PAGE_SIZE - len "Signal: %s\n", signal);
>
>I will add that to the next revision.

man snprintf

  "If the output was truncated due to this limit then the return value
  is the number of characters (not including the trailing '\0') which
  would have been written to the final string if enough space had been
  available. Thus, a return value of size or more means that the output
  was truncated".

Never use the return value from snprintf to work out the next buffer
position, it is not reliable when the data is truncated.  The example
above uses a second call to snprintf which will generate a warning for
truncated data and fail safe, but not all code is that trustworthy.  I
always use strlen to get the real buffer length.

  snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
  len = strlen(buffer);
  snprintf(buffer+len, PAGE_SIZE - len, "Signal: %s\n", signal);

