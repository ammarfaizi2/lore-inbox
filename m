Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbSJCRgD>; Thu, 3 Oct 2002 13:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSJCRgD>; Thu, 3 Oct 2002 13:36:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35730 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261638AbSJCRgB>;
	Thu, 3 Oct 2002 13:36:01 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6E4A0115.7A4BB6D7-ON85256C47.0059EE6F@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 3 Oct 2002 12:42:23 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/03/2002 01:37:13 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2002 at 9:50 AM, Chrisopth Hellwig wrote:
>> +/* -*- linux-c -*- */
>> +/*
>> + *   Copyright (c) International Business Machines  Corp., 2000

> Has this file _really_ not been touched for two years??

Yup, it has, I've fixed them.

>> +/*
>> + * linux/include/linux/evms/evms.h
>> + *
>> + * EVMS kernel header file
>> + *
>> + */

> This comment sais exactly nothing.  You aswell just remove it..

Agreed. The comment is obvious in this case. Its gone.

>> +
>> +#ifndef __EVMS_INCLUDED__
>> +#define __EVMS_INCLUDED__
>> +
>> +#include <linux/blk.h>
>> +#include <linux/genhd.h>
>> +#include <linux/fs.h>
>> +#include <linux/iobuf.h>

> I can't see the need for this include anywhere in the file.  Please check
> whether you need all these includes.

Ok, done.

>> +
>> +/**
>> + * general defines section
>> + **/
>> +#define FALSE                           0
>> +#define TRUE                            1

> Please just use 0/1 directly just like everyone else..

More than happy to comply, however grep'ing the tree its
plain to see that not "everyone else" is following this
suggestion.

>> +#define DEV_PATH                "/dev"
>> +#define EVMS_DIR_NAME                 "evms"
>> +#define EVMS_DEV_NAME                 "block_device"
>> +#define EVMS_DEV_NODE_PATH            DEV_PATH "/" EVMS_DIR_NAME "/"
>> +#define EVMS_DEVICE_NAME        DEV_PATH "/" EVMS_DIR_NAME "/"
EVMS_DEV_NAME

> The kernel doesn't know about device names at all.

I realize this is a goal, and I'm not opposed to it. However,
I know devfs is not popular, but people are using it, and it
*is* still available in 2.5. For the cases where ppl are
using it, the EVMS kernel component needs this info to tell
devfs the name of the devnode to create. I don't want to get
into a devfs flamewar, EVMS is simply offering interoperability
with what ppl can do today. Should that change, EVMS is more
than happy to adapt to the latest technology.

>> +
>> +/**
>> + * list_for_each_entry_safe -   iterate over list safe against removal
of list entry
>> + * @pos:        the type * to use as a loop counter.
>> + * @n:              another type * to use as temporary storage
>> + * @head:       the head for your list.
>> + * @member:     the name of the list_struct within the struct.
>> + */
>> +#define list_for_each_entry_safe(pos, n, head, member)
\
>> +        for (pos = list_entry((head)->next, typeof(*pos), member),
\
>> +            n = list_entry(pos->member.next, typeof(*pos), member); \
>> +        &pos->member != (head);                             \
>> +        pos = n,                                                    \
>> +            n = list_entry(pos->member.next, typeof(*pos), member))
>> +/**
>> + * list_member - tests whether a list member is currently on a list
>> + * @member:   member to evaulate
>> + */
>> +static inline int
>> +list_member(struct list_head *member)
>> +{
>> +  return ((!member->next || !member->prev) ? FALSE : TRUE);
>> +}

> This should go into list.h

Yes it should. I will pull this out of this header
and submit a patch for list.h.

>> +
>> +/**
>> + * kernel logging levels defines
>> + **/
>> +#define EVMS_INFO_CRITICAL              0
>> +#define EVMS_INFO_SERIOUS               1
>> +#define EVMS_INFO_ERROR                 2
>> +#define EVMS_INFO_WARNING               3
>> +#define EVMS_INFO_DEFAULT               5
>> +#define EVMS_INFO_DETAILS               6
>> +#define EVMS_INFO_DEBUG                 7
>> +#define EVMS_INFO_EXTRA                 8
>> +#define EVMS_INFO_ENTRY_EXIT            9
>> +#define EVMS_INFO_EVERYTHING            10

> What about just using normal logging levels?

The quick answer is granularity. EVMS can generate a *lot*
of logging messages and we wanted a way to control the
amount of debugging messages. A simply ON/OFF didn't
quite seem adequate for many cases.

More to follow ....

Mark


