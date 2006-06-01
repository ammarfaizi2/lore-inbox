Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWFAIkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWFAIkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWFAIkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:40:53 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:56391 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932066AbWFAIkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:40:53 -0400
Message-ID: <447EA800.101@de.ibm.com>
Date: Thu, 01 Jun 2006 10:40:32 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] statistics infrastructure - prerequisite: timestamp
References: <1148055080.2974.15.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <4474CD38.5090206@am.sony.com>
In-Reply-To: <4474CD38.5090206@am.sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird wrote:
> Martin Peschke wrote:
>> And I think that I have fixed a printed_len related miscalculation.
>> printed_len needs to be increased if no valid log level has been found
>> and a log level prefix has been added by printk(). Otherwise, printed_len
>> must not be increased. The old code did it the other way around (in the
>> timestamp case).
> 
> I'm not following your change here.  I can't find the problem you
> mention in the original code.  And your fix appears to mess up the
> printed_len.

I am sorry for not responding sooner ... and I am sorry for introducing
a bug here. I think you are right.

>> +		if (new_line) {
>> +			/* The log level token is first. */
>> +			int loglev_char;
>> +			if (p[0] == '<' && p[1] >='0' &&
>> +			    p[1] <= '7' && p[2] == '>') {
>> +				loglev_char = p[1];
>> +				p += 3;
>> +				printed_len -= 3;
> Here you subtract from the printed_len to account for skipping
> the submitted log level.
> 
>> +			} else	{
>> +				loglev_char = default_message_loglevel + '0';
>> +			}
>> +			emit_log_char('<');
>> +			emit_log_char(loglev_char);
>> +			emit_log_char('>');
> 
> But here you don't re-count the chars for the log-level
> you are adding back in.  There's a discrepancy here.

Correct. My print_len loses 3 in the 'got log level'-case due to a surplus
substraction. It also loses 3 in the other case due to adding a log level
substring that is not entered in the books.

This is how I would fix it:

         printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);

         ...

         if (new_line) {
                 /* The log level token is first. */
                 int loglev_char;
                 if (p[0] == '<' && p[1] >='0' &&
                     p[1] <= '7' && p[2] == '>') {
                         loglev_char = p[1];
                         p += 3;
                 } else  {
                         loglev_char = default_message_loglevel + '0';
                         print_len += 3;
                 }
                 emit_log_char('<');
                 emit_log_char(loglev_char);
                 emit_log_char('>');


Could you confirm, please. I will send a patch to Andrew then.


Or, Andrew, do you prefer a replacement patch for my
statistics-infrastructure-prerequisite-timestamp.patch
that introduces this miscalculation. I could put
statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch
into that one as well, so that all the timestamp related printk-changes are in
one place.

