Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVHDQyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVHDQyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVHDQwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:52:06 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:55010 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262545AbVHDQuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:50:03 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 4 Aug 2005 18:45:32 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.12: itimer_real timers don't survive execve() any more
Message-ID: <20050804164532.GB31853@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Somewhere between 2.6.11 and 2.6.12 the regression in $subject
was added to the linux kernel.  Testcase below.

Ideas on that anyone?

  Gerd

==============================[ test_exec_alarm.c ]==============================
#include <sys/time.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char ** argv)
{
    struct itimerval value;
    int retval;
    static char hosted_executable[256];
    char * hosted_executable_args[2];

    /* Set the alarm timer. */
    value.it_interval.tv_sec = 0;
    value.it_interval.tv_usec = 0;
    value.it_value.tv_sec = 200;
    value.it_value.tv_usec = 0;
    retval = setitimer(ITIMER_REAL, &value, NULL);
    if (retval != 0) {
        perror("setitimer()");
        return 1;
    }

    /* Prepare the file name of the hosted executable. */
    strcpy(hosted_executable, "./test_getitimer");

    /* Prepare the command line arguments. */
    hosted_executable_args[0] = hosted_executable;
    hosted_executable_args[1] = NULL;

    /* Execute the hosted executable which should inherit the timer. */
    retval = execvp(hosted_executable, hosted_executable_args);

    /* If we get here, the execvp() call failed. */
    perror("execvp()");
    return 1;
}
==============================[ test_getitimer.c ]==============================
#include <sys/time.h>
#include <stdio.h>

int main(int argc, char ** argv)
{
    struct itimerval value;
    int retval;

    retval = getitimer(ITIMER_REAL, &value);
    if (retval != 0) {
        perror("getitimer()");
        return 1;
    }

    printf("alarm timer value: %u sec, %u msec\n", value.it_value.tv_sec, value.it_value.tv_usec);
    return 0;
}
