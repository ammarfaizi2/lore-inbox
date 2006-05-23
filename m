Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWEWNOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWEWNOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 09:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWEWNOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 09:14:00 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:48894 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932207AbWEWNN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 09:13:59 -0400
Message-ID: <44730A90.1070703@de.ibm.com>
Date: Tue, 23 May 2006 15:13:52 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 2/6] statistics infrastructure - prerequisite: parser
 enhancement
References: <1148055023.2974.14.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <661de9470605230554y1703fba9j2f2da0609fc3695e@mail.gmail.com>
In-Reply-To: <661de9470605230554y1703fba9j2f2da0609fc3695e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> On 5/19/06, Martin Peschke <mp3@de.ibm.com> wrote:
>> This patch adds a match_* derivate for 64 bit operands to the parser 
>> library.
>>
>> Signed-off-by: Martin Peschke <mp3@de.ibm.com>
>> ---
>>
>>  include/linux/parser.h |    1 +
>>  lib/parser.c           |   30 ++++++++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff -Nurp a/lib/parser.c b/lib/parser.c
>> --- a/lib/parser.c      2006-03-20 06:53:29.000000000 +0100
>> +++ b/lib/parser.c      2006-05-19 16:01:48.000000000 +0200
>> @@ -140,6 +140,35 @@ static int match_number(substring_t *s,
>>  }
>>
>>  /**
>> + * match_s64: scan a number in the given base from a substring_t
>> + * @s: substring to be scanned
>> + * @result: resulting integer on success
>> + * @base: base to use when converting string
>> + *
>> + * Description: Given a &substring_t and a base, attempts to parse 
>> the substring
>> + * as a number in that base. On success, sets @result to the s64 
>> represented
>> + * by the string and returns 0. Returns either -ENOMEM or -EINVAL on 
>> failure.
>> + */
>> +int match_s64(substring_t *s, s64 *result, int base)
>> +{
>> +       char *endp;
>> +       char *buf;
>> +       int ret;
>> +
>> +       buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
>> +       if (!buf)
>> +               return -ENOMEM;
>> +       memcpy(buf, s->from, s->to - s->from);
>> +       buf[s->to - s->from] = '\0';
>> +       *result = simple_strtoll(buf, &endp, base);
>> +       ret = 0;
>> +       if (endp == buf)
>> +               ret = -EINVAL;
>> +       kfree(buf);
>> +       return ret;
>> +}
>> +
>> +/**
>>   * match_int: - scan a decimal representation of an integer from a 
>> substring_t
>>   * @s: substring_t to be scanned
>>   * @result: resulting integer on success
>> @@ -218,3 +247,4 @@ EXPORT_SYMBOL(match_octal);
>>  EXPORT_SYMBOL(match_hex);
>>  EXPORT_SYMBOL(match_strcpy);
>>  EXPORT_SYMBOL(match_strdup);
>> +EXPORT_SYMBOL(match_s64);
>> diff -Nurp a/include/linux/parser.h b/include/linux/parser.h
>> --- a/include/linux/parser.h    2006-03-20 06:53:29.000000000 +0100
>> +++ b/include/linux/parser.h    2006-05-19 16:01:48.000000000 +0200
>> @@ -31,3 +31,4 @@ int match_octal(substring_t *, int *resu
>>  int match_hex(substring_t *, int *result);
>>  void match_strcpy(char *, substring_t *);
>>  char *match_strdup(substring_t *);
>> +int match_s64(substring_t *, s64 *result, int);
>>
> 
> Sorry for the delay in reviewing. I am just catching up with pending items.
> I wonder if makes sense to fold this along with match_u64(). 90% of
> their code is common. We can avoid text replication by folding the
> code and the common code is easier to maintain.
> 
> Regards,
> Balbir
> Linux Technology Center,
> India Software Labs,
> Bangalore

I guess, match_s64 can be used for u64 as well. Maybe renaming is all that's
needed.

Martin

