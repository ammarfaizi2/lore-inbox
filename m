Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270259AbTGNOaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270223AbTGNO2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:28:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39935 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270281AbTGNOYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:24:48 -0400
Date: Mon, 14 Jul 2003 09:39:33 -0500
From: Amos Waterland <apw@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 kernel regression in alarm() syscall behaviour?
Message-ID: <20030714143933.GA2925@kvasir.austin.ibm.com>
References: <1057871573.16218.3.camel@tanda.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057871573.16218.3.camel@tanda.austin.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Wes' mail client mangled his testcase a bit.  Here is a cleaned
up version.

Compile with:

  % gcc -Wall -Werror alarm.c -o alarm

Output on 2.4 kernel is:

  % ./alarm
  [1058193354] alarm(0), want retval:0; got retval:0 (PASS)
  ...
  [1058193354] alarm(9), want retval:8; got retval:8 (PASS)
  0/10 tests failed

Output on 2.5 kernel is: many failures.  The number of failures go down
when the system is heavily stressed.

---- Begin alarm.c ----

#include <unistd.h>
#include <stdio.h>
#include <sys/time.h>

#define MINVAL 0
#define MAXVAL 10
#define NOALARM 0

int main(int argc, char **argv)
{
    int retval = 0, failed = 0, tests = MAXVAL, prev = 0, curr = 0;
    struct timeval time;

    if (argc > 1)
        if (sscanf(argv[1], "%d", &tests) != 1)
            return 1;

    for (curr = MINVAL; curr < tests; curr++) {
        retval = alarm(curr);
        gettimeofday(&time, NULL);
        printf("[%li] alarm(%d), want retval:%d; ",
               time.tv_sec, curr, prev);
        /* was there a previous alarm? */
        if (retval == NOALARM && prev == NOALARM) {
            printf("got retval:0 (PASS)");
        } else if (retval == NOALARM && prev > NOALARM) {
            printf("got retval:0 (FAIL)");
            failed++;
        } else if (retval != prev) {
            printf("got retval:%d (FAIL)", retval);
            failed++;
        } else {
            printf("got retval:%d (PASS)", retval);
        }
        printf("\n");
        prev = curr;
    }
    printf("%d/%d tests failed\n", failed, tests);
    return failed;
}

---- End alarm.c ----
