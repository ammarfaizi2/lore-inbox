Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423976AbWKIA4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423976AbWKIA4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423979AbWKIA4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:56:36 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:60164 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1423976AbWKIA4f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:56:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: touch_cache() only touches two thirds
Date: Wed, 8 Nov 2006 16:56:35 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: touch_cache() only touches two thirds
Thread-Index: AccDmeen/ZegpeuXR3O2uqmM83KCAg==
From: "Bela Lubkin" <blubkin@vmware.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submitted as <http://bugzilla.kernel.org/show_bug.cgi?id=7476>:

I noticed this bug while looking at something else.  These comments are based
purely on source inspection without any runtime observations.  The bug
remains in the latest sources I could find: 2.6.19-rc5 and rc5-mm1.

Ingo Molnar's patch referred to as "scheduler cache-hot-auto-tune" introduced
the function kernel/sched.c:touch_cache().  Here is the 2.6.19-rc5-mm1
version (my "forward / backward" comments):

/*
 * Dirty a big buffer in a hard-to-predict (for the L2 cache) way. This
 * is the operation that is timed, so we try to generate unpredictable
 * cachemisses that still end up filling the L2 cache:
 */
static void touch_cache(void *__cache, unsigned long __size)
{
        unsigned long size = __size / sizeof(long);
        unsigned long chunk1 = size / 3;
        unsigned long chunk2 = 2 * size / 3;
        unsigned long *cache = __cache;
        int i;

        for (i = 0; i < size / 6; i += 8) {
                switch (i % 6) {
                        case 0: cache[i]++;         /* 1st third, forward  */
                        case 1: cache[size-1-i]++;  /* 3rd third, backward */
                        case 2: cache[chunk1-i]++;  /* 1st third, backward */
                        case 3: cache[chunk1+i]++;  /* 2nd third, forward  */
                        case 4: cache[chunk2-i]++;  /* 2nd third, backward */
                        case 5: cache[chunk2+i]++;  /* 3rd third, forward  */
                }
        }
}

Notice that the for() loop increments `i' by 8 (earlier versions of the code
used a stride of 4).  Since all visited values of i are even, `i % 6' can
never be odd.  The switch cases 1/3/5 will never be hit -- so the 3rd third
of the test buffer isn't being touched.  Migration costs are actually being
calculated relative to buffers that are only 2/3 as large as intended.

An easy fix is to make the stride relatively prime to the modulus:

--- sched.c.orig        2006-11-08 16:17:37.299500000 -0800
+++ sched.c     2006-11-08 16:28:21.699750000 -0800
@@ -5829,5 +5829,5 @@ static void touch_cache(void *__cache, u
        int i;
 
-       for (i = 0; i < size / 6; i += 8) {
+       for (i = 0; i < size / 6; i += 7) {
                switch (i % 6) {
                        case 0: cache[i]++;

>Bela<

PS: I suspect this at least partially explains Kenneth W Chen's observations
in "Variation in measure_migration_cost() with
scheduler-cache-hot-autodetect.patch in -mm",
<http://lkml.org/lkml/2005/6/21/473>:

> I'm consistently getting a smaller than expected cache migration cost
> as measured by Ingo's scheduler-cache-hot-autodetect.patch currently
> in -mm tree.
