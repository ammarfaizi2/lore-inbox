Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVHYUo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVHYUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHYUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:44:56 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:34446 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932564AbVHYUoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:44:55 -0400
Date: Thu, 25 Aug 2005 13:44:55 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
cc: tom.anderl@gmail.com
Subject: [OT] volatile keyword
Message-ID: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The recent discussion on the list concerning memory barriers and write
ordering took a side-trip to the volatile keyword, especially its
correct / incorrect usage. Someone posted a link to the LKML archives,
in which the argument is made that it is best to keep 'volatile' _out_
of variable and structure definitions, and _into_ the code that uses
them. I was curious, so I decided to try this out (looking at
kernel/posix-timers.c for inspiration)...

Here's sample userland program number one, written one way:
===========================
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

struct sync {
    volatile unsigned long lock;
    volatile unsigned long value;
};

struct sync data;

void * thread (void * arg) {
    sleep(5);
    data.value = 0;
    data.lock = 0;

    return NULL;
}

int main (void) {
    pthread_t other;

    data.lock = 1;
    data.value = 1;
    pthread_create(&other, NULL, thread, NULL);
    while (data.lock);
    printf("Value is %lu.\n", data.value);
    pthread_join(other, NULL);

    return 0;
}
===========================

And here's what should be the same program, written the "suggested" way:
===========================
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

struct sync {
    unsigned long lock;
    unsigned long value;
};

struct sync data;

void * thread (void * arg) {
    sleep(5);
    data.value = 0;
    data.lock = 0;

    return NULL;
}

int main (void) {
    pthread_t other;

    data.lock = 1;
    data.value = 1;
    pthread_create(&other, NULL, thread, NULL);
    while ((volatile unsigned long)(data.lock));
    printf("Value is %lu.\n", data.value);
    pthread_join(other, NULL);

    return 0;
}
===========================

The first program works exactly as expected. The second program,
however, never syncs with the sleeping thread. In fact, for the second
program, gcc compiles the while loop down to an infinite loop.

I'm positive I'm doing something wrong here. In fact, I bet it's the
volatile cast within the loop that's wrong; but I'm not sure how to do
it correctly. Any help / pointers / discussion would be appreciated.

Thanks. :-)
-VadimL
