Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269575AbTGJU6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269569AbTGJU6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:58:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:56969 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269585AbTGJU6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:58:16 -0400
Subject: 2.5 kernel regression in alarm() syscall behaviour?
From: Paul Wes Hofmann <wh@us.ibm.com>
Reply-To: wh@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Amos Waterland <apw@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: IBM Corporation
Message-Id: <1057871573.16218.3.camel@tanda.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jul 2003 16:12:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5 kernel (2.5.69 - 2.5.74) differs from the 2.4 kernel with
respect to the alarm() sytem call.

According to the Open Group's "Single UNIX Specification, Version 2":

        If there is a previous alarm() request with time remaining,
        alarm() returns a non-zero value that is the number of seconds
        until the previous request would have generated a SIGALRM
        signal.  Otherwise, alarm() returns 0
        
alarm.c (see code listing below) on a clean SuSE 8.2 installation with
the following uname output:

Linux lsb 2.4.20-4GB #1 Mon Mar 17 17:54:44 UTC 2003 \
i686 unknown unknown GNU/Linux

produces this output:

914 [wes@lsb test]$ ./alarm 1000 
        [1057874242] alarm(0), want retval:0; got retval:0 (PASS)
        [1057874242] alarm(1), want retval:0; got retval:0 (PASS)
        [1057874242] alarm(2), want retval:1; got retval:1 (PASS)
        [1057874242] alarm(3), want retval:2; got retval:2 (PASS)
        [1057874242] alarm(4), want retval:3; got retval:3 (PASS)
        ...
        [1057874242] alarm(995), want retval:994; got retval:994 (PASS)
        [1057874242] alarm(996), want retval:995; got retval:995 (PASS)
        [1057874242] alarm(997), want retval:996; got retval:996 (PASS)
        [1057874242] alarm(998), want retval:997; got retval:997 (PASS)
        [1057874242] alarm(999), want retval:998; got retval:998 (PASS)
        0/1000 tests failed

where the initial number in brackets is the number of seconds returned
by gettimeofday().

alarm.c on a clean SuSE 8.2 installation with the latest 2.5 kernel with
the following uname output:

        Linux lsb 2.5.74 #1 Mon Jul 7 15:20:34 CDT 2003 i686 unknown \
        unknown GNU/Linux
        
produces this output:

        928 [wes@lsb test]$ ./alarm 1000
        [1057874469] alarm(0), want retval:0; got retval:0 (PASS)
        [1057874469] alarm(1), want retval:0; got retval:0 (PASS)
        [1057874469] alarm(2), want retval:1; got retval:2 (FAIL)
        [1057874469] alarm(3), want retval:2; got retval:3 (FAIL)
        [1057874469] alarm(4), want retval:3; got retval:4 (FAIL)
        ...
        [1057874469] alarm(995), want retval:994; got retval:995 (FAIL)
        [1057874469] alarm(996), want retval:995; got retval:996 (FAIL)
        [1057874469] alarm(997), want retval:996; got retval:997 (FAIL)
        [1057874469] alarm(998), want retval:997; got retval:998 (FAIL)
        [1057874469] alarm(999), want retval:998; got retval:999 (FAIL)
        943/1000 tests failed
        
In every failure, the return value was one greater than the expected
value, and interestingly, the number of failed tests decreased with an
increase in system load (tested using the stress utility --
http://weather.ou.edu/~apw/projects/stress/).

Any ideas?

-- 
Paul "Wes" Hofmann
Linux Technology Center
IBM Corporation
wh@us.ibm.com

-- Begin: alarm.c --

#include <unistd.h>
#include <stdio.h>
#include <sys/time.h>

#define MINVAL 0
#define MAXVAL 10
#define NOALARM 0

int main(int argc, char **argv)
{
    int retval = 0;
    int failed = 0;
    int tests = MAXVAL;
    int prev = 0;
    int curr = 0;
    struct timeval time;

    /* parse args */
    if (argc > 1) 
        if (sscanf(argv[1], "%d", &tests) != 1) 
            return 1;
            
    /* We will create alarms for with a duration of MINVAL
     * seconds through tests seconds, each interrupting the one
     * created before it.  In each case, the number of seconds
     * remaining in the previous call to alarm() should be
     * returned */

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
-- End: alarm.c --

-- Begin: lsmod for kernel 2.4.20 --

        Module                  Size  Used by    Not tainted
        ipv6                  149108  -1 (autoclean)
        isa-pnp                37000   0 (unused)
        mousedev                5236   0 (unused)
        joydev                  6656   0 (unused)
        evdev                   5056   0 (unused)
        input                   5088   0 [mousedev joydev evdev]
        usb-uhci               24944   0 (unused)
        usbcore                70700   1 [usb-uhci]
        raw1394                16436   0 (unused)
        ieee1394               45328   0 [raw1394]
        e100                   56264   1
        snd-intel8x0           23844   0
        snd-pcm                81184   0 [snd-intel8x0]
        snd-timer              15680   0 [snd-pcm]
        snd-ac97-codec         37520   0 [snd-intel8x0]
        snd-mpu401-uart         4880   0 [snd-intel8x0]
        snd-rawmidi            17856   0 [snd-mpu401-uart]
        snd-seq-device          5688   0 [snd-rawmidi]
        snd                    49348   0 [snd-intel8x0 snd-pcm snd-timer
        snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
        soundcore               5668   0 [snd]
        lvm-mod                69828   0 (autoclean)
        reiserfs              200532   1
        
-- End: lsmod for kernel 2.4.20 --

-- Begin: lsmod for kernel 2.5.74 --

        Module                  Size  Used by
        mousedev                5236  0 
        joydev                  5984  0 
        evdev                   5632  0 
        uhci_hcd               23664  0 
        ohci_hcd               13056  0 
        ehci_hcd               18372  0 
        usbcore                76316  5 uhci_hcd,ohci_hcd,ehci_hcd
        raw1394                21068  0 
        ohci1394               24840  0 
        ieee1394               49356  2 raw1394,ohci1394
        e100                   43400  0 
        snd_intel8x0           12836  0 
        snd_ac97_codec         40132  1 snd_intel8x0
        snd_pcm                65828  1 snd_intel8x0
        snd_timer              15812  1 snd_pcm
        snd_page_alloc          4452  2 snd_intel8x0,snd_pcm
        snd_mpu401_uart         3584  1 snd_intel8x0
        snd_rawmidi            14304  1 snd_mpu401_uart
        snd_seq_device          3912  1 snd_rawmidi
        snd                    31972  7
        snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
        soundcore               3968  1 snd
        md                     34592  1 [unsafe]

-- Begin: lsmod for kernel 2.5.74 --
