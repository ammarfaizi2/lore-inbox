Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263301AbTCNITp>; Fri, 14 Mar 2003 03:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263303AbTCNITp>; Fri, 14 Mar 2003 03:19:45 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:29334 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S263301AbTCNITm>;
	Fri, 14 Mar 2003 03:19:42 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Fri, 14 Mar 2003 09:30:27 +0100
To: linux-kernel@vger.kernel.org
Subject: [BUG] nanosleep() granularity bumps up in 2.5.64
Message-ID: <20030314083027.GA28082@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  When playing with select() timeout values I found that granularity
of nanosleep() in 2.5.64 kernel bumps to 256 msec. Trying to get finer
granularity it ends up sleeping to the next multiple of 256 msec
(only for values > 256 msec): see this (for three last kernels) (measured with
attached program):

                            2.5.62       2.5.63       2.5.64
                            ------       ------       ------
nanosleep(0.000):  delay =  0.000 s      0.001 s      0.000 s
nanosleep(0.050):  delay =  0.050 s      0.049 s      0.049 s
nanosleep(0.100):  delay =  0.100 s      0.099 s      0.099 s
nanosleep(0.150):  delay =  0.150 s      0.149 s      0.149 s
nanosleep(0.200):  delay =  0.200 s      0.199 s      0.199 s
nanosleep(0.250):  delay =  0.250 s      0.249 s      0.249 s
nanosleep(0.300):  delay =  0.300 s      0.299 s      0.511 s
nanosleep(0.350):  delay =  0.350 s      0.349 s      0.512 s
nanosleep(0.400):  delay =  0.400 s      0.399 s      0.511 s
nanosleep(0.450):  delay =  0.450 s      0.449 s      0.512 s
nanosleep(0.500):  delay =  0.500 s      0.499 s      0.511 s
nanosleep(0.550):  delay =  0.550 s      0.549 s      0.767 s
nanosleep(0.600):  delay =  0.600 s      0.599 s      0.767 s
nanosleep(0.650):  delay =  0.650 s      0.649 s      0.767 s
nanosleep(0.700):  delay =  0.700 s      0.699 s      0.767 s
nanosleep(0.750):  delay =  0.750 s      0.749 s      0.767 s
nanosleep(0.800):  delay =  0.800 s      0.799 s      1.023 s
nanosleep(0.850):  delay =  0.850 s      0.849 s      1.023 s
nanosleep(0.900):  delay =  0.900 s      0.899 s      1.023 s
nanosleep(0.950):  delay =  0.950 s      0.949 s      1.023 s
nanosleep(1.000):  delay =  1.000 s      0.999 s      1.023 s
nanosleep(1.050):  delay =  1.050 s      1.049 s      1.279 s
nanosleep(1.100):  delay =  1.100 s      1.099 s      1.279 s
nanosleep(1.150):  delay =  1.150 s      1.149 s      1.279 s
nanosleep(1.200):  delay =  1.200 s      1.199 s      1.279 s
nanosleep(1.250):  delay =  1.250 s      1.249 s      1.279 s
nanosleep(1.300):  delay =  1.300 s      1.299 s      1.535 s
nanosleep(1.350):  delay =  1.350 s      1.349 s      1.535 s
nanosleep(1.400):  delay =  1.400 s      1.399 s      1.535 s
nanosleep(1.450):  delay =  1.450 s      1.449 s      1.535 s
nanosleep(1.500):  delay =  1.500 s      1.499 s      1.535 s
nanosleep(1.550):  delay =  1.550 s      1.549 s      1.791 s
nanosleep(1.600):  delay =  1.600 s      1.599 s      1.791 s
nanosleep(1.650):  delay =  1.650 s      1.649 s      1.791 s
nanosleep(1.700):  delay =  1.700 s      1.699 s      1.791 s
nanosleep(1.750):  delay =  1.750 s      1.749 s      1.791 s
nanosleep(1.800):  delay =  1.800 s      1.799 s      2.047 s
nanosleep(1.850):  delay =  1.850 s      1.849 s      2.047 s
nanosleep(1.900):  delay =  1.900 s      1.899 s      2.047 s
nanosleep(1.950):  delay =  1.950 s      1.949 s      2.047 s
nanosleep(2.000):  delay =  2.000 s      1.999 s      2.047 s
....
and so on.

In 2.5.63 there is a conversion to POSIX timers, but that change is O.K.
In the 2.5.64 changelog I didn't found any eye-hitting change.

	Cheers,
		Vita

------------------------------------------------------------------
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <errno.h>

int main (void) {
	struct timespec	req, rem;
	struct timeval	old, new;
	long		tim;
	long		delay;
	int		i;

	gettimeofday(&old, NULL);
	for (delay = 0; delay <= 2000000000L; delay += 50000000L) {
		rem.tv_sec = 0;
		rem.tv_nsec = 0;
		req.tv_sec =  delay / 1000000000L;
		req.tv_nsec = delay % 1000000000L;
		for (i = 0; i < 2; i++) {	/* get only the second measured value */
			int ret;
			gettimeofday(&old, NULL);
			ret = nanosleep(&req, &rem);
			gettimeofday(&new, NULL);
			tim = (new.tv_sec * 1000000 + new.tv_usec) - (old.tv_sec * 1000000 + old.tv_usec);
			if (ret == -1) {
				if (errno == EINTR) {
					printf("EINTR\n");
					i--;
				} else {
					perror("nanosleep()");
					exit(1);
				}
			}
		}
		printf("nanosleep(%ld.%03ld):  delay =  %ld.%03ld s\n", req.tv_sec, req.tv_nsec / 1000000, tim / 1000000, (tim % 1000000) / 1000);
		fflush(stdout);
	}
	return 0;
}
