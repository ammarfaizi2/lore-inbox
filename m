Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVCTMZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVCTMZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 07:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVCTMZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 07:25:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16037 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261165AbVCTMZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 07:25:03 -0500
Date: Sun, 20 Mar 2005 13:25:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Short sleep precision
Message-ID: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I have found that FreeBSD has a very good precision of small sleeps --
what's holding Linux back from doing the same? Using the code snippet below, 
FBSD yields between 2 and 80 us on the average while Linux is at 
"constantly" ~100 (with HZ=1000) and ~1000 (HZ=100).


Jan Engelhardt
-- 

#include <sys/time.h>
#include <stdio.h>
#include <time.h>
#define MICROSECOND 1000000
static unsigned long calc_ovcorr(unsigned long ad, int rd) {
    struct timespec s = {.tv_sec = 0, .tv_nsec = ad};
    struct timeval start, stop;
    unsigned long av = 0;
    int count = rd;

    while(count--) {
        gettimeofday(&start, NULL);
        nanosleep(&s, NULL);
        gettimeofday(&stop, NULL);
        av += MICROSECOND * (stop.tv_sec - start.tv_sec) +
         stop.tv_usec - start.tv_usec;
    }

    av /= rd;
    fprintf(stderr, " %lu us\n", av);
    return av;
}

int main(void) {
    calc_ovcorr(0, 100);
    return 0;
}

//eof
